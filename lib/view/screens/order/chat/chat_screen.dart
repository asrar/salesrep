import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ChatScreen extends StatefulWidget {
   ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var msgtext = TextEditingController();
  var listviewcon = TextEditingController();
  List<bool> me = [
    false,
    true,
    false,
    true,
    true,
  ];
  //  FlutterSound flutterSound = new FlutterSound();
  // bool isRecording = false;
  // String recordingPath;

  @override
  // void initState() {
  //   super.initState();
  //   flutterSound.setSubscriptionDuration(0.01);
  //   flutterSound.setDbPeakLevelUpdate(0.8);
  //   flutterSound.setDbLevelEnabled(true);
  // }
  // startRecording() async {
  //   recordingPath = await flutterSound.startRecorder(null);
  //   setState(() {
  //     isRecording = true;
  //   });
  // }
  // stopRecording() async {
  //   String result = await flutterSound.stopRecorder();
  //   print("stopRecorder: $result");
  //   setState(() {
  //     isRecording = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff020703),
      appBar: AppBar(
        backgroundColor: Color(0xff1f2c34),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1,
        shadowColor: Colors.white,
        leading: GestureDetector(
            onTap: () async {
              final weburl = 'www.vision.com/';

              await ('Welcome to text} ${weburl}');
            },
            child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: (){},
                child: Icon(Icons.settings)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: me.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        me[index]
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 25, top: 5,),
                                  padding: EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      left: 5,
                                      right: 5),
                                  // width: 228,
                                  decoration: BoxDecoration(
                                      color: Color(0xff1f2c34),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      )),

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Welcome to our AI-powered',
                                      textAlign: TextAlign.center,
                                      style:
                                      TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 306,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 5,),
                                padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                    left: 5,
                                    right: 5),
                                width: 228,
                                decoration: BoxDecoration(
                                    color: Color(0xff075E54),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Text(
                                  'Welcome to our AI-powered application! \n to offer you a'
                                      ' personalized and efficient experience using the latest \n artificial '
                                      'intelligence technology. Our AI \n designed to assist you in your'
                                      ' tasks, answer your questions, and make'
                                      ' \n based on your needs. We hope you enjoy using our application',
                                      // ' and find it helpful in your daily life. If you have any '
                                      // ' \n please dont hesitate to reach out to us for support. '
                                      // 'Thank you for choosing our,'
                                      // ' \n and we look forward to assisting you.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color:Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height*0.044,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  // padding: EdgeInsets.symmetric(vertical: 90.0),
                  // decoration: BoxDecoration(
                  //     color: Theme.of(context).indicatorColor,
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(
                  //       color: Theme.of(context).canvasColor,
                  //       width: 1,
                  //     )),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // elevation: 2,
                    // margin: EdgeInsets.all(7),
                    color: Color(0xff1f2c34),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color:Color(0xff1f2c34), width: 2,),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      // autocorrect: true,
                      // enableSuggestions: true,
                      maxLines: 5,
                      minLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: msgtext,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'How Can I Help You?',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, bottom: 16),
                        hintStyle: TextStyle(
                            color: Color(0xff3d4a52),
                            fontWeight: FontWeight.w300,

                            fontSize: 15),
                      ),
                    ),
                  ),
                ),

                // SizedBox(width: 1),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.12,
                      decoration: BoxDecoration(
                          color:Color(0xff00a983),
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                    child:Icon(
                      msgtext.text.length!=0?Icons.send:Icons.mic,
                      color:Colors.white,
                    )
                ),)
              ],
            ),
          ),

        ],
      ),
      // bottomNavigationBar: ,
    );
  }
}