import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
          color: Colors.white.withOpacity(0.7), fontSize: 22, fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white54, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.blueAccent[700],
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white,opacity: 0.8),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF806107)),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF806107)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor:Color(0xFF806107) ),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white )
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
          color: Colors.black38.withOpacity(0.7), fontSize: 22, fontWeight: FontWeight.bold,),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.black,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blueAccent,
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white,opacity: 0.8),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.amber),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.amber),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor:Colors.amber ),
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.white)
  );
}
