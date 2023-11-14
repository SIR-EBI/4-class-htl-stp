import 'package:flutter/material.dart';

import '../../default/custom_colors.dart';

class CustomNavigationBar extends StatelessWidget {
  final int index;

  const CustomNavigationBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: CustomColor.dark1,
      selectedItemColor: CustomColor.blue1,
      unselectedItemColor: CustomColor.white0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          tooltip: "Search",
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          tooltip: "Shopping lists",
          label: "Shopping lists",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          tooltip: "Account",
          label: "Account",
        ),
      ],
      onTap: ((index) {
        if (index == 0) {
          Navigator.popAndPushNamed(context, "/searchScreen");
        } else if (index == 1) {
          Navigator.popAndPushNamed(context, "/listScreen");
        } else if (index == 2) {
          Navigator.popAndPushNamed(context, "/userScreen");
        }
      }),
    );
  }
}
