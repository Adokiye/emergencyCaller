import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:emergencyCaller/models/contact.dart';
import 'package:flutter/services.dart';
import 'package:emergencyCaller/models/contactList.dart';

class AddContact extends StatefulWidget {
  AddContact({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddContactState createState() => new _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  final ContactList list = new ContactList();
  final LocalStorage storage = new LocalStorage('emergencyCaller');
  bool initialized = false;
  TextEditingController controller = new TextEditingController(); //09048455145
  bool showEmpty = false;
 

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
        title: Text('Add Contact'),
      ),
      body:    Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child:  MyCustomForm())),
    );
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
    final ContactList list = new ContactList();


  addContact() {
    setState(() {
      final item = new Contact(title: nameController.text, number: numberController.text);
      list.items.add(item);
     // _saveToStorage();
    });
  }

  // _saveToStorage() {
  //   storage.setItem('todos', list.toJSONEncodable());
  // }



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    numberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  //                    <--- top side
                  color: const Color(0xffC4C4C4),
                  width: 1.0,
                ),
              )),
              child: new TextFormField( controller: nameController,
                decoration: new InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  hintText: 'Enter your full name of contact',
                  hintStyle: TextStyle(
                    fontSize: 13.0,
                    color: const Color(0xffC4C4C4),
                  ),
                  border: InputBorder.none,
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  height: 1.0,
                ),
              )),
          new Container(
margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  //                    <--- top side
                  color: const Color(0xffC4C4C4),
                  width: 1.0,
                ),
              )),
              child: new TextFormField(
                controller: numberController,
                decoration: new InputDecoration(
                  labelText: "Phone Number",
                  fillColor: Colors.white,
                  hintText: 'Enter phone number of contact',
                  hintStyle: TextStyle(
                    fontSize: 13.0,
                    color: const Color(0xffC4C4C4),
                  ),
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (val) {
                  if (val.length == 0) {
                    return "Phone Number cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.phone,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  height: 1.0,
                ),
              )),
           Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Material(
                          color: Color(0xff1281dd),
                          child: InkWell(
                            onTap: (){ addContact();},
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width * 0.80,
                              color: Color(0xff1281dd),
                              child: Text(
                                'ADD', style: TextStyle(color: Colors.white),
                              ),
                            )
                          )
                        )
                      )
        ],
      ),
     );
  }
}

