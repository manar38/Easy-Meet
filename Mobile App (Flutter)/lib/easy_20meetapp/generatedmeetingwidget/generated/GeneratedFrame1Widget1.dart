import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:deaf_project/easy_20meetapp/generatedmeetingwidget/generated/GeneratedNewMeetingWidget.dart';

/* Frame Frame 1
    Autogenerated by FlutLab FTF Generator
  */

final String _roomId = 'room_id';
String generatePassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  int passLength = 16;
  String seed = upper + lower + numbers;
  String password = '';
  List<String> list = seed.split('').toList();
  Random rand = Random();
  for (int i = 0; i < passLength; i++) {
    int index = rand.nextInt(list.length);
    password += list[index];
  }
  return password;
}

/**
 * Generate rood password
 */
var password = generatePassword();

class GeneratedFrame1Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        /**
         *  upload generated password on firestore .
         */
        await FirebaseFirestore.instance
            .collection(_roomId)
            .add({'room_id': password}).then((value) {
          Navigator.pushNamed(context, '/preparedMeeting');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                  title: Text(
                    "Please Copy these ID and Put it in Room ID",
                  ),
                  content: SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "$password", style: TextStyle(fontSize: 20)),
                        // TextSpan(text: "Copy me", style: TextStyle(color: Colors.red)),
                        // TextSpan(text: " and leave me"),
                      ],
                    ),
                  ),
                );
              });
          print(password);
        });
      },
      child: Container(
        width: 340.0,
        height: 51.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            // overflow: Overflow.visible,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  color: Color.fromARGB(255, 97, 29, 139),
                ),
              ),
              Positioned(
                left: 102.0,
                top: 10.0,
                right: null,
                bottom: null,
                width: 138.0,
                height: 33.0,
                child: GeneratedNewMeetingWidget(),
              )
            ]),
      ),
    );
  }
}