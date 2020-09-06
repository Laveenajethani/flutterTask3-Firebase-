import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class API extends StatefulWidget {
  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  var value;
  var output;
  var fsconnect = FirebaseFirestore.instance;
  var webdata;
  myget() async {
    var d = await fsconnect.collection("output").get();
    for (var i in d.docs) {
      webdata = i.data();
    }
    print(webdata);
  }

  web(cmd) async {
    var url = "http://192.168.43.242/cgi-bin/iiec.py?x=${cmd}";
    var responce = await http.get(url);
    setState(() {
      output = responce.body;
    });

    fsconnect.collection("output").add({
      'cmd': cmd,
      'out': output,
    });
  }

  _launchURL() async {
    const url =
        'https://console.firebase.google.com/u/0/project/fir-task-c6a84/firestore/data~2Foutput';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          RaisedButton(
            child: Image.asset('images/db.png'),
            onPressed: _launchURL,
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  cursorColor: Colors.black,
                  onChanged: (val) {
                    print(val);
                    value = val;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Command',
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Material(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: MaterialButton(
                    minWidth: 200,
                    child: Text(
                      "RUN",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      web(value);
                      print("pressed");
                      myget();
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    output ?? "show output",
                    textAlign: TextAlign.center,
                  ),
                  width: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
