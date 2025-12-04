import 'package:flutter/material.dart';
import 'package:flutter_application_1/contact.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [
    Contact("Ali", "09136336002"),
    Contact("Mohammad", "09136336003"),
    Contact("Hassan", "09136336004"),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact App")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Contact"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hint: Text("Name")),
                    ),
                    TextField(
                      controller: mobileController,
                      decoration: InputDecoration(hint: Text("Mobile")),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Contact newContact = Contact(
                        nameController.text,
                        mobileController.text,
                      );

                      setState(() {
                        contacts.add(newContact);
                        mobileController.clear();
                        nameController.clear();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: contacts
            .map((e) => ListTile(title: Text(e.name), trailing: Text(e.mobile)))
            .toList(),
      ),
    );
  }

  List<Widget> convertToWidget() {
    List<Widget> lst = [];
    for (var contact in contacts) {
      //
      lst.add(
        ListTile(title: Text(contact.name), trailing: Text(contact.mobile)),
      );
    }
    return lst;
  }
}
