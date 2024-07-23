import 'package:deaf_project/easy_20meetapp/chatBubble.dart';
import 'package:deaf_project/easy_20meetapp/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

// import 'package:login_register/model/message.dart';
// import 'package:login_register/widget/chatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class chatPage extends StatelessWidget {
  
  static String id = 'chatPage';
  TextEditingController controller=TextEditingController();
   CollectionReference messages = FirebaseFirestore.instance.collection('messages');
final _controller =ScrollController();
  @override
  Widget build(BuildContext context) {
   var email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt',descending: true).snapshots (),
      builder: (context, snapshot) {
        
        if (snapshot.hasData){
         // print(snapshot.data!.docs[0]['text']);
         List <Message> messageList=[];
         for(int i=0;i<snapshot.data!.docs.length;i++){
          messageList.add(Message.fromJson(snapshot.data!.docs[i]));
         }
          return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.close),
          onPressed: (){
             Navigator.pushNamed(context, '/GeneratedHomeWidget');
          }
          ),
          title: Padding(
              padding: EdgeInsets.only(left: 70), child: Text('Video Chat')),
          backgroundColor: Color.fromARGB(255, 97, 29, 139),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _controller,
              itemCount: messageList.length,
              itemBuilder: ((context, index) {
                return messageList[index].id==email? chatBubble(
                  message: messageList[index],
                  ):chatBubble2( message: messageList[index],);
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                messages.add({
                  'text':value,
                  'createdAt':DateTime.now(),
                  'id':email,
                  // 'id':id
                });
                //to clear text field after each time i write message
                controller.clear();
                _controller.animateTo(
                 // _controller.position.maxScrollExtent,
                 0,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                  hintText: 'Send Text',
                  suffixIcon: Icon(
                    Icons.send,
                    color: Color(0xFF621E8B),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 5, 117, 119))),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 35, 0, 53)))),
            ),
          )
        ]),
        );
        }
        else {
          return Text('loading ....');
        }
        
      });
  }
}
