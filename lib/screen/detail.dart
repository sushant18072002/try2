import 'package:flutter/material.dart';
import 'package:task1/read_json_file_model/model.dart';

class home extends StatelessWidget {
  final DataModel dataModel;

  const home({Key? key, required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage('https://img.freepik.com/free-vector/white-abstract-background_23-2148817571.jpg'),
          ),
        ),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
          children: [
              CircleAvatar(
                radius:200,
                backgroundImage: NetworkImage(dataModel.imageURL.toString()),
              ),
              Text(dataModel.name.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,10),
                child: Text(dataModel.discription.toString(),style: TextStyle(fontSize: 18),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0,10,0,0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,2,8.0,2),
                      child: Text("Published Date:",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    Text(dataModel.published_date.toString()),
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
                    Text(dataModel.event_date.toString()),
                  ],
                ),
              )
          ],
        ),
            )),
      ),
    );
  }
}

/*
class detail extends StatefulWidget {
  final DataModel dataModel;
  const detail({Key? key, required this.dataModel}) : super(key: key);

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text(this.dataModel.name.toString()))),
    );
  }
}
 */
