import 'dart:async';
import 'dart:html' as html;

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_stream/home_page.dart';
import 'package:video_stream/utils/network_utils.dart';



class VideoStream extends StatefulWidget {
  const VideoStream({ Key? key }) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

   final _channelController = TextEditingController();
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;
  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       

  }
  //  getData(String channelName, int role,int expireTime) async {
  //       dynamic response = await createChannel(channelName);
  //          print(response['token']);
  // }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Video Call Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Channel name',
                    ),
                  ))
                ],
              ),
              // Column(
              //   children: [
              //     ListTile(
              //       title: Text(ClientRole.Broadcaster.toString()),
              //       leading: Radio(
              //         value: ClientRole.Broadcaster,
              //         groupValue: _role,
              //         onChanged: (ClientRole? value) {
              //           setState(() {
              //             _role = value!;
              //           });
              //           print(_role);
              //           print("----------------------------------------------------" );
              //         },
              //       ),
              //     ),
              //     ListTile(
              //       title: Text(ClientRole.Audience.toString()),
              //       leading: Radio(
              //         value: ClientRole.Audience,
              //         groupValue: _role,
              //         onChanged: (ClientRole? value) {
              //           setState(() {
              //             _role = value!;
              //           });
              //            print("----------------------------------------------------" );
              //           print( _role);
              //         },
              //       ),
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: onJoin,
                       
                        child: Text('Join'),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    //  getData("test flutter", 3600, 1);
    if (_channelController.text.isNotEmpty) {
      // await _handleCameraAndMic(Permission.camera);
      // await _handleCameraAndMic(Permission.microphone);
      await _handleCameraAndMicPermis();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCall(
            channelName: _channelController.text,
            role:ClientRole.Broadcaster,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
     print("permission " );
    print(status);
  } 
Future<void> _handleCameraAndMicPermis() async {
  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
    _scaffoldKey.currentState!.showSnackBar(snackBar);   
  }
    final permission = await html.window.navigator.permissions!.query({'name': 'microphone'});
    if (permission.state == "denied") {
      Scaffold(
    appBar: AppBar(
        // title: Text('SnackBar Playground'),
    ),
    body: Builder(
        builder: (context) => 
            Center(
            child: RaisedButton(
            color: Colors.orangeAccent,
            textColor: Colors.white,
            onPressed: () => _displaySnackBar(context),
            child: Text("Oops! microphone access denied!"),
            ),
        ),
    ),
);
    //   Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text("Oops! microphone access denied!"),
    //     backgroundColor: Colors.orangeAccent,
    //   ));
      return;
    }
 final perm = await html.window.navigator.permissions!.query({"name": "camera"});
    if (perm.state == "denied") {
       Scaffold(
    appBar: AppBar(
        // title: Text('SnackBar Playground'),
    ),
    body: Builder(
        builder: (context) => 
            Center(
            child: RaisedButton(
            color: Colors.orangeAccent,
            textColor: Colors.white,
            onPressed: () => _displaySnackBar(context),
            child: Text("Oops! Camera access denied!"),
            ),
        ),
    ),
);
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text("Oops! Camera access denied!"),
      //   backgroundColor: Colors.orangeAccent,
      // ));
      return;
    }
 } // ...
}