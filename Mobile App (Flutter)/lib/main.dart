import 'package:deaf_project/easy_20meetapp/SignIn.dart';
import 'package:deaf_project/easy_20meetapp/SignUp.dart';
import 'package:deaf_project/easy_20meetapp/SpeechToText.dart';
import 'package:deaf_project/easy_20meetapp/chatPage.dart';
import 'package:deaf_project/easy_20meetapp/generatedchattingwidget/GeneratedChattingWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedhomewidget/GeneratedHomeWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedintro1widget/GeneratedIntro1Widget.dart';
import 'package:deaf_project/easy_20meetapp/generatedintro2widget/GeneratedIntro2Widget.dart';
import 'package:deaf_project/easy_20meetapp/generatedlogo4widget/GeneratedLogo4Widget.dart';
import 'package:deaf_project/easy_20meetapp/generatedmainwidget/GeneratedMainWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedmeet_join_idwidget/GeneratedMeet_join_idWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedmeetingwidget/GeneratedMeetingWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedquickservicewidget/GeneratedQuickServiceWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedsign_textwidget/GeneratedSign_textWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedspeech_textwidget/GeneratedSpeech_textWidget.dart';
import 'package:deaf_project/easy_20meetapp/generatedsplashwidget/GeneratedSplashWidget.dart';
import 'package:deaf_project/easy_20meetapp/newhome.dart';
import 'package:deaf_project/easy_20meetapp/preparedMeeting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:camera/camera.dart';
List<CameraDescription> cameras = <CameraDescription>[];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Easy_20MeetApp());
}

class Easy_20MeetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Deaf project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    // home: Newhome(),
      initialRoute: '/GeneratedSplashWidget',
      routes: {
        '/GeneratedIntro1Widget': (context) => GeneratedIntro1Widget(),
        '/GeneratedSplashWidget': (context) => GeneratedSplashWidget(),
        '/GeneratedLogo4Widget': (context) => GeneratedLogo4Widget(),
        '/GeneratedIntro2Widget': (context) => GeneratedIntro2Widget(),
        '/chatPage': (context) => chatPage(),
        // '/GeneratedSignInWidget': (context) => GeneratedSignInWidget(),
        '/SpeechScreen':(context)=>SpeechScreen(),
        // '/GeneratedSignUpWidget': (context) => GeneratedSignUpWidget(),
        '/SignIn': (context) => SignIn(),
        '/SignUp': (context) => SignUp(),
        '/preparedMeeting': (context) => preparedMeeting(),
        // '/SpeechScreen': (context) => SpeechScreen(),
        '/Newhome': (context) => Newhome(),

        '/GeneratedQuickServiceWidget': (context) =>
            GeneratedQuickServiceWidget(),
        '/GeneratedMeetingWidget': (context) => GeneratedMeetingWidget(),
        '/GeneratedMeet_join_idWidget': (context) =>
            GeneratedMeet_join_idWidget(),
        '/GeneratedSpeech_textWidget': (context) =>
            GeneratedSpeech_textWidget(),
        '/GeneratedChattingWidget': (context) => GeneratedChattingWidget(),
        '/GeneratedHomeWidget': (context) => GeneratedHomeWidget(),
        '/GeneratedMainWidget': (context) => GeneratedMainWidget(),
        '/GeneratedSign_textWidget': (context) => GeneratedSign_textWidget(),
      },
    );
  }
}
