import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:deaf_project/easy_20meetapp/generatedmeetingwidget/generated/GeneratedJoinameetingWidget.dart';

/* Frame Frame 2
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedFrame2Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/preparedMeeting'),
      child: Container(
        // width: 340.0,
        // height: 51.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            width: 3.0,
            color: Color.fromARGB(255, 97, 29, 139),
          ),
          boxShadow: kIsWeb
              ? []
              : [
                  BoxShadow(
                    color: Color.fromARGB(63, 0, 0, 0),
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4.0,
                  )
                ],
        ),
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
           // overflow: Overflow.visible,
            children: [
              Positioned(
                // left: 91.5,
                // top: 10.0,
                // right: null,
                // bottom: null,
                // width: 159.0,
                // height: 33.0,
                child: GeneratedJoinameetingWidget(),
              )
            ]),
      ),
    );
  }
}
