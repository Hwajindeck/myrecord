import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var records = <String>['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('플러터시발')),
        body: ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount:records.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
                height: 50,
                color: Colors.amber,
                child:Center(
                    child:Text(records[index])
                )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),

        )
    );
  }
}
