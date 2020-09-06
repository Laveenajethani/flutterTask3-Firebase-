import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COMMAND PROMPT"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/cmd.png'),
              SizedBox(height: 20),
              Material(
                borderRadius: BorderRadius.circular(100
                ),
                color: Colors.orangeAccent,
                child: MaterialButton(
                  minWidth: 300,
                  child: Text("RUN COMMANDS"),
                  onPressed: () {
                    Navigator.pushNamed(context, "api");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
