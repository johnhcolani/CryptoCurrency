import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  var conntroller;
   HomePageView({super.key,required this.conntroller});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  var images =[
    'assets/images/a1.jpeg',
    'assets/images/a2.jpeg',
    'assets/images/a3.jpeg',
    'assets/images/a4.jpeg',

  ];
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.conntroller,
      children: [
        myPages(images[0]),
        myPages(images[1]),
        myPages(images[2]),
        myPages(images[3]),
      ],
    );
  }
}
Widget myPages(String image){
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    child: Image(image: AssetImage(image),fit: BoxFit.cover,),
  );
}