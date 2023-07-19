import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Scaffold(backgroundColor: Colors.pink[400],
          appBar: AppBar(
            title: Text('설정', style: TextStyle(fontFamily: 'Pyeongchang', fontSize: 15),),centerTitle: true, backgroundColor: Colors.pink[400],
            iconTheme: IconThemeData(color: Colors.white),elevation: 0,
          ),
          body: Text("설정")
        ),
    );
  }
}
