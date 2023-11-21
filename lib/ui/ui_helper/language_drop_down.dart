import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return DropdownButton<String>(
      value: languageProvider.locale.languageCode,
      onChanged: (String? newValue) {
        if (newValue != null) {
          languageProvider.setLocale(Locale(newValue));
        }
      },
      items: <String>['en', 'es','tr'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Text(value.toUpperCase()),
             const  SizedBox(width: 8),
              _getCountryFlag(value),
            ],
          ),
        );
      }).toList(),
    );
  }
  Widget _getCountryFlag(String countryCode){
    String flagImage = '';
    switch (countryCode){
      case 'en':
        flagImage = 'assets/flags/us.png';
        break;
      case 'tr':
        flagImage = 'assets/flags/tr.png';
        break;
      case 'es':
        flagImage = 'assets/flags/es.png';
        break;
      default:
        flagImage = 'assets/flags/us.png';
    }
    return Image.asset(
      flagImage,
      width: 24,
      height: 24,
    );
  }
}

