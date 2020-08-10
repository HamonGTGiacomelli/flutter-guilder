import 'package:enum_to_string/enum_to_string.dart';
import 'package:guilderapp/model/TableModel.dart';
import 'package:guilderapp/model/enum/CharacterFunctionEnum.dart';

class CharacterModel {
  int _id;
  String _name;
  String _gameSystem;
  CharacterFunction _characterFunction;
  int _tableId;

  CharacterModel(this._name, this._gameSystem, this._characterFunction);

  CharacterModel.withId(
      this._id, this._name, this._gameSystem, this._characterFunction);

  int get id => _id;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  CharacterFunction get characterFunction => _characterFunction;

  set characterFunction(CharacterFunction value) {
    _characterFunction = value;
  }

  String get gameSystem => _gameSystem;

  set gameSystem(String value) {
    _gameSystem = value;
  }

  int get tableId => _tableId;

  set tableId(int value) {
    _tableId = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    if (tableId != null && tableId > 0) {
      map['tableId'] = _tableId;
    }
    map['name'] = _name;
    map['gameSystem'] = _gameSystem;
    map['characterFunction'] = EnumToString.parse(_characterFunction);
    return map;
  }

  CharacterModel.fromObject(dynamic object) {
    this._id = object['id'];
    this._name = object['name'];
    this._gameSystem = object['gameSystem'];
    this._characterFunction = EnumToString.fromString(
        CharacterFunction.values, object['characterFunction']);
    this._tableId = object['tableId'];
  }

  @override
  String toString() {
    return 'CharacterModel{_id: $_id, _name: $_name, _gameSystem: $_gameSystem, _characterFunction: $_characterFunction}';
  }
}
