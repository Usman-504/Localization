import 'package:app_localization/view/home_view.dart';
import 'package:app_localization/view_model/language_change_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String locale = sp.getString('language_code') ?? '';
  runApp( MyApp(locale: locale,));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> LanguageChangeViewModel()),
    ],
    child: Consumer<LanguageChangeViewModel>(
      builder: (context, vm, child) {
        if (vm.appLocale == null) {
          if (locale.isEmpty) {
            vm.changeLocale(const Locale('en'));
          } else {
            vm.changeLocale(Locale(locale));
          }
        }
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale == '' ? const Locale('en') : vm.appLocale == null ?  Locale(locale)  : Locale(vm.appLocale.toString()),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('es'),
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomeView()
        );
      },

    ),
    );
  }
}

