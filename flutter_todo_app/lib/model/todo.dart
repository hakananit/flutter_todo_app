class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Todo(this._title, this._priority, this._date, [this._description]);
  Todo.withId(this._id, this._title, this._priority, this._date,
      [this._description]);
  Todo.fromObject(dynamic o) {
    this._id = o["id"];
    o['title'] = title;
    o['description'] = description;
    o['date'] = date;
    o['priority'] = priority;
  }

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String value) {
    if (value.length <= 255) {
      _title = value;
    }
  }

  set description(String value) {
    if (value.length <= 255) {
      _description = value;
    }
  }

  set priority(int value) {
    if (value >= 0) {
      _priority = value;
    }
  }

  set date(String value) {
    _date = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['priority'] = priority;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }
}
