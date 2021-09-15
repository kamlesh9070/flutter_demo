import 'package:flutter/material.dart';
import 'package:flutter_demo/example.dart';
import 'package:flutter_demo/listtile_ex.dart';
import 'package:flutter_demo/navigator_demo.dart';
import 'package:flutter_demo/permission-demo.dart';
import 'package:flutter_demo/text_wrap.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pin_view/pin_view.dart';
import 'package:ext_storage/ext_storage.dart';
void main() {
  runApp(PermissionDemo());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: "KK",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

    getDaysToDisplay();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
