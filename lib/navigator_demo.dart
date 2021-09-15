import 'package:flutter/material.dart';

class NavigatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScreen();
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class MainScreen extends State<NavigatorDemo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
                title: new Text("Title")
            ),
            body:
            /*new Center(
                child: new FlatButton(
                    child: new Text("Second page"),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondPage()));
                    }));*/
            FirstPage()
        )
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new FlatButton(
            child: new Text("Second page"),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondPage()));
            }));
  }
}

class SecondPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new SecondPageState();
  }
}


class SecondPageState extends State<SecondPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Title"),
      ),
      body: new Center(
        child: new Text("Some text"),
      ),
    );
  }
}