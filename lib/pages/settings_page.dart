import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // light mode and dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('SETTINGS',
            style: TextStyle(
              fontFamily: 'NUSAR',
            )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            (isDarkMode
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onTertiary),
      ),
      body: Container(
        decoration: BoxDecoration(
          color:
              (isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: EdgeInsets.all(25.0),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dark mode
            Text(
              'Dark Mode',
              style: TextStyle(
                color:
                    (isDarkMode
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Theme.of(context).colorScheme.onTertiary),
                fontFamily:'NUSAR',
                fontSize: 16,
              ),
            ),
            // ToggleSwitch
            CupertinoSwitch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged:
                  (value) =>
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
