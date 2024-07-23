import 'package:deaf_project/easy_20meetapp/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:login_register/model/message.dart';
class chatBubble extends StatelessWidget {
    const chatBubble({
      Key? key,
      required this.message
    }) : super(key: key);
  final Message message;
    @override
    Widget build(BuildContext context) {
      return Align(
        alignment: Alignment.centerLeft,
        
        child: Container(
          
          padding: EdgeInsets.all( 20),
          //alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(16),
          
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 97, 29, 139),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)
              )
        
          ),
          child: Text(
            message.message
          ,style: TextStyle(color: Colors.white),),
        ),
      );
    }
  }



  class chatBubble2 extends StatelessWidget {
    const chatBubble2({
      Key? key,
      required this.message
    }) : super(key: key);
  final Message message;
    @override
    Widget build(BuildContext context) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all( 20),
          //alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(16),
          
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 208, 134, 221),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32)
              )
        
          ),
          child: Text(
            message.message
          ,style: TextStyle(color: Colors.white),),
        ),
      );
    }
  }