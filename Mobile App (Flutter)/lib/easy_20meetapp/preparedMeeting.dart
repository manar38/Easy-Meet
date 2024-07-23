import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deaf_project/easy_20meetapp/meeting_option.dart';
import 'package:flutter/material.dart';


class preparedMeeting extends StatefulWidget {
  preparedMeeting({Key? key}) : super(key: key);
  static String id = "Settings";

  @override
  State<preparedMeeting> createState() => _VideoCallState();
}

class _VideoCallState extends State<preparedMeeting> {
  //final AuthMethods _authMethods =AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  // final JitsiMeetingMethods _jitsiMeetMethods = JitsiMeetingMethods();
  bool isAudioMuted = false;
  bool isVideoMuted = false;
  bool isSignUsed = false;
  var s;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    // s = passwor99d;

    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    // JitsiMeet.removeAllListeners();
  }
//  _joinMeeting(){
//    _jitsiMeetMethods.CreateMeeting(
//        roomName: meetingIdController.text,
//        isAudioMuted:isAudioMuted ,
//        isVideoMuted: isVideoMuted,
//       //  username: nameController.text,
//       //  IsModelMuted:

//    );
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pushNamed(context, '/GeneratedHomeWidget');
          },
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 97, 29, 139),
        title: Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              // initialValue: null,

              // onSaved: (newValue){
              //   setState(() {
              //   s = newValue;

              //   });
              // },
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,

              decoration: const InputDecoration(
                  // fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Room ID",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
              // fillColor:
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,

              decoration: const InputDecoration(
                  // fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
              // fillColor:
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /***
           * 
           ****************************** Join Inkwell *****************  
           * 
           *
           */
          InkWell(
            // comment
            onTap: () async {
              /**
               * Check if the room id is exist on Firestore or not .
               */

              
              try {
                await FirebaseFirestore.instance
                    .collection('room_id')
                    .where('room_id', isEqualTo: meetingIdController.text)
                    .get()
                    .then((value) {
                  var fetchedData = value.docs.map((e) => e.data()).first;
                                    Navigator.pushNamed(context, "/Newhome");

                  print('''
*******************************
Room id is exist ✔✔
*******************************
''');

                });
                
              } catch (e) {
                showDialog(
              context: context,
              builder: (context) {
                return
                AlertDialog(
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok",),
                      backgroundColor: Color.fromARGB(255, 97, 29, 139),
                    ),
                  ],
title: Text("Room Id Is Not Exist !"),
content: Text("Please Enter The Correct Id"),

                );
                });
                print('''
*******************************
Room id is not exist !!!
*******************************
''');
              }
            },



            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'join',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
            text: 'Mute Audio',
            isMute: isAudioMuted,
            onChange: onAudioMuted,
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
            text: 'Using Sign Language',
            isMute: isSignUsed,
            onChange: UsingSignLang,
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
            text: 'Turn off My Video',
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          )
        ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  UsingSignLang(bool val) {
    setState(() {
      isSignUsed = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
