import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/constructors_championship.dart';
import '../screens/drivers_championship.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('F1 Stats'),
          ),
          ListTile(
            title: const Text('Race Results'),
            onTap: () {
              Navigator.pushNamed(context, MyHomePage.id);
            },
          ),
          ListTile(
            title: const Text('Drivers Championship'),
            onTap: () {
              Navigator.pushNamed(context, MyDriversPage.id);
            },
          ),
          ListTile(
            title: const Text('Constructors Championship'),
            onTap: () {
              Navigator.pushNamed(context, MyConstructorsPage.id);
            },
          ),
        ],
      ),
    );
  }
}
