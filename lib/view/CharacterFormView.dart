import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilderapp/model/CharacterModel.dart';
import 'package:guilderapp/model/dao/CharacterDao.dart';
import 'package:guilderapp/model/enum/CharacterFunctionEnum.dart';

class CharacterFormView extends StatefulWidget {
  CharacterModel _character;

  CharacterFormView();

  CharacterFormView.withCharacter(this._character);

  @override
  CharacterFormViewState createState() =>
      CharacterFormViewState(this._character);
}

class CharacterFormViewState extends State<StatefulWidget> {
  CharacterModel _character;

  TextEditingController tecName = TextEditingController();
  TextEditingController tecGameSystem = TextEditingController();

  CharacterFunction dropdownValue = CharacterFunction.DAMAGE_PHYSIC;

  CharacterFormViewState(this._character) {
    if (_character != null) {
      tecName.text = _character.name;
      tecGameSystem.text = _character.gameSystem;
      dropdownValue = _character.characterFunction;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personagem"),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: tecName,
                decoration: InputDecoration(
                  labelText: "Nome",
                  hintText: "Nome",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              ),
              TextField(
                controller: tecGameSystem,
                decoration: InputDecoration(
                  labelText: "Sistema de Preferência",
                  hintText: "Sistema de Preferência",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<CharacterFunction>(
                      value: dropdownValue,
                      isExpanded: true,
                      items: CharacterFunction.values
                          .map((CharacterFunction characterFunction) {
                        return DropdownMenuItem<CharacterFunction>(
                          value: characterFunction,
                          child:
                              Text(characterValueToString(characterFunction)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonTheme(
                        minWidth: 200,
                        height: 40,
                        child: RaisedButton(
                          child: Text(
                            "Salvar",
                            textScaleFactor: 2,
                          ),
                          color: Theme.of(context).primaryColorDark,
                          onPressed: () async {
                            CharacterDao dao = CharacterDao();

                            var result;

                            if (this._character == null) {
                              var newCharacter = CharacterModel(tecName.text,
                                  tecGameSystem.text, dropdownValue);
                              result = await dao.insert(newCharacter);
                            } else {
                              this._character.name = tecName.text;
                              this._character.gameSystem = tecGameSystem.text;
                              this._character.characterFunction = dropdownValue;
                              result = await dao.update(this._character);
                            }

                            if (result > 0) {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: Text("Salvo com sucesso!"))).then(
                                  (value) => {Navigator.pop(context, true)});
                            } else {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: Text(
                                          "Erro ao salvar, tente novamente mais tarde!")));
                            }
                          },
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
