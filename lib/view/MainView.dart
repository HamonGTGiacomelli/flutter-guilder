import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guilderapp/model/CharacterModel.dart';
import 'package:guilderapp/model/dao/CharacterDao.dart';
import 'package:guilderapp/model/enum/CharacterFunctionEnum.dart';
import 'package:guilderapp/view/CharacterFormView.dart';
import 'package:guilderapp/view/SearchTableView.dart';
import 'package:guilderapp/view/widgets/CharacterCard.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  List<CharacterModel> list = List<CharacterModel>();
  CharacterDao dao = CharacterDao();

  void updateList() {
    var futureCharacterList = dao.retrieveCharacters();
    futureCharacterList.then((characterList) {
      setState(() {
        list.clear();
        list.addAll(characterList.map((character) {
          return CharacterModel.fromObject(character);
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Guilder"),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3.0,
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => CharacterFormView()));
          debugPrint(result.toString());
          if (result) {
            updateList();
          }
        },
      ),
      body: Container(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int position) {
            final character = list[position];

            return Dismissible(
                key: Key(character.id.toString()),
                onDismissed: (direction) {
                  setState(() {
                    dao.delete(character);
                    list.removeAt(position);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Perosnagem ${character.name} Excluido!"),
                  ));
                },
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(
                    onTap: () async {
                      var result = Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchTableView.withCharacter(character)));
                      if (result != null) {
                        updateList();
                      }
                    },
                    title: CharacterCard(
                        character.name,
                        (character.tableId == null || character.tableId == 0)
                            ? "Procurando mesa"
                            : "Mesa Encontrada ${character.tableId}",
                        Icon(Icons.person), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CharacterFormView.withCharacter(character)));
                    })));
          },
        ),
      ),
    );
  }
}
