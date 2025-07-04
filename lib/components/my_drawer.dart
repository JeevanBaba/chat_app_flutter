import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout function
  void logout() {
    // authentication service
    final auth = AuthenticationService();
    // sign out
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // light mode and dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: (isDarkMode? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.onSurface),
                    size: 40,
                  ),
                ),
              ),
              // home list tile
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      title: Text('HOME',
                      style: TextStyle(
                        fontFamily: 'NUSAR',
                        fontSize: 18,
                      )
                      ),
                      leading: Icon(Icons.home),
                      onTap: () {
                        // pop drawer
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // settings list tile
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      title: Text('SETTINGS',
                          style: TextStyle(
                            fontFamily: 'NUSAR',
                            fontSize: 18,
                          )
                      ),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        // pop drawer
                        Navigator.pop(context);
                        // navigate to settings page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          // logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: Text(' LOGOUT',
                  style: TextStyle(
                    fontFamily: 'NUSAR',
                    fontSize: 18,
                  )
              ),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
