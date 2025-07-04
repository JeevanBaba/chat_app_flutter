import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // light mode and dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              (isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                (isDarkMode
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.tertiary),
            width: 3,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).colorScheme.onSurface,
          //     blurRadius: 0,
          //     offset: Offset(0, 0), // changes position of shadow
          //   ),
          // ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // icon
            Icon(
              Icons.person,
              color:
                  (isDarkMode
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.onTertiary),
              size: 30,
            ),
            SizedBox(width: 20),
            // username
            Text(
              text,
              style: TextStyle(
                color:
                    (isDarkMode
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Theme.of(context).colorScheme.onTertiary),
                fontSize: 18,
                // fontFamily: 'NUSAR',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
