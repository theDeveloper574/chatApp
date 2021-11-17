



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class method {
  saveUserInfor(String name, String email, var password){
    print("SaveUserInfo Run");
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid.toString()).set(
          {
            "name" : name,
            "email" :email,
            "password" : password,
            "uid" : FirebaseAuth.instance.currentUser.uid.toString(),
            // img: imgDownloadLink,
          });

  }
  //SignUp funtion for
  bool signUp(String name, String email, String password){
    print("Signup Run");

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim())
        .then((value) =>saveUserInfor(name, email,password)
    );
    return true;
  }
  //this fun is for the login page
  bool logIn(String email,String password){
    print("log in runs");
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    if(FirebaseAuth.instance.currentUser.uid == null)
      {
        return false;
      }
    else
      {
        return true;
      }
  }


}
