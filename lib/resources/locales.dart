import 'dart:io';
/// App locales provided by this class
class AppLocales{
  /// cached locale, so no need to fetch every time, when no changes
  static AppLocale? _cachedLocale;
  /// get current locale on the current platform
  static AppLocale getCurrentLocale(){
    if(_cachedLocale != null){
      return _cachedLocale!;
    }
    final currentLocale = Platform.localeName.toLowerCase();
    if(currentLocale.isEmpty){
      _cachedLocale = AppLocale.none;
    }
    if(currentLocale.startsWith('hu')){
      _cachedLocale = AppLocale.hu;
    }
    else if(currentLocale.startsWith('de')){
      _cachedLocale = AppLocale.de;
    }
    else if(currentLocale.startsWith('es')){
      _cachedLocale = AppLocale.es;
    }
    else{
      _cachedLocale = AppLocale.en; // unsupported language / english => everyone speaks it
    }
    return _cachedLocale!;
  }

  /// reset cached locale value, should only be called, when locale is changed
  static void resetLocale(){
    _cachedLocale = null;
  }
}

enum AppLocale{
  none,
  hu,
  en,
  de,
  es
}