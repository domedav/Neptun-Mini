import 'package:connectivity_plus/connectivity_plus.dart';

/// Checks if the user is connected online
class AppConnection{
  /// Instance of the connectivity class
  static Connectivity? _connectivity;

  /// 2 = Unlimited
  /// 1 = Datasaver
  /// 0 = No net
  static int _connectivityState = 0;

  /// Set up the callbacks for connectivity
  static Future<void> initializeConnection()async{
    if(_connectivity != null){
      throw "Connectivity initialized multiple times";
    }
    _connectivity = Connectivity();
    _connectivity!.onConnectivityChanged.listen(_onConnectivity);

    // Run a check for connections
    _onConnectivity(await _connectivity!.checkConnectivity());
  }

  /// Callback for changes
  static void _onConnectivity(List<ConnectivityResult> list){
    if(list.contains(ConnectivityResult.wifi) || list.contains(ConnectivityResult.ethernet)){ // check wifi/ethernet first, we can have mobiledata here, but OS prioritizes unlimited
      // Unlimited access for networking
      _connectivityState = 2;
    }
    else if(list.contains(ConnectivityResult.mobile)){ // check mobiledata state, as no wifi
      // Datasaver behaviour
      _connectivityState = 1;
    }
    else{
      // No internet
      _connectivityState = 0;
    }
  }

  /// Does the user have internet
  static bool hasInternet(){
    return _connectivityState > 0;
  }

  /// Does the user have mobiledata on
  static bool isDatasaver(){
    return _connectivityState == 1;
  }
}