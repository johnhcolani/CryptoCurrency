import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/language_provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    var switchIcon = Icon(languageProvider.isEnglishLanguage
    ? Icons.language
    : Icons.language_outlined
    );
    return IconButton(
        onPressed: (){
          languageProvider.toggleLanguage();
        }, icon: switchIcon);
  }
}
