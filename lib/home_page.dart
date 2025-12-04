import 'package:flutter/material.dart';
import 'package:flutter_application_1/message.dart';

class HomePage extends StatelessWidget {
  Message message1 = Message("Ali", "سلام. خوبی؟", "12:00 PM");

  List<Message> messages = [
    Message("Ali", "سلام. خوبی؟", "12:00 PM"),
    Message("Mohammad", "سلام. خوبی؟", "12:00 PM"),
    Message("Hassan", "سلام. خوبی؟", "12:00 PM"),
    Message("Hossein", "سلام. خوبی؟", "12:00 PM"),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          messages.add(Message("Ahmad", "پیام جدید", "13:00 PM"));
        },
        child: Icon(Icons.add),
      ),
      body: ListView(children: buildMessages(messages)),
    );
  }

  List<Widget> buildMessages(List<Message> messages) {
    List<Widget> messageWidgets = [];

    for (var message in messages) {
      Widget messageWidget = Card(
        child: ListTile(
          title: Text(message.title),
          subtitle: Text(message.subtitle),
          trailing: Text(message.time),
          onTap: () {},
        ),
      );

      messageWidgets.add(messageWidget);
    }
    return messageWidgets;
  }
}
