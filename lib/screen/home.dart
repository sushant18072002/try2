import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:task1/read_json_file_model/model.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<DataModel> _notes = <DataModel>[];

  @override
  void initState() {
    ReadJsonData().then((value) => _notes.addAll(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,5),
                child: Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => home(dataModel: _notes[index])));
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            margin: EdgeInsets.all(20),
                            width: 200,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                              border: Border.all(
                                color: Colors.black26,
                                width: 3,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    _notes[index].imageURL.toString()),
                              ),
                            ),
                          )),
                          Flexible(
                              child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    _notes[index].name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 24),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(_notes[index].discription.toString(),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black26),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2.0,10,0,0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,2,8.0,2),
                                        child: Text("Published Date:",style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),

                                      Text(_notes[index].published_date.toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,2,8.0,2),
                                        child: Text("Event Date:",style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      Text(_notes[index].event_date.toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  Future<List<DataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('json/jsonfile.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => DataModel.fromJson(e)).toList();
  }
}
