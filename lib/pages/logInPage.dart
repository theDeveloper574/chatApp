import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newChatApp/function/function.dart';
import 'package:newChatApp/pages/signUpPage.dart';

import '../main.dart';
import 'HomePage.dart';

class logInPage extends StatefulWidget {

  @override
  _logInPageState createState() => _logInPageState();
}

class _logInPageState extends State<logInPage> {
    bool isLoading = false;
    method methods = method();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          isLoading == true ?
              Center(child: CircularProgressIndicator(),)
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
              child: Text("Login", style: TextStyle(
                  color: Colors.black,
                 fontSize: 28,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 15, left: 30, right: 30),
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
                obscureText: true,
                controller: password,
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
              padding: const EdgeInsets.only(top: 10,bottom: 20, left: 160),
              child: Text("Forget password?", style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 17,
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
              ),),
            ),
            InkWell(
              onTap: (){
                // setState(() {
                //   isLoading = true;
                // });
                if(password.text.isNotEmpty && email.text.isNotEmpty)
                {
                  if(email.text.toString().contains("@"))
                  {
                   bool result = methods.logIn(email.text.toString(), password.text.toString());

                   if(result == true) {
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                         HomePage()), (Route<dynamic> route) => false);
                   }
                   else
                     {
                       toastMesg("Something Went Wrong", Colors.red);

                     }

                  }
                  else{
                    toastMesg("Invalide Email Address", Colors.red);
                  }

                }
                else{
                  toastMesg("Please Enter Your Name And Password", Colors.black);
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.84,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(9.0)
                ),
                child: Center(child: Text("Login", style: TextStyle(
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
                  padding: const EdgeInsets.only(right: 6),
                  child: Text("Don't have an account?", style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>signUpPage()));
                  },
                  child: Text("Sign Up", style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
