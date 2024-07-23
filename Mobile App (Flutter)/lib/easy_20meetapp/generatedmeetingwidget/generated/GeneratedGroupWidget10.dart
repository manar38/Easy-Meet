import 'package:flutter/material.dart';
import 'package:deaf_project/helpers/transform/transform.dart';
import 'package:deaf_project/easy_20meetapp/generatedmeetingwidget/generated/GeneratedVectorWidget53.dart';
import 'package:deaf_project/easy_20meetapp/generatedmeetingwidget/generated/GeneratedVectorWidget54.dart';

/* Group Group
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedGroupWidget10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.999520301818848,
      height: 5.476593494415283,
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
         // overflow: Overflow.visible,
          children: [
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              bottom: 0.0,
              width: null,
              height: null,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                double percentWidth = 0.6495955702373342;
                double scaleX =
                    (constraints.maxWidth * percentWidth) / 6.4956440925598145;

                double percentHeight = 1.0;
                double scaleY =
                    (constraints.maxHeight * percentHeight) / 5.476593494415283;

                return Stack(children: [
                  TransformHelper.translateAndScale(
                      translateX: 0,
                      translateY: 0,
                      translateZ: 0,
                      scaleX: scaleX,
                      scaleY: scaleY,
                      scaleZ: 1,
                      child: GeneratedVectorWidget53())
                ]);
              }),
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              bottom: 0.0,
              width: null,
              height: null,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                double percentWidth = 0.2514060694935756;
                double scaleX =
                    (constraints.maxWidth * percentWidth) / 2.5139400959014893;

                double percentHeight = 0.9968900978986176;
                double scaleY =
                    (constraints.maxHeight * percentHeight) / 5.459561824798584;

                return Stack(children: [
                  TransformHelper.translateAndScale(
                      translateX: constraints.maxWidth * 0.7486035392360912,
                      translateY: constraints.maxHeight * 0.0026784929262852726,
                      translateZ: 0,
                      scaleX: scaleX,
                      scaleY: scaleY,
                      scaleZ: 1,
                      child: GeneratedVectorWidget54())
                ]);
              }),
            )
          ]),
    );
  }
}
