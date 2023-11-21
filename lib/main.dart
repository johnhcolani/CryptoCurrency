

import 'package:advance_crypto_currency/provider/UserDataProvider.dart';
import 'package:advance_crypto_currency/provider/crypto_data_provider.dart';
import 'package:advance_crypto_currency/provider/language_provider.dart';
import 'package:advance_crypto_currency/provider/market_view_provider.dart';
import 'package:advance_crypto_currency/provider/theme_provider.dart';
import 'package:advance_crypto_currency/ui/main_wrapper.dart';
import 'package:advance_crypto_currency/ui/sign_up_screen.dart';
import 'package:advance_crypto_currency/ui/theme_switcher.dart';
import 'package:advance_crypto_currency/ui/ui_helper/language_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
      ChangeNotifierProvider(create: (context)=>MarketViewProvider()),
      ChangeNotifierProvider(create: (context) => UserDataProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({super.key});

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return MaterialApp(
              locale: languageProvider.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('es'), // Spanish
                Locale('tr'), // Spanish
              ],
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              home: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    SharedPreferences sharedPreferences =snapshot.data!;
                    var loggedInState = sharedPreferences.getBool("loggedIn") ?? false;
                    if(loggedInState){
                      return const  MainWrapper();
                    }else{
                      return const SignUpScreen();
                    }
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
              );


          });
      },
    );
  }
}
class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(

      body: MainWrapper()
       // body: SignUpScreen()
    );
  }
}

/*
Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.helloWorld,style: theme.textTheme.titleLarge),
            // Text(
            //     AppLocalizations.of(context)!.helloWorld,style: theme.textTheme.titleSmall,),
          ],
        ),
      ),
 */