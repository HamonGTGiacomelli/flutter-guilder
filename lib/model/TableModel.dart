class TableModel {
  String _name;
  String _availability;
  String _description;
  String _imageURL;

  TableModel(this._name, this._availability, this._description, this._imageURL);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get availability => _availability;

  String get imageURL => _imageURL;

  set imageURL(String value) {
    _imageURL = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set availability(String value) {
    _availability = value;
  }
}