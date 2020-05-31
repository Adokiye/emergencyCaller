import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: futureForums,
          builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Center(child: Text('No Forums available'));
            }
            if (snapshot.hasData) {
             // print(jsonDecode(snapshot.data[0]));
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index){
               //   print(Forum(title: snapshot.data));
                 return new BriefForumBox(
                  forumData: snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
                shrinkWrap: true,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Xenforo Forum'),
            //   decoration: BoxDecoration(
            //  //   color: Colors.blue,
            //   ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   title: Text('Item 2'),
            //   onTap: () {
            //     // Update the state of the app
            //     // ...
            //     // Then close the drawer
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
