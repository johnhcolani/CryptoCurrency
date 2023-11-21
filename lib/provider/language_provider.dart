import 'package:flutter/widgets.dart';

class LanguageProvider extends ChangeNotifier{
  Locale locale = const Locale('en');
  bool get isEnglishLanguage=> locale == const Locale('en');
  bool get isTurkishLanguage=> locale == const Locale('tr');

  void toggleLanguage(){
    locale = isEnglishLanguage ?const Locale('es') : (isTurkishLanguage ? const Locale('en') : const Locale('tr'));
    locale = locale == const Locale('en') ? const Locale('es') :const Locale('en');
    notifyListeners();
  }
  void setLocale(Locale newLocale){
    locale = newLocale;
    notifyListeners();
  }
}
