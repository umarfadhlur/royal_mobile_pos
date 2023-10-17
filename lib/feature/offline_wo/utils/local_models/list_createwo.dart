class ListDataCreateWO {
  int _id;
  String _customerNumber,
      _contactName,
      _prefix,
      _phone,
      _equipNumber,
      _invItemNumber,
      _failureDesc,
      _reqFinishDate,
      _reqFinishTime,
      _notes,
      _woNumber;

  ListDataCreateWO(
      this._customerNumber,
      this._contactName,
      this._prefix,
      this._phone,
      this._equipNumber,
      this._invItemNumber,
      this._failureDesc,
      this._reqFinishDate,
      this._reqFinishTime,
      this._notes,
      this._woNumber);

  String get customerNumber => _customerNumber;
  String get contactName => _contactName;
  String get prefix => _prefix;
  String get phone => _phone;
  String get equipNumber => _equipNumber;
  String get invItemNumber => _invItemNumber;
  String get failureDesc => _failureDesc;
  String get reqFinishDate => _reqFinishDate;
  String get reqFinishTime => _reqFinishTime;
  String get notes => _notes;
  String get woNumber => _woNumber;

  int get id => _id;

  set id(int newId) {
    this._id = newId;
  }

  set customerNumber(String customerNumber) {
    this._customerNumber = customerNumber;
  }

  set contactName(String contactName) {
    this._contactName = contactName;
  }

  set prefix(String prefix) {
    this._prefix = prefix;
  }

  set phone(String phone) {
    this._phone = phone;
  }

  set equipNumber(String equipNumber) {
    this._equipNumber = equipNumber;
  }

  set invItemNumber(String invItemNumber) {
    this._invItemNumber = invItemNumber;
  }

  set failureDesc(String failureDesc) {
    this._failureDesc = failureDesc;
  }

  set reqFinishDate(String reqFinishDate) {
    this._reqFinishDate = reqFinishDate;
  }

  set reqFinishTime(String reqFinishTime) {
    this._reqFinishTime = reqFinishTime;
  }

  set notes(String notes) {
    this._notes = notes;
  }

  set woNumber(String woNumber) {
    this._woNumber = woNumber;
  }

  //convert data to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }

    map['customerNumber'] = _customerNumber;
    map['contactName'] = _contactName;
    map['prefix'] = _prefix;
    map['phone'] = _phone;
    map['equipNumber'] = _equipNumber;
    map['invItemNumber'] = _invItemNumber;
    map['failureDesc'] = _failureDesc;
    map['reqFinishDate'] = _reqFinishDate;
    map['reqFinishTime'] = _reqFinishTime;
    map['notes'] = _notes;
    map['woNumber'] = _woNumber;

    return map;
  }

  //extract data from map object
  ListDataCreateWO.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._customerNumber = map['customerNumber'];
    this._contactName = map['contactName'];
    this._prefix = map['prefix'];
    this._phone = map['phone'];
    this._equipNumber = map['equipNumber'];
    this._invItemNumber = map['invItemNumber'];
    this._failureDesc = map['failureDesc'];
    this._reqFinishDate = map['reqFinishDate'];
    this._reqFinishTime = map['reqFinishTime'];
    this._notes = map['notes'];
    this._woNumber = map['woNumber'];
  }
}
