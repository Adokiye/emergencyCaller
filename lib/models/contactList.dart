import 'contact.dart';

class ContactList {
  List<Contact> items;

  ContactList() {
    items = new List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}