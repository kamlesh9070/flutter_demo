import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/commonfunctions.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScreen();
  }
}

class MainScreen extends State<PermissionDemo> {
  @override
  void initState() {
    super.initState();
  }

  void _createFolder() async {
    try {
      await Permission.storage.request();
      final folderName = "Test";
      String dirPath = "storage/emulated/0/Download/$folderName";
      final path = Directory(dirPath);

      if (await path.exists()) {
        print('Exists');
        CommonFunction.alertDialog(context: context, msg: "Folder already exist:" + dirPath);
      } else {
        print('Does not exist');
        path.create();
        CommonFunction.alertDialog(context: context, msg: "Folder created:" + dirPath);
      }
    } catch (error, s) {
      print('Error while creating dir:');
      print(s);
      CommonFunction.displayErrorDialog(context: context, error: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(title: new Text("Title")),
            body:
                /*new Center(
                child: new FlatButton(
                    child: new Text("Second page"),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondPage()));
                    }));*/
                Container(
              child: Column(
                children: [
                  Text("Permission Demo"),
                  RaisedButton(child:Text("Create Folder"),onPressed: _createFolder)
                ],
              ),
            )));
  }
}
