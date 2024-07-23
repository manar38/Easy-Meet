import 'package:flutter/material.dart';
import 'dart:math';

 String generatePassword() {
 String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 String lower = 'abcdefghijklmnopqrstuvwxyz';
 String numbers = '1234567890';
 int passLength = 16;
 String seed = upper + lower + numbers ;
 String password = '';
 List<String> list = seed.split('').toList();
 Random rand = Random();
 for (int i = 0; i < passLength; i++) {
 int index = rand.nextInt(list.length);
 password += list[index];
 }
 return password;
 }
 var password=generatePassword();


class createLink extends StatelessWidget {
   createLink({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:TextButton(child: Text("clickhere"),onPressed:generatePassword ,)
      // Container(
      //   child: RichText(
      //       text: TextSpan(
      //           children: [

                  
      //             TextSpan(
      //                 // style: defaultText,
      //                 text: "To learn more "
      //             ),
      //             TextSpan(
      //                 // style: linkText,
      //                 text: "Click here",
      //                 // recognizer: TapGestureRecognizer()..onTap =  () async{
      //                 //   var url = "https://www.youtube.com/channel/UCwxiHP2Ryd-aR0SWKjYguxw?view_as=subscriber";
      //                 //   if (await canLaunch(url)) {
      //                 //     await launch(url);
      //                 //   } else {
      //                 //     throw 'Could not launch $url';
      //                 //   }
      //                 // }
      //             ),

                 
      //           ]
      //       ))
      //   ,
      // ),
    );
  }
}
