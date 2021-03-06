import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:emergencyCaller/models/contact.dart';
import 'package:emergencyCaller/models/contactList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:emergencyCaller/screens/addContact.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  final ContactList list = new ContactList();
  final LocalStorage storage = new LocalStorage('emergencyCaller');
  bool initialized = false;
  TextEditingController controller = new TextEditingController(); //09048455145
  bool showEmpty = false;
  bool nextCall = true;
 
 _makeCall(){
   testLoop:
   for(var i=0;i<list.items.length;i++){
     if(nextCall){
         final phoneCall = FlutterPhoneState.startPhoneCall(list.items[i].number);
      phoneCall.eventStream.forEach((PhoneCallEvent event) {
    print("Event $event");
    if(event.status == 'connected'){
      setState((){
        nextCall = false;
      });
    }
  });
  print("Call is complete");
     }else{
      break testLoop;

     }
   
   }
 }

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
      body: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!initialized) {
              //  var items = storage.getItem('contacts');
               List<Contact> items = [Contact(title: 'Jong Mede', number: '2023030'),
               Contact(title: 'Jong Yang', number: '2023033'),];
                if (items != null) {
                  list.items = items;
                  // list.items = List<Contact>.from(
                  //   (items as List).map(
                  //     (item) => Contact(
                  //       title: item['title'],
                  //       number: item['number'],
                  //     ),
                  //   ),
                  // );
                }else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('You have no added emergency contacts', 
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
                      textAlign: TextAlign.center,),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Material(
                          color: Color(0xff1281dd),
                          child: InkWell(
                            onTap: (){ Navigator.push(
          context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: AddContact())
         );},
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              color: Color(0xff1281dd),
                              child: Text(
                                'ADD', style: TextStyle(color: Colors.white),
                              ),
                            )
                          )
                        )
                      )
                    ],
                  );
                }

                initialized = true;
              }

              List<Widget> widgets = list.items.map((item) {
                return Container(
    //  padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        color: Colors.white,
         boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
      ),
      child: new ListTile(
        title: new Text(item.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.0)),
        subtitle: new Text('Number: '+item.number
        , style: TextStyle(color: Colors.black, fontSize: 16.0),),
        onTap: () {},
      ),
    );
              }).toList();

              return Column(
                children: <Widget>[
                
                  Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Text('Contacts', 
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.0)),
        IconButton(icon: Icon(Icons.add, size: 18, color: Color(0xff1281dd)), onPressed: (){}),
      ],),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: widgets,
                    //  itemExtent: 50.0,
                    ),
                  ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Material(
                          color: Color(0xff1281dd),
                          child: InkWell(
                            onTap: (){ _makeCall();},
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Center(
                                child: Text(
                                'CALL', style: TextStyle(color: Colors.white, fontSize: 20.0),
                              )),
                            )
                          )
                        )
                      )
                ],
              );
            },
          )),
    );
  }
}
