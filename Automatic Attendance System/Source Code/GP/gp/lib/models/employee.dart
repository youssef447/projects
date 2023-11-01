// ignore_for_file: unnecessary_this

class Emp {
  String _name;
  String _image;
  String get image => this._image;
  int _late;
  int _absence;
  int _attended;
  int get late => this._late;

  set late(value) => this._late = value;

  int get absence => this._absence;

  set absence(value) => this._absence = value;

  int get attended => this._attended;

  set attended(value) => this._attended = value;
  String _id;
  String _email;
  String _phone;
  String get phone => this._phone;

  String _jobTitle;
  //List<DateTime> _attendedDays;
  String _arrivalTime;
  List<String> _bonus;
  List<String> _punishments;
  int _salary;
  String _dep;
  get dep => this._dep;
  String get arrivaltIME => this._arrivalTime;
  String _work_time;
  get salary => this._salary;

  get work_time => this._work_time;

  String get name => this._name;
  Emp(
      {name,
      attended,
      dep,
      salary,
      id,
      phone,
      email,
      work_time,
      late,
      absence,
      image,
      arrivalTime,
      bonus,
      attendedDays,
      punishments,
      jobTitle}) {
    this._id = id;
    this._absence=absence;
    this._late=late;
    
    this._phone = phone;
    this._attended = attended;
    this._image = image;
    this._work_time = work_time;
    this._salary = salary;
    this._email = email;
    this._arrivalTime = arrivalTime;
    //this._attendedDays = attendedDays;
    this._jobTitle = jobTitle;
    this._name = name;
    this._dep = dep;
    this._bonus = bonus;
    this._punishments = punishments;
  }
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "email": _email,
      "id": _id,
    };
  }

  String get id => this._id;

  get email => this._email;

  get jobTitle => this._jobTitle;

  List<String> get bonus => this._bonus;

  set bonus(value) => this._bonus = value;

  List<String> get punishments => this._punishments;

  set punishments(value) => this._punishments = value;
}
