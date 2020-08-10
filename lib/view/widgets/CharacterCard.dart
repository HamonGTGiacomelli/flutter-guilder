import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CharacterCard extends StatelessWidget {
  String _title;
  String _subTitle;
  Icon _icon;
  Function() _onIconPressedAction;

  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  CharacterCard(this._title, this._subTitle, this._icon, this._onIconPressedAction);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              this._icon,
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this._title,
                      style: titleStyle,
                    ),
                    Text(this._subTitle),
                  ],
                ),
              )),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: _onIconPressedAction,
              ),
            ],
          ),
        ));
  }
}
