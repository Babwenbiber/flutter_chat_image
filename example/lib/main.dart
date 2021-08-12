import 'package:chat_image/chat_image.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    _requestPermission();
    super.initState();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving image and displaying"),
      ),
      body: Column(children: [
        ChatImage(
            url:
                "https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png",
            errorBuilder: (BuildContext context, String errorMsg) {
              return Text("some error $errorMsg");
            },
            imageBuilder: (BuildContext context, Image image) {
              return Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(color: Colors.white, child: image),
                ),
              );
            }),
        SizedBox(
          height: 50,
        ),
        MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _SecondPage()),
              );
            },
            child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("reuse image on the next site",
                      style: TextStyle(color: Colors.white)),
                )))
      ]),
    );
  }
}

class _SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving image and displaying"),
      ),
      body: Column(
        children: [
          ChatImage(
              url:
                  "https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png",
              loadingBuilder: (BuildContext context) {
                return Center(
                  child: Container(
                    color: Colors.red,
                    height: 200,
                    width: 200,
                    child: Center(
                        child: Text(
                      "I am loading",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                );
              },
              errorBuilder: (BuildContext context, String errorMsg) {
                return Text("some error $errorMsg");
              },
              imageBuilder: (BuildContext context, Image image) {
                return Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: image,
                  ),
                );
              }),
          SizedBox(
            height: 50,
          ),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstPage()),
                );
              },
              child: Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("back to the first site",
                        style: TextStyle(color: Colors.white)),
                  )))
        ],
      ),
    );
  }
}
