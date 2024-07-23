import 'package:flutter/foundation.dart';

class Message
{
  //final String email;
  final String message;
  final String id;
  
  Message(this.message, this.id);
factory Message.fromJson(jsonData){
  return Message(jsonData['text'],jsonData['id']);
}
}

