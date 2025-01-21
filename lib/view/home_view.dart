import 'package:app_localization/view_model/language_change_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum Language {
  english, spanish
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.helloWorld),
        actions: [
          Consumer<LanguageChangeViewModel>(
            builder: (context, vm, child) {
              return PopupMenuButton(
                onSelected: (Language item){
                  if(Language.english.name == item.name){
                    vm.changeLocale(Locale('en'));

                  }
                  else{

                    vm.changeLocale(Locale('es'));
                  }
                },
                itemBuilder: (context) =>   <PopupMenuEntry<Language>>[
                  const PopupMenuItem(
                      value: Language.english,
                      child: Text('English')),
                  const PopupMenuItem(
                      value: Language.spanish,
                      child: Text('Spanish')),
                ],);
            },

          )
        ],
      ),
    );
  }
}
