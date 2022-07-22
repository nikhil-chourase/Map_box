import 'package:flutter/material.dart';
import 'package:map_box/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'map_screen.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;


  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value){
                    email = value;
                  },
                  decoration: kTextfeildDecoration.copyWith(hintText: 'enter your email'),

                ),
                SizedBox(height: 8.0,),
                TextField(
                  onChanged: (value){
                    password = value;

                  },
                  decoration: kTextfeildDecoration.copyWith(hintText: 'enter your password'),
                ),
                SizedBox(height: 15.0,),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(23.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async{

                        try {
                          final user =  await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if(user!=null){
                            Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return MapScreen();
                                  }
                              ),
                            );

                          }
                        }catch(e){
                          print(e);
                        }



                      },
                      height: 42.0,
                      minWidth: 200.0,
                      child: Text('login',style: TextStyle(color: Colors.white),),


                    ),
                  ),
                ),
              ],

            ),
          ),
        ),
      ),

    );
  }
}
