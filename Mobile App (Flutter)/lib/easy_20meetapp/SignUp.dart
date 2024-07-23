import 'package:deaf_project/easy_20meetapp/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import 'package:login_register/SignIn.dart';

// import 'JoinORCreate_M.dart';

class SignUp extends StatefulWidget {
 static String id='SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //const HomePage({Key key}) : super (key: key);
  String? _email, _password;
static String id ='SignUp';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text("Sign Up"), backgroundColor: Color.fromARGB(255, 97, 29, 139)),
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

                  // Padding(padding: EdgeInsets.only(right: 15.0 ,left: 15.0 , top: 15),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         fillColor: Colors.white,
                  //         border: OutlineInputBorder(),
                  //         labelText: 'First Name',
                  //         hintText: 'Enter First Name or name you want'
                  //     ),
                  //   ),
                  // ),

                  // Padding(padding: EdgeInsets.only(right: 15.0 ,left: 15.0 , top: 15),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         fillColor: Colors.white,
                  //         border: OutlineInputBorder(),
                  //         labelText: 'Last name',
                  //         hintText: 'Enter Last Name'
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 15),
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
                        hintText: 'Enter valid email ',
                      ),
                      onChanged: ((value) {
                        _email = value;
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
                          hintText: 'Enter secure password '),
                      onChanged: ((value) {
                        _password = value;
                      }),
                    ),
                  ),

                  Center(
                    child: GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {
                              
                            });
                            try {
                              var auth = FirebaseAuth.instance;
                              UserCredential user =
                                  await auth.createUserWithEmailAndPassword(
                                      email: _email!, password: _password!);
                              // print(user.user!.displayName);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('success')));
                                  Navigator.pushNamed(context, "GeneratedHomeWidget");
                                 // Navigator.pop(context);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'weak password , password must be greatter than 6 character')));
                              } else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('email-already-in-use')));
                              }
                            }
                            isLoading = false;
                            setState(() {
                              
                            });
                          } else {}
                        },
                        
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 97, 29, 139),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 60,
                            height: 40,
                            child: Center(child: Text("Sign Up",
                            style: TextStyle(color: Colors.white),)),
                          ),
                        )

                        // primary: Colors.deepPurple,
                        // textStyle: TextStyle(fontSize: 10.0 ,backgroundColor: Colors.deepPurple,fontWeight: FontWeight.bold )

                        ),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignIn();
                          }));
                        },
                        child: Text("Already have Account!"),
                        style:
                            TextButton.styleFrom(primary: Color.fromARGB(255, 97, 29, 139))),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignIn();
                          }));
                        },
                        child: Text("Sign In"),
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
