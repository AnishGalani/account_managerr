import 'package:account_managerr/dataentry.dart';
import 'package:account_managerr/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:account_managerr/mycontroller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController t1 = TextEditingController();
  MyController m = Get.put(MyController());
  List<Map> l = [];
  bool temp = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    m.get_Database();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: (m.temp.value)
            ? TextField(
                autofocus: true,
              )
            : Text(
                "Dashboard",
                style: TextStyle(fontSize: 20),
              ),
        actions: [
          IconButton(
              onPressed: () {
                m.temp.value = true;
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.account_circle_outlined),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "Account Manager",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 8, 0, 5),
                      child: Text(
                        "Credit(+)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Obx(
                          () => Text(m.result.value.isNotEmpty?"${m.result.value[0]['sum(credit)']}":"",

                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(20, 8, 0, 5),
                      child: Text(
                        "Debit(-)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Obx(
                          () => Text(m.result.isNotEmpty?"${m.result1.value[0]['sum(debit)']}":"",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(20, 8, 0, 5),
                      child: Text(
                        "Balance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Obx(
                          () => Text(m.result.isNotEmpty?"${m.bal.value[0]['Difference']}":"",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: InkWell(
                  onTap: (
                      ) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return  DashBoard();
                    },));
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.backup),
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Backup",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Settings",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        height: 60,
        width: 60,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: IconButton(
            color: Colors.white,
            iconSize: 35,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add new account",
                        selectionColor: Colors.deepPurple),
                    content: TextField(
                      controller: t1,
                      decoration: InputDecoration(hintText: "Account Name"),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("CANCEL")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple),
                              onPressed: () {
                                String s1 = t1.text;
                                m.get_Database();
                                m.get_insert(s1);
                                // m.get_select();

                                Navigator.pop(context);
                                t1.text = "";
                              },
                              child: Text("SAVE")),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.library_add)),
      ),
      body: Obx(() => ListView.builder(
            itemCount: m.list.length,
            itemBuilder: (context, index) {
              //  m.select_data(m.list.value[index]['id']);
              return InkWell(
                onTap: () {
                  m.select_data(m.list.value[index]['id']);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Data_entry(m.list.value[index]['name'],
                          m.list.value[index]['id']);
                    },
                  ));
                },
                child: Card(
                  color: Colors.white70,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 160,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                  "${m.list.value[index]['name']}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: Colors.deepPurple,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        m.get_delete(m.list.value[index]['id']);
                                      },
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.deepPurple,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    height: 140,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Card(
                                            child: Container(
                                              // alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Credit(+)",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Obx(
                                                        () => Text(m.result.value.isNotEmpty?"${m.result.value[0]['sum(credit)']}":"",

                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   "${0}",
                                                  //   style:
                                                  //       TextStyle(fontSize: 20),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Card(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Debit(-)",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Obx(
                                                        () => Text(m.result.isNotEmpty?"${m.result1.value[0]['sum(debit)']}":"",
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   "${0}",
                                                  //   style:
                                                  //       TextStyle(fontSize: 20),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Card(
                                            child: Container(
                                              color: Colors.deepPurple,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Balance",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                  Obx(
                                                        () => Text(m.result.isNotEmpty?"${m.bal.value[0]['Difference']}":"",
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   "${0}",
                                                  //   style:
                                                  //       TextStyle(fontSize: 20),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
// import 'package:account_managerr/dataentry.dart';
// import 'package:account_managerr/mycontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
//
//
//
// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);
//
//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {
//   TextEditingController t1 = TextEditingController();
//   TextEditingController backup1 = TextEditingController();
//   TextEditingController restore1 = TextEditingController();
//   TextEditingController currency1 = TextEditingController();
//   TextEditingController Password1 = TextEditingController();
//   TextEditingController newpassword1 = TextEditingController();
//   TextEditingController change_s_qu1 = TextEditingController();
//   TextEditingController change_s_qu2 = TextEditingController();
//   MyController m = Get.put(MyController());
//   List<Map> l = [];
//   bool temp = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     temp = true;
//     m.get_Database();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(
//             "Dashboard",
//             style: TextStyle(fontSize: 20),
//           ),
//           actions: [
//             IconButton(onPressed: () {
//             }, icon: Icon(Icons.search)),
//          PopupMenuButton(
//            icon: Icon(Icons.more_vert),
//            initialValue: "",
//            itemBuilder: (context) => [
//            PopupMenuItem(child: Text("Save as PDF"),
//            value: "first",
//            ),
//            PopupMenuItem(child: Text("Save as Excel"),
//              value: "second",
//            ),
//          ],
//            onSelected: (value) {
//              print(value);
//            },
//            onCanceled: () {
//              print("Cancel");
//            },
//          )
//          //   IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
//           ],
//         ),
//         drawer: Drawer(
//           child: Container(
//             child: ListView(
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   height: 250,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.all(10),
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.white, shape: BoxShape.circle),
//                         child: Icon(Icons.account_circle_outlined),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         child: Text(
//                           "Account Manager",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                            // decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       Container(margin: EdgeInsets.all(5),height: 1,color: Colors.white,),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.fromLTRB(20, 8, 0, 5),
//                             child: Text(
//                               "Credit(+)",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Text("₹0",style: TextStyle(color: Colors.white),),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.fromLTRB(20, 8, 0, 5),
//                             child: Text(
//                               "Debit(-)",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Text("₹0",style: TextStyle(color: Colors.white),),
//                         ],
//                       ),
//                       Container(margin: EdgeInsets.all(5),height: 1,color: Colors.white,),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),
//                       Row(
//                         children: [
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.fromLTRB(20, 8, 0, 5),
//                             child: Text(
//                               "Balance",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Text("₹0",style: TextStyle(color: Colors.white),),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                           onTap: () {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                                   return DashBoard();
//                                 }));
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.home),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Home",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Container(
//                                         height: 30,
//                                         padding: EdgeInsets.all(5),
//                                         color: Colors.deepPurple,
//                                         child: Text(
//                                           "BACKUP",
//                                           style: TextStyle(fontSize: 20),
//                                         )),
//                                     content: TextField(
//                                       controller: backup1,
//                                       decoration: InputDecoration(
//                                           hintText: "Backup Name",
//                                           labelText: "Backup Name"),
//                                     ),
//                                     actions: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "CANCEL",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "SAVE",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.backup),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Backup",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Container(
//                                         height: 30,
//                                         padding: EdgeInsets.all(5),
//                                         color: Colors.deepPurple,
//                                         child: Text(
//                                           "Restore",
//                                           style: TextStyle(fontSize: 20),
//                                         )),
//                                     content: TextField(
//                                       controller: restore1,
//                                       decoration: InputDecoration(
//                                           hintText: "Restore Name",
//                                           labelText: "Restore Name"),
//                                     ),
//                                     actions: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "CANCEL",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "SAVE",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.restore),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Restore",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Container(
//                                         height: 30,
//                                         padding: EdgeInsets.all(5),
//                                         color: Colors.deepPurple,
//                                         child: Text(
//                                           "Change currency",
//                                           style: TextStyle(fontSize: 20),
//                                         )),
//                                     content: TextField(
//                                       controller: currency1,
//                                       decoration: InputDecoration(
//                                           hintText: "", labelText: ""),
//                                     ),
//                                     actions: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "CANCEL",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "SAVE",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.settings),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Change currency",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Container(
//                                         height: 30,
//                                         padding: EdgeInsets.all(5),
//                                         color: Colors.deepPurple,
//                                         child: Text(
//                                           "Change Password",
//                                           style: TextStyle(fontSize: 20),
//                                         )),
//                                     content: Column(
//                                       children: [
//                                         TextField(
//                                           controller: Password1,
//                                           decoration: InputDecoration(
//                                               hintText: "Current Password",
//                                               labelText: "Current Password",
//                                               icon: Icon(
//                                                   Icons.remove_red_eye_sharp)),
//                                         ),
//                                         TextField(
//                                           controller: newpassword1,
//                                           decoration: InputDecoration(
//                                               hintText: "New Password",
//                                               labelText: "New Password"),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "CANCEL",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "SAVE",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.settings),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Change Password",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Center(
//                                       child: Text("change security question"),
//                                     ),
//                                     content: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Radio(
//                                                 value: temp,activeColor: Colors.deepPurple,focusColor: Colors.red,
//                                                 groupValue: "",
//                                                 onChanged: (value){
//                                                   temp=value as bool;
//                                                 }),
//                                             Spacer(),
//                                             Text(
//                                               "Set security questions \nfor retrieve  your password \nwhen you forgot.",style: TextStyle(fontSize: 14),maxLines: 3,),
//
//                                           ],
//                                         ),
//                                         TextField(
//                                           controller: change_s_qu1,
//                                           decoration: InputDecoration(
//                                               hintText: "Account Name",
//                                               labelText: "Account Name"),
//                                         ),
//                                         TextField(
//                                           controller: change_s_qu2,
//                                           decoration: InputDecoration(
//                                               hintText: "Account Name",
//                                               labelText: "Account Name"),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "CANCEL",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "SET",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.app_blocking_rounded),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Change Security question",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {},
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.settings),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Settings",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             // Share.share("", subject: 'Look what I made!');
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.share),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Share the app",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {},
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.star_rate),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Rate the app",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Container(
//                                         child: Text(
//                                             "Are you sure that you want to open this link in external browser?")),
//                                     actions: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "NO",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 80,
//                                           margin: EdgeInsets.all(5),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.deepPurple),
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             "YES",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.pink),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.policy),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Privacy policy",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {},
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.apps_sharp),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "More apps",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       InkWell(
//                           onTap: () {},
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(Icons.face_retouching_off_sharp),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 "Ads Free",
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // ListTile(
//                 //   leading: Icon(Icons.home),
//                 //   title: InkWell(
//                 //     onTap: () {},
//                 //     child: Container(
//                 //       height: 40,
//                 //       width: 80,
//                 //       alignment: Alignment.centerLeft,
//                 //       child: Text(
//                 //         "Home",
//                 //         style: TextStyle(color: Colors.black, fontSize: 15),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // ListTile(
//                 //   leading: Icon(Icons.backup),
//                 //   title: InkWell(
//                 //     onTap: () {},
//                 //     child: Container(
//                 //       height: 40,
//                 //       width: 80,
//                 //       alignment: Alignment.centerLeft,
//                 //       child: Text(
//                 //         "Backup",
//                 //         style: TextStyle(color: Colors.black, fontSize: 15),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // ListTile(
//                 //   leading: Icon(Icons.settings),
//                 //   title: InkWell(
//                 //     onTap: () {},
//                 //     child: Container(
//                 //       height: 40,
//                 //       width: 80,
//                 //       alignment: Alignment.centerLeft,
//                 //       child: Text(
//                 //         "Settings",
//                 //         style: TextStyle(color: Colors.black, fontSize: 15),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // ListTile(
//                 //   leading: Icon(Icons.logout),
//                 //   title: InkWell(
//                 //     onTap: () {},
//                 //     child: Container(
//                 //       height: 40,
//                 //       width: 80,
//                 //       alignment: Alignment.centerLeft,
//                 //       child: Text(
//                 //         "Logout",
//                 //         style: TextStyle(color: Colors.black, fontSize: 15),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: Container(
//           margin: EdgeInsets.all(20),
//           height: 60,
//           width: 60,
//           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//           child: IconButton(
//               color: Colors.white,
//               iconSize: 35,
//               onPressed: () {
//                 temp = true;
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text("Add new account",
//                           selectionColor: Colors.deepPurple),
//                       content: TextField(
//                         controller: t1,
//                         decoration: InputDecoration(hintText: "Account Name"),
//                       ),
//                       actions: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.deepPurple),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text("CANCEL")),
//                             ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.deepPurple),
//                                 onPressed: () {
//                                   temp = true;
//                                   String s1 = t1.text;
//                                   m.get_insert(s1);
//                                   m.get_select();
//                                   Navigator.pop(context);
//                                   t1.text = "";
//                                 },
//                                 child: Text("SAVE")),
//                           ],
//                         )
//                       ],
//                     );
//                   },
//                 );
//               },
//               icon: Icon(Icons.add_box_outlined)),
//         ),
//         body: (temp)
//             ? Obx(
//               () => ListView.builder(
//             itemCount: m.list.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   String Name = m.list.value[index]['name'].toString();
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return Data_Entry(Name);
//                     },
//                   ));
//                 },
//                 child: Card(
//                   color: Colors.white70,
//                   margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: Container(
//                     margin: EdgeInsets.all(10),
//                     height: 140,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 150,
//                               child: Text(
//                                 "${m.list.value[index]['name']}",
//                                 style: TextStyle(
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 120,
//                             ),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                     Icons.mode_edit_outline_rounded)),
//                 IconButton(onPressed: () {
//                       m.get_delete(m.list.value[index]['id']);
//                     }, icon: Icon(Icons.delete)),
//                                   // IconButton(
//                                   //     onPressed: () {
//                             //
//                             //       showDialog(
//                             //           context: context,
//                             //           builder: (context) {
//                             //             return AlertDialog(
//                             //               title: Text(
//                             //                   "Are you sure ?"),
//                             //               content: Text("you want to delete account"),
//                             //               actions: [
//                             //                 Text(
//                             //                   "CANCEL",
//                             //                   style: TextStyle(
//                             //                       fontSize: 15,
//                             //                       fontWeight: FontWeight.bold,
//                             //                       color: Colors.pink),
//                             //                 ),
//                             //                 IconButton(onPressed: () {
//                             //                   m.get_delete(m.list.value[index]["id"]);
//                             //                 }, icon: Icon(Icons.delete)),
//                             //                 InkWell(
//                             //                   onTap: () {
//                             //
//                             //                   Navigator.pop(context);
//                             //                   },
//                             //                   child: Container(
//                             //                     height: 30,
//                             //                     width: 80,
//                             //                     margin: EdgeInsets.all(5),
//                             //                     alignment: Alignment.center,
//                             //                     decoration: BoxDecoration(
//                             //                         border: Border.all(
//                             //                             width: 1,
//                             //                             color: Colors.deepPurple),
//                             //                         borderRadius:
//                             //                         BorderRadius.circular(5)),
//                             //                     child: Text(
//                             //                       "DELETE",
//                             //                       style: TextStyle(
//                             //                           fontSize: 15,
//                             //                           fontWeight: FontWeight.bold,
//                             //                           color: Colors.pink),
//                             //                     ),
//                             //                   ),
//                             //                 ),
//                             //               ],
//                             //             );
//                             //           });
//                             //     },
//                             //     icon: Icon(Icons.delete,
//                             //
//                             //     ))
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               height: 80,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade400,
//                                 borderRadius: BorderRadius.circular(5)
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Credit(+)",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                   Text(
//                                     "${0}",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 80,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade500,
//                                 borderRadius: BorderRadius.circular(5)
//                               ),
//                               alignment: Alignment.center,
//                               child: Column(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Debit(-)",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                   Text(
//                                     "${0}",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 80,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 color: Colors.deepPurple,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Balance",
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white),
//                                   ),
//                                   Text(
//                                     "${0}",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         )
//             : Text(""));
//   }
// }
