import 'package:chat_image/chat_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

const String url =
    "https://raw.githubusercontent.com/Babwenbiber/flutter_chat_image/master/res/TA_Logo.jpg";

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving image and displaying"),
      ),
      body: Column(children: [
        ChatImage(
            url: url,
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
              url: url,
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
