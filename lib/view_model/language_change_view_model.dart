import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeViewModel  with ChangeNotifier{

  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  void changeLocale(Locale type) async{
SharedPreferences sp = await SharedPreferences.getInstance();

_appLocale = type;

if(type == Locale('en')){
  await sp.setString('language_code', 'en');
}
else{
  await sp.setString('language_code', 'es');
}
notifyListeners();
  }
}