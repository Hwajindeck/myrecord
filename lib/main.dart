import 'package:flutter/material.dart';
import 'package:myrecord/screens/make_plan.dart';
import 'package:myrecord/screens/setting_screen.dart';
import 'package:myrecord/screens/test.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
 initializeDateFormatting().then((_) => runApp(const MyApp()));
}
class recordedData {
  String date = '';
  String time = '';
  String content = '';

  //recordedData({this.date, this.time, this.content});

Map<String, String> toMap(){
  return {
    'date' : date,
    'time' : time,
    'content' : content,
    };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Main(),
      theme: ThemeData(fontFamily: 'Pyeongchang'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  final formKey = GlobalKey<FormState>();
  String _selectedTime = '';
  String _selectedDate = '';
  String submittedData = '';
  var timetxt = TextEditingController();
  var datetxt = TextEditingController();
  var recordtxt = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(backgroundColor: Colors.pink[400],
          appBar: AppBar(
            title: Text('나의 기록', style: TextStyle(fontFamily: 'Pyeongchang', fontSize: 15),),centerTitle: true, backgroundColor: Colors.pink[400],
            iconTheme: IconThemeData(color: Colors.white),elevation: 0,
          ),
            drawer: Drawer(child:
            ListView(children: [
              ListTile(
                trailing: Icon(Icons.content_paste_outlined),
                iconColor: Colors.purple,
                focusColor: Colors.purple,
                title: Text('나의 기록들'),
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Test()), );
                  },
                leading: Icon(Icons.navigate_next),
                  ),
              ListTile(
                trailing: Icon(Icons.settings),
                iconColor: Colors.purple,
                focusColor: Colors.purple,
                title: Text('설정'),
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()), );
                },
                leading: Icon(Icons.navigate_next),
              ),
                ],
              )
            ),
          floatingActionButton: FloatingActionButton( onPressed: (){
              submittedData = "${datetxt.text} ${timetxt.text} ${recordtxt.text}";
              datetxt.clear();
              timetxt.clear();
              recordtxt.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$submittedData',textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20),),
                    duration: Duration(seconds: 3),
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    dismissDirection: DismissDirection.horizontal,
                )
              );
          }, child: Icon(Icons.add, color: Colors.purple,),elevation: 20, backgroundColor: Colors.white,),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
              Column(
                children: [
                  SizedBox(height:100),
                  Padding(padding: EdgeInsets.fromLTRB(30, 16, 30, 100), child:
                    Text("오늘은 뭘 하셨나요?",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold ,color: Colors.white, fontFamily: 'Pyeongchang'),)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextField(
                          onTap: () {
                            Future<DateTime?> future = showDatePicker(
                                context: context,
                                locale:Locale('ko','KR'),
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime.now()
                            );
                            future.then((DateTime){
                              setState(() {
                                if(DateTime == null){
                                  _selectedDate = '';
                                }else{
                                  Map<String, String> dayofweek = {
                                    'Monday' : '(월)',
                                    'Tuesday' : '(화)',
                                    'Wednesday' : '(수)',
                                    'Thursday' : '(목)',
                                    'Friday' : '(금)',
                                    'Saturday' : '(토)',
                                    'Sunday' : '(일)',
                                  };
                                    String a = DateFormat('EEEE').format(DateTime);
                                  //_selectedDate = "${DateTime.year}-${DateTime.month}-${DateTime.day}";
                                _selectedDate = "${DateTime.year}년 ${DateTime.month}월 ${DateTime.day}일 ${dayofweek[a]!}";
                                  datetxt.text = _selectedDate;
                                }
                              });
                            }
                            );
                          },

                          controller: datetxt,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          readOnly: true,decoration: InputDecoration(
                          labelText: '날짜',
                          labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold) ,
                          suffixIcon: Icon(Icons.calendar_month_sharp),
                        suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? Colors.tealAccent
                            : Colors.white),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.tealAccent, width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                          //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 10), borderRadius: BorderRadius.all(Radius.circular(10))),
                      )
                      )
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10) ,
                    child: TextField(
                        onTap: (){
                          Future<TimeOfDay?> future = showTimePicker(
                            context: context,
                            confirmText: '확인',
                            cancelText: '취소',
                            helpText: '시간 선택',

                            initialTime: TimeOfDay.now(),
                            );
                            future.then((timeOfDay) {
                              setState(() {
                                if (timeOfDay == null) {
                                  _selectedTime = '';
                                } else {
                                  String ampm = '오전';
                                  int hour = timeOfDay.hour;
                                  int minute = timeOfDay.minute;
                                  String min = '';
                                  if(timeOfDay.hour> 12){
                                    hour -= 12;
                                    ampm = '오후';
                                  }
                                  else if (timeOfDay.hour == 12){
                                    ampm = '오후';
                                  }
                                  else if (timeOfDay.hour == 0){
                                    ampm = '오전';
                                    hour = 12;
                                  }
                                  if (timeOfDay.minute < 10){
                                    min = '0${timeOfDay.minute}';
                                  }
                                  else {
                                    min = '${timeOfDay.minute}';
                                  }
                                  _selectedTime = '$ampm $hour시 $min분 ';
                                  timetxt.text = _selectedTime;
                                  }
                                });
                              });
                            },
                            controller: timetxt,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            readOnly: true,decoration: InputDecoration(
                            labelText: '시간',
                            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            suffixIcon: Icon(Icons.watch_later,),
                            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused)
                                  ? Colors.tealAccent
                                  : Colors.white),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.tealAccent, width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                          )
                        ),
                      ),
                  Padding(
                      padding:  EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextField(

                        controller: recordtxt,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        cursorColor: Colors.tealAccent,
                        decoration: InputDecoration(
                          labelText: '내용',
                          //floatingLabelBehavior: FloatingLabelBehavior.always ,
                          floatingLabelStyle: TextStyle(color: Colors.tealAccent),
                          labelStyle: TextStyle(color:  Colors.white, fontWeight: FontWeight.bold),
                          suffixIcon: Icon(Icons.edit_outlined,),
                          suffixIconColor: MaterialStateColor.resolveWith((states) =>
                          states.contains(MaterialState.focused)
                              ? Colors.tealAccent
                              : Colors.white),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.tealAccent, width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                        )
                      )
                  ],
                )
           ),
          )
      );
    }
  }


renderTextFormField({
  required String label,
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
}) {
  assert(label != null);
  assert(onSaved != null);
  assert(validator != null);

  return Column(
    children: [
      Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      TextFormField(
        onSaved: onSaved,
        validator: validator,
      ),
      SizedBox(height:10)
    ],
  );
}




