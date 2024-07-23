import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:login_register/chatPage.dart';
// import 'package:login_register/JoinORCreate_M.dart';
// import 'package:login_register/model/Settings.dart';
// import 'package:login_register/widget/preparedMeeting.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //const HomePage({Key key}) : super (key: key);
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, _password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
              title: Text("Sign In"), backgroundColor: Color.fromARGB(255, 97, 29, 139)),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //  Center(child: Text("Login page")),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 160,
                        //child: Image.asset('images/logo2.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0, left: 15.0),
                    child: TextFormField(
                      validator: (value) {
                          if (value!.isEmpty) {
                            return 'field is required';
                          }
                        },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter email '
                          ),
                          onChanged: ((value) {
                          email = value;
                        }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                    child: TextFormField(
                      validator: (value) {
                          if (value!.isEmpty) {
                            return 'field is required';
                          }
                        },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter  password '),
                          onChanged: ((value) {
                          _password = value;
                        }),
                    ),
                  ),
                 
            
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                var auth = FirebaseAuth.instance;
                                UserCredential user =
                                    await auth.signInWithEmailAndPassword(
                                        email: email!, password: _password!);
                                 print(user.user!.displayName);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('success')));
                                    // Navigator.pushNamed(context, HomePage.id,arguments: email);
                                    Navigator.pushNamed(context, "/GeneratedIntro1Widget",arguments: email);
                                // Navigator.pop(context);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'user-not-found')));
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('wrong-password')));
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            } else {}
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 97, 29, 139),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 80,
                            height: 50,
                            child: Center(child: Text("Sign In",style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),)),
                          )
            
                          // primary: Colors.deepPurple,
                          // textStyle: TextStyle(fontSize: 10.0 ,backgroundColor: Colors.deepPurple,fontWeight: FontWeight.bold )
            
                          ),
                    ),
                  ),
                   Center(
                    child: TextButton(
                        onPressed: () {
                                  Navigator.pushNamed(context, "/GeneratedHomeWidget");
                          
                        },
                        child: Text("Use Trial"),
                        style:
                            TextButton.styleFrom(primary:Color.fromARGB(255, 97, 29, 139))),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
