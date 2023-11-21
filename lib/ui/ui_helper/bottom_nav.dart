import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  PageController controller;


  BottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context);
    return BottomAppBar(

      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: colorTheme.bottomAppBarTheme.color,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, icon: const Icon(Icons.home)),
                  IconButton(
                      onPressed: () {
                        controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

                      }, icon: const Icon(Icons.bar_chart))
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    controller.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

                  }, icon: const Icon(Icons.person)),
                  IconButton(onPressed: () {
                    controller.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

                  }, icon: const Icon(Icons.bookmark))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
