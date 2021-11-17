import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newChatApp/Models/MsgModel.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {
  String ds;

  ChatPage(this.ds);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //Packeg var;
  bool isRecording = false;
  String audioPath;
  Timer timer;
  int tick = 0;
  double db = 0;
  File img;
  bool iRecording = false;

  @override
  Widget build(BuildContext context) {

// String currentUserUID;
    TextEditingController Msg = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("mesg")
                    .doc(FirebaseAuth.instance.currentUser.uid.toString())
                    .collection("Messges")
                    // .where("sendUid", isEqualTo: FirebaseAuth.instance.currentUser.uid.toString() )
                    // .where('reveverUid', isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (context, dataSnapShot) {
                  return !dataSnapShot.hasData
                      ? Center(
                          child: Text("لا توجد معلومات"), //No data Found
                        )
                      : StaggeredGridView.countBuilder(
                          padding: const EdgeInsets.only(bottom: 200.0),
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = dataSnapShot.data.docs[index];
                            ItemModel model = ItemModel.fromJson(
                                dataSnapShot.data.docs[index].data());
                            return Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                model.senderUid ==
                                        FirebaseAuth.instance.currentUser.uid
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          model.msg != null
                                              ? Container(
                                                  // height: MediaQuery.of(context).size.height,
                                                  // width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Text(
                                                      model.msg,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              :
                                              model.img != null ?
                                          Container(
                                                  height: MediaQuery.of(context).size.height/2,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Image.network(
                                                        model.img),
                                                  ),
                                                )
                                                  :

                                              IconButton(
                                                icon: toggle
                                                    ? Icon(Icons.stop)
                                                    : Icon(
                                                  Icons.play_arrow,color:Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggle = !toggle;
                                                  });
                                                  // _isPlaying
                                                  //     ? flutterStopPlayer(
                                                  //     model.)
                                                  //     : flutterPlaySound(
                                                  //     model.voiceMsg);
                                                },
                                              )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          model.msg != null
                                              ? Container(
                                                  // height: MediaQuery.of(context).size.height,
                                                  // width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Text(
                                                      model.msg,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  // height: MediaQuery.of(context).size.height,
                                                  // width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Image.network(
                                                        model.img),
                                                  ),
                                                ),
                                        ],
                                      ),

                                SizedBox(
                                  height: 3.0,
                                ),
// Divider(thickness: 2.0,),
                              ],
                            );
                          },
                          itemCount: dataSnapShot.data.docs.length,
                        );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.attach_file_outlined),
                        onPressed: () async {
                          File file = await ImagePicker.pickImage(
                              source: ImageSource.gallery);

                          if (file != null) {
                            uploadItemImage(file);
                          }
                        }),
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: Msg,
                          // obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Msg",
                            labelText: "Type Msg Here",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon:
                        Icon(Icons.pause_circle_filled),
                        onPressed: () async {
                          iRecording = false;
                          // _stopRecord();
                          _audioRecorder.stop();
                          _timer?.cancel();
                          print(_filePath);
                          print(_filePath);
                          print(_filePath);
                          print(_filePath);
                          print(_filePath);
                          uploadItemVoice(_filePath);
                          // sendMsg(null, FirebaseAuth.instance.currentUser.uid.toString(), null, _filePath);
                        }
                    ),
                    // SizedBox(),
                    IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () async {
                          setState(() {
                            print("111111111111111");
                            iRecording = true;
                            // startRecord();
                            _startRecording();

                          });


                          }
                        ),
                    IconButton(
                        onPressed: () {
                          sendMsg(
                              Msg.text.toString(),
                              FirebaseAuth.instance.currentUser.uid.toString(),
                              null,null);
                        },
                        icon: Icon(Icons.forward)),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sendMsg(String msg, String Uid, String img,String voice,) {
    FirebaseFirestore.instance
        .collection('mesg')
        .doc(Uid)
        .collection("Messges")
        .doc()
        .set({
      "messg": msg,
      "img": img,
      "sendUid": FirebaseAuth.instance.currentUser.uid.toString(),
      "reveverUid": widget.ds,
      "date": DateTime.now(),
      "voice": voice,

    });

    FirebaseFirestore.instance
        .collection('mesg')
        .doc(widget.ds)
        .collection("Messges")
        .doc()
        .set({
      "messg": msg,
      "img": img,
      "sendUid": FirebaseAuth.instance.currentUser.uid.toString(),
      "reveverUid": widget.ds,
      "date": DateTime.now(),
      "voice": voice,
    });
  }

  ///Image upload
  void uploadItemImage(img) async {
    print("imagepload method run");
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("chatImages");
    UploadTask uploadTask =
        storageReference.child("${DateTime.now()}.jpg").putFile(img);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(imageDownloadUrl);
    print(".....................");
    sendMsg(null, FirebaseAuth.instance.currentUser.uid.toString(),
        imageDownloadUrl,null);
  }

  ///Image upload
  void uploadItemVoice(audioPath) async {

        final Reference storageReference =
    FirebaseStorage.instance.ref().child("chatIdeo");
    UploadTask uploadTask =
    storageReference.child("${DateTime.now()}.mp3").putFile(File(audioPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(imageDownloadUrl);
    print(".....................");
    sendMsg(null, FirebaseAuth.instance.currentUser.uid.toString(),null,
        imageDownloadUrl);
  }





  // Future<dynamic> flutterStopPlayer(url) async {
  //   await flutterSound.stopPlayer().then((value) {
  //     flutterPlaySound(url);
  //     // setState(() {
  //     //   _isPlaying = true;
  //     // });
  //   });
  // }
  //
  // flutterPlaySound(url) async {
  //   await flutterSound.startPlayer(url);
  //
  //   flutterSound.onPlayerStateChanged.listen((e) {
  //     if (e == null) {
  //       setState(() {
  //         this._isPlaying = false;
  //       });
  //     } else {
  //       print("Playing Mohan");
  //       setState(() {
  //         this._isPlaying = false;
  //       });
  //     }
  //   });
  // }
}
