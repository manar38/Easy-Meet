import 'package:flutter/material.dart';
import 'package:deaf_project/helpers/transform/transform.dart';

/* Text Maciej Kowalski
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedMaciejKowalskiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransformHelper.rotate(
        a: 1.00,
        b: -0.00,
        c: 0.00,
        d: 1.00,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            '''Maciej Kowalski''',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.right,
            style: TextStyle(
              height: 1.171875,
              fontSize: 15.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 255, 255, 255),

              /* letterSpacing: 1.0, */
            ),
          ),
        ));
  }
}