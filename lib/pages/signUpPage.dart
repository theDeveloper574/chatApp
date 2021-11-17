import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newChatApp/function/function.dart';

import '../main.dart';
import 'HomePage.dart';
import 'logInPage.dart';

class signUpPage extends StatefulWidget {

  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  bool isLoading = false;
  method methods = method();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      isLoading == true ?
        Center(
          child: CircularProgressIndicator(),)
          :
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3Waui6tdeyp3S5V8VlY7TkJo0d2HCDqRVg&usqp=CAU", fit: BoxFit.cover,)
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              child: Text("Create an Account", style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 10, left: 30, right: 30),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 10, left: 30, right: 30),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 4, left: 30, right: 30),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  labelText: "password",
                  border: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 4, left: 30, right: 30),
              child: TextFormField(
                controller: passwordC,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  labelText: "Confirm password",
                  border: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey)
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                // print("Button Pressed");


                if(name.text.isNotEmpty &&  email.text.isNotEmpty &&  password.text.isNotEmpty &&  passwordC.text.isNotEmpty)
                {
                  print('All feilds are filled');
                  if(password.text == passwordC.text){
                    print("All is good");
                    methods.signUp(name.text.toString(), email.text.toString(), password.text.toString());
                    if(FirebaseAuth.instance.currentUser.uid.toString().isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  }
                  else
                    {
                      toastMesg('password & cPasswrd is not matched', Colors.black);
                    }
                }
                else{
                  toastMesg('please fill all feilds', Colors.black);

                }

                // print("+++++++++++++++++");
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.84,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(9.0)
                ),
                child: Center(child: Text("Sign Up", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0
                ),)),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text("Already have an account?", style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => logInPage()));
                  },
                  child: Text("Login", style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }



}
