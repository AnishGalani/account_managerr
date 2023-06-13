import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyController extends GetxController {
  static Database? database;
  RxList<Map> list = [{}].obs;
  RxList<Map> list1 = [{}].obs;

  RxList<Map> list_data = [{}].obs;
  var sel_type = "".obs;
  RxString total = "".obs;
  RxBool temp = false.obs;
  var result = [].obs;
  var result1 = [].obs;
  var bal = [].obs;

  RxInt i = 0.obs;

  DateTime? selectDate;

  String convertedDate = new DateFormat("dd-MM-yyyy").format(DateTime.now());

  TextEditingController textEditingController = TextEditingController();

  get_Database() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    MyController.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE  user(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT)');

      await db.execute(
          'CREATE TABLE data(id INTEGER PRIMARY KEY AUTOINCREMENT , ref TEXT,date TEXT,type TEXT,credit TEXT,debit TEXT,perticuler TEXT,balance TEXT)');
    });
    get_select();
  }

  get_insert(String name) async {
    String sql = "insert into user (name) VALUES ('$name')";

    MyController.database!.rawInsert(sql);
    //print("Name : ${name}");
  }

  get_select() async {
    String sql1 = "select * from user";
    list.value = await MyController.database!.rawQuery(sql1);
    print("List : ${list}");
  }

  select_data(int ref) async {
    String qry1 = "select * from data where ref='$ref'";
    list_data.value = await MyController.database!.rawQuery(qry1);
    print("select: ${list_data.value}");
    print("qry: ${qry1}");
    String total_qry = "select sum(credit) from data where ref='$ref'";
    result.value = await MyController.database!.rawQuery(total_qry);
    print("result_credit: $result");
    String total_qry1 = "select sum(debit) from data where ref='$ref'";
    result1.value = await MyController.database!.rawQuery(total_qry1);
    print("result_credit: $result1");
    String qry2 =
        "select sum(credit),sum(debit),sum(credit)-sum(debit) as Difference from data where ref='$ref'";
    bal.value = await MyController.database!.rawQuery(qry2);

    // for(i.value=0;i<list.length;i++)
    //   {
    //     String qry2 =
    //         "select sum(credit),sum(debit),sum(credit)-sum(debit) as Difference from data where ref='$ref'";
    //     bal.value[i.value] = await MyController.database!.rawQuery(qry2);
    //     print('balance[i]:${bal.value[i.value]} ');
    //   }

    print("balance: $bal");
  }

  get_delete(int id) {
    get_Database();
    String sql2 = "delete from user where id='$id'";
    MyController.database!.rawDelete(sql2);
    print("sql: $sql2");
  }

  age_select(BuildContext context) async {
    DateTime? picked_date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2024));
    if (picked_date != null && picked_date != selectDate) {
      selectDate = picked_date;
    }
  }

  select_type(var transation_type) {
    sel_type.value = transation_type;
  }

  data_insert(int id, String date, String type, String amt, String per) async {
    if (type == "credit") {
      String insert_data =
          "insert into data(ref,date,type,credit,debit,perticuler) values ('$id','$date','$type','$amt','${0}','$per')";
      MyController.database!.rawInsert(insert_data);
    } else {
      String insert_data =
          "insert into data(ref,date,type,credit,debit,perticuler) values ('$id','$date','$type','${0}','$amt','$per')";
      MyController.database!.rawInsert(insert_data);
    }
  }

  balance() {}
}
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class MyController extends GetxController {
//   static Database? database;
//   RxList<Map> list = [{}].obs;
//   RxInt index = 0.obs;
//
//   get_Database() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'demo.db');
//
//     MyController.database = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//           // When creating the db, create the table
//           await db.execute(
//               'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT)');
//         });
//   }
//
//   get_insert(String name) async {
//     String sql = "insert into user (name) VALUES ('$name')";
//     MyController.database!.rawInsert(sql);
//     //print("Name : ${name}");
//   }
//
//   get_select()
//   async {
//     String sql1 = "select * from user where id = ${['id']}";
//     list.value = await MyController.database!.rawQuery(sql1);
//     print("List : ${list}");
//   }
//   get_delete(int id){
//     get_Database();
//   String sql2 = "delete from user where id='$id'";
//   MyController.database!.rawDelete(sql2);
//   print("sql=$sql2");
//   }
// }
