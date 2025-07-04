import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // chat and authenticaion services
  final ChatService chatService = ChatService();
  final AuthenticationService authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    // light mode and dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHAT APP',
          style: TextStyle(
            color:
                (isDarkMode
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onTertiary),
            fontSize: 24,
            fontFamily:'NUSAR',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.signOut();
            },
          ),
        ],
        // backgroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            (isDarkMode
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onTertiary),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  //build a list of users except the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(), Text('Loading...')],
            ),
          );
        }
        // return list of users
        return ListView(
          children:
              snapshot.data!
                  .map<Widget>(
                    (userData) => _buildUserListItem(userData, context),
                  )
                  .toList(),
        );
      },
    );
  }

  // for building individual user list lite for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // display all users except the current logged in user
    if (userData['email'] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          // tapped on user -> navigate to chat screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChatPage(
                    receiverEmail: userData['email'],
                    receiverID: userData['uid'],
                  ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
