import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gp/shared/components.dart';

import 'employees.dart';
import 'models/employee.dart';

class EditEmployees extends StatefulWidget {
  String empId;
  EditEmployees({this.empId});
  @override
  _EditEmployeesState createState() => _EditEmployeesState();
}

class _EditEmployeesState extends State<EditEmployees> {
  static List<String> Items = [
    'Jan',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String bonusMonth ;
  String punishMonth ;
  //final Color dark = Color(0xff060822);
  final Color dark = const Color(0XFF241e4e);
  final Color color1 = const Color(0xff4a4d6f);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: dark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Stack(children: [
                //padding: const EdgeInsets.only(top: 10),
                SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.4,
                  //width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'asset/edit4.png',

                      // fit: BoxFit.fill,
                      //alignment: Alignment.topRight,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Performance',
                              style: TextStyle(
                                  color: dark,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: DropdownButton<String>(
                                  items: Items.map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: color1, fontSize: 16),
                                      ))).toList(),
                                  value: bonusMonth,
                                  iconSize: 42,
                                  isExpanded: true,
                                  iconEnabledColor: color1,
                                  menuMaxHeight: 400,
                                  hint: const Text(
                                    'select month',
                                    style: TextStyle(color: Color(0xff4a4d6f)),
                                  ),
                                  onChanged: (item) => setState(
                                      () => bonusMonth = item.toString()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextButton(
                                  onPressed: () async {
                                    if (bonusMonth!=null) {
                                      DocumentReference empRef =
                                          FirebaseFirestore.instance
                                              .collection("employees")
                                              .doc(widget.empId);
                                      // if first day of month then we restart counting from 1 as we look at each month performance
                                      var getdoc = await empRef.get();
                                      if (getdoc.exists) {
                                        List<String> bon =
                                            getdoc['bonus'].cast<String>() ?? [];
                                        bon.add(bonusMonth);
                                        await empRef.update({
                                          "bonus": bon,
                                        }).onError((error, stackTrace) => showToast(
                                            message: "Something went wrong",
                                            state: ToastStates.wrong,
                                            context: context));
                                        showToast(
                                            message: "Bonus added successfully",
                                            state: ToastStates.right,
                                            context: context);
                                      }
                                    } else{

                                      showToast(
                                            message: "No selected month",
                                            state: ToastStates.wrong,
                                            context: context);
                                    }
                                  
                                  },
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: dark,
                                      ),
                                      width: 300,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Add Bonus',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 26,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              height: 0.5,
                              color: dark,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: DropdownButton<String>(
                                  items: Items.map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: color1, fontSize: 16),
                                      ))).toList(),
                                  value: punishMonth,
                                  iconSize: 42,
                                  isExpanded: true,
                                  iconEnabledColor: color1,
                                  menuMaxHeight: 400,
                                  hint: const Text('select month',
                                      style:
                                          TextStyle(color: Color(0xff4a4d6f))),
                                  onChanged: (item) => setState(() {
                                    punishMonth = item.toString();
                                  }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextButton(
                                  onPressed: () async {
                                    if (bonusMonth!=null) {
                                      DocumentReference empRef =
                                          FirebaseFirestore.instance
                                              .collection("employees")
                                              .doc(widget.empId);
                                      // if first day of month then we restart counting from 1 as we look at each month performance
                                      var getdoc = await empRef.get();
                                      if (getdoc.exists) {
                                        List<String> pun =
                                            getdoc['punishment'].cast<String>() ?? [];
                                        pun.add(punishMonth);
                                        await empRef.update({
                                          "punishment": pun,
                                        }).onError((error, stackTrace) => showToast(
                                            message: "Something went wrong",
                                            state: ToastStates.wrong,
                                            context: context));
                           
                                        showToast(
                                            message: "Punishment added successfully",
                                            state: ToastStates.right,
                                            context: context);
                                      }
                                    }
                                    else{

                                      showToast(
                                            message: "No selected month",
                                            state: ToastStates.wrong,
                                            context: context);
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: dark,
                                      ),
                                      width: 300,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Add Punshiment',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 26,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
