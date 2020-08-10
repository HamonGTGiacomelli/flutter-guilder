import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilderapp/model/CharacterModel.dart';
import 'package:guilderapp/model/TableModel.dart';
import 'package:guilderapp/model/dao/CharacterDao.dart';

const randomImages = [
  "https://s2.glbimg.com/ThVET8GNGSKUfBbgdLzE5r3N3dU=/0x0:1096x609/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2019/a/3/BuD6GjQmaWB2EdQlciSg/captura-de-tela-2019-11-04-as-07.36.39.png",
  "https://s2.glbimg.com/C3GPvh6ECD-33n8Df_v1EecSL9o=/0x0:1600x1000/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2019/m/H/k84eHgTA2l7JhjO3Q6Aw/wallpaper-2560-x-1600-wallpaper.jpg",
  "https://www.rederpg.com.br/wp/wp-content/uploads/2016/06/EN_Monster_Giant_Header-864x467.jpg",
  "https://www.orcnroll.com/wp-content/uploads/2019/10/image.jpeg",
  "https://www.rederpg.com.br/wp/wp-content/uploads/2015/06/Banner_News-864x467.jpg",
  "https://s2.glbimg.com/zC83radXYqL2YE1ezVSvb4b78vM=/0x0:857x450/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2019/S/P/aoiVslR423MN4YAEKhUA/captura-de-tela-2019-06-14-as-16.07.15.png",
  "https://4.bp.blogspot.com/-5qwZ2asnGgA/Wj1Bh-nyg2I/AAAAAAAADs8/SfxERBtWQosawOP4Eb5Oj0B1lM_5_9JXACLcBGAs/s1600/races.jpg",
  "https://3.bp.blogspot.com/-_lVAliFK4gU/W3ZyY-Ur_mI/AAAAAAAAReA/LU3q943M-QgJdgopUzcB4qAgE3d3KLS7QCLcBGAs/s1600/critical%2Brole%2Brpg%2Bdnd.png",
  "https://uploads.jovemnerd.com.br/wp-content/uploads/2019/06/NC_679_giga-760x428.jpg",
  "https://vignette.wikia.nocookie.net/serial101-arquivos/images/b/bc/Beholder_Version_2_by_mepol.jpg/revision/latest/scale-to-width-down/340?cb=20200123001144&path-prefix=pt-br",
];

class SearchTableView extends StatefulWidget {
  CharacterModel _character;

  SearchTableView();

  SearchTableView.withCharacter(this._character);

  @override
  SearchTableViewState createState() => SearchTableViewState(this._character);
}

class SearchTableViewState extends State<StatefulWidget> {
  CharacterModel _character;
  List<TableModel> list = List.generate(10, (int index) {
    return TableModel("Mesa $index", "Terça 19:00~21:00",
        "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum", randomImages[index]);
  });
  TableModel currentTable;

  SearchTableViewState(this._character) {
    currentTable = list.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    if (list.length > 0) {
      currentTable = list.elementAt(0);
    } else {
      currentTable = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Procurar Mesas"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ButtonTheme(
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    child: Text(
                      "Rejeitar",
                      textScaleFactor: 2,
                    ),
                    color: Theme.of(context).primaryColorDark,
                    onPressed: () async {
                      if (currentTable != null) {
                        setState(() {
                          list.removeAt(0);
                          if (list.length > 0) {
                            currentTable = list.elementAt(0);
                          }
                        });
                      }
                    },
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            Expanded(
              child: ButtonTheme(
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    child: Text(
                      "Aceitar",
                      textScaleFactor: 2,
                    ),
                    color: Theme.of(context).primaryColorDark,
                    onPressed: () async {
                      CharacterDao dao = CharacterDao();
                      _character.tableId =
                          Random().nextInt(10); //mockedId from service
                      var result = await dao.update(_character);
                      if (result > 0) {
                        await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    title: Text("Uma aventura lhe aguarda!")))
                            .then((value) => {Navigator.pop(context, true)});
                      } else {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: Text(
                                    "Erro ao se juntar ao grupo, tente novamente mais tarde!")));
                      }
                    },
                  )),
            )
          ],
        ),
      ),
      body: currentTable == null
          ? Container(
              alignment: Alignment.center,
              child: Text(
                "Nenhuma mesa encontrado no Momento, tente novamente mais tarde!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "Mesa",
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: NetworkImage(currentTable.imageURL),
                          height: 400,
                          alignment: Alignment.center,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Horário: Terças Feiras das 19:00 às 20:00",
                            textAlign: TextAlign.start),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Descrição: Lorem ipsum",
                            textAlign: TextAlign.start),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
