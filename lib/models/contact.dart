class Contact {
  String title;
  String number;

  Contact({this.title, this.number});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['title'] = title;
    m['number'] = number;
    return m;
  }
}