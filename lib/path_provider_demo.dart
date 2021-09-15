import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/example.dart';
import 'package:flutter_demo/listtile_ex.dart';
import 'package:flutter_demo/navigator_demo.dart';
import 'package:flutter_demo/text_wrap.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pin_view/pin_view.dart';
import 'package:ext_storage/ext_storage.dart';
void main() {
  runApp(PathProviderDemo());
}

class PathProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyPathProviderPage(
        title: "KK",
      ),
    );
  }
}

class MyPathProviderPage extends StatefulWidget {
  MyPathProviderPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyPathProviderPageState createState() => _MyPathProviderPageState();
}

class _MyPathProviderPageState extends State<MyPathProviderPage> {
  int _counter = 0;
  static DateTime now = new DateTime.now();
  int durationInDays = 30;
  DateTime today = new DateTime(now.year, now.month, now.day);

  getDaysToDisplay() {
    print(DateTime.now().timeZoneName);
    DateTime tmpToday = new DateTime.utc(now.year, now.month, now.day);
    List<DateTime> dates = List.generate(durationInDays, (int index) {
      return tmpToday.subtract(new Duration(days: index));
    });
    dates.forEach((element) {
      print("${element.millisecondsSinceEpoch} \t $element");
      DateTime tmp = getLocalDate(element);
      print("             ${tmp.millisecondsSinceEpoch} \t $tmp");
    });
    return dates;
  }

  DateTime getLocalDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatter.parse(formatted);
  }

  @override
  void initState() {
    super.initState();

  }
  void _incrementCounter() async {
    print('getExternalCacheDirectories' + (await getExternalCacheDirectories()).toString());
    print('getExternalStorageDirectories' + (await getExternalStorageDirectories()).toString());
    print('getExternalStorageDirectory' + (await getExternalStorageDirectory()).toString());
    print('getApplicationDocumentsDirectory' + (await getApplicationDocumentsDirectory()).toString());
    print('ExternalStorage' + await ExtStorage.getExternalStorageDirectory());

    Directory dir = await getExternalStorageDirectory();
    String dirPath = dir.path;

    /// "/storage/emulated/0/Android/data/org.dadabhagwan.AKonnectTest/files"

    print("After Split:" + dirPath.split('/Android/data/')[0]);

    // getDaysToDisplay();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        // padding: EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                // Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Icon(Icons.phonelink_ring, size: 100.0, color: Theme.of(context).primaryColor),
                ),
                // Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                Text(
                  "1Waiting to automatically detect an SMS sent to your mobile number.",
                  // textAlign: TextAlign.center,
                  // style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.teal),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: PinView(
                      count: 5,
                      // count of the fields, excluding dashes
                      autoFocusFirstField: false,
                      dashPositions: [3],
                      // describes the dash positions (not indexes)
                      sms: SmsListener(
                        // this class is used to receive, format and process an sms
                          from: "6505551212",
                          formatBody: (String body) {
                            // incoming message type
                            // from: "6505551212"
                            // body: "Your verification code is: 123-456"
                            // with this function, we format body to only contain
                            // the pin itself
                            String codeRaw = body.split(": ")[1];
                            List<String> code = codeRaw.split("-");
                            return code.join();
                          }),
                      submit: (String pin) {
                        if (pin.length == 6) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(title: Text("Pin received successfully."), content: Text("Entered pin is: $pin"));
                              });
                        }
                      } // gets triggered when all the fields are filled
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
