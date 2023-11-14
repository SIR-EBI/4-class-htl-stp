import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              "",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () => {
              Navigator.pushNamed(context, "/shopSide"),
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text("Orders"),
            onTap: () => {
              Navigator.pushNamed(context, "/orderSide"),
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage products"),
            onTap: () => {
              Navigator.pushNamed(context, "/manageSide"),
            },
          ),
        ],
      ),
    );
  }
}
