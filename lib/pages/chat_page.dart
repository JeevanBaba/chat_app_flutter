import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller for the message input field
  final TextEditingController messageController = TextEditingController();

  // chat and authenticaion services
  final ChatService chatService = ChatService();
  final AuthenticationService authService = AuthenticationService();

  //for text field focus
  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay to ensure the keyboard is shown
        // the ammount of remaining space is calculated
        //then scroll down
        Future.delayed(Duration(milliseconds: 300), () {
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
          }
        });
      }
    });
    // wait a bit for list to load, then scroll down
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message
  void sendMessage() async {
    // if there is something in the message input field
    if (messageController.text.isNotEmpty) {
      // send the message
      await chatService.sendMessage(widget.receiverID, messageController.text);

      // clear the message input field
      messageController.clear();

      // scroll down to the bottom of the list
      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    // light mode and dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.receiverEmail,
          style: TextStyle(
            color:
                isDarkMode
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onTertiary,
            fontFamily: 'NUSAR',
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            (isDarkMode
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onTertiary),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(child: buildmessageList()),

          // user input field
          buildUserInput(),
        ],
      ),
    );
  }

  // build the message list
  Widget buildmessageList() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // list of messages
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // check if the current user is the sender
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;
    // set alignment based on sender
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  // build message input field
  Widget buildUserInput() {
    // light mode and dark mode for send button
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // textfield should take up all the space
          Expanded(
            child: CustomTextField(
              controller: messageController,
              hintText: 'Type a message',
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),

          // send button
          Container(
            decoration: BoxDecoration(
              color: (isDarkMode ? Colors.blue[600] : Colors.blue[200]),
              borderRadius: BorderRadius.circular(50),
            ),
            margin: EdgeInsets.only(right: 25.0),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color:
                    (isDarkMode
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Theme.of(context).colorScheme.inversePrimary),
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
