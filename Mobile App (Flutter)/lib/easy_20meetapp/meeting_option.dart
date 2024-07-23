import 'package:flutter/material.dart';
class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChange;
  const MeetingOption({Key? key,required this.text,
    required this.isMute, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color:Color.fromARGB(255, 97, 29, 139),
      margin: EdgeInsets.all(20),
      child: Row(
        

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),

            ),
          ),
          Switch(value: isMute, onChanged: onChange,activeColor: Color.fromARGB(255, 32, 1, 37),inactiveTrackColor: Colors.white,)
        ],
      ),
    );
  }
}
