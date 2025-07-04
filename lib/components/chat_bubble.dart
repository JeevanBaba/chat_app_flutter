import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // light mode and dark mode for chat bubble
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color:
            isCurrentUser
                ? (isDarkMode ? Colors.blue[600] : Colors.blue[200])
                : (isDarkMode ? Colors.grey[800] : Colors.white),
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
          color: (isDarkMode ? Colors.white : Colors.black),
          fontSize: 16,
        ),
      ),
    );
  }
}
