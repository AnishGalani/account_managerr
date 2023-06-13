import 'dart:io';

import 'package:account_managerr/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  var box = await Hive.openBox('Account_Manager');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Registration(),
  ));
}

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);
  Box box = Hive.box('Account_Manager');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenLock(
        correctString: '1234',
        onCancelled: Navigator.of(context).pop,
        onUnlocked: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DashBoard();
            },
          ));
        },
      ),
    );
  }
}
