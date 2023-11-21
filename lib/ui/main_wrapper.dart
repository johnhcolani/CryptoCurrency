import 'package:advance_crypto_currency/ui/home_page.dart';
import 'package:advance_crypto_currency/ui/profile_page.dart';
import 'package:advance_crypto_currency/ui/ui_helper/bottom_nav.dart';
import 'package:advance_crypto_currency/ui/watch_list_page.dart';
import 'package:flutter/material.dart';

import 'market_view_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor.floatingActionButtonTheme.backgroundColor,
shape: const CircleBorder(),
        onPressed: (){},
        child:  Icon(Icons.compare_arrows_outlined,color: themeColor.iconTheme.color,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNav(controller: _myPage,),
      body: PageView(
        controller: _myPage,
        children:   const [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage(),
        ],
      ),
    );
  }
}
