import 'package:flutter/material.dart';
import 'package:myrecord/screens/make_plan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: 'welcome', home: SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('second')),
        body: Column(children: [
          TextField()
         ],
        )
       )
      ),
    );
  }
}


