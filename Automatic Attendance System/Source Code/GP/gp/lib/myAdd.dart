// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gp/add_employee.dart';

import 'package:gp/models/employee.dart';
import 'shared/components.dart';

class HomeEmp extends StatefulWidget {
  @override
  State<HomeEmp> createState() => _HomeEmpState();
}

class _HomeEmpState extends State<HomeEmp> {
  bool _isSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool _searchSubmitted = false;
  FocusNode focusNode;
  CollectionReference employees =
      FirebaseFirestore.instance.collection('employees');
  String name;
  String Email;
  String phone;
  int late;
  int absence;
  int attended;
  String job;
  String work_time;
  int salary;
  String dep;
  String id;
  String profileImage;
  List<String> bonus;
  List<String> punishments;
  List<Emp> empData = [];
  /*  List<Emp> filteredempData = [
    Emp(
        name: "Youssef Ashraf",
        email: "youssef.ashraf380@gmail.com",
        jobTitle: "not yet"),
    Emp(name: "test ", email: "Test380@gmail.com", jobTitle: "not yet"),
    Emp(name: "Raze", email: "Boom@gmail.com", jobTitle: "Valorant Agent"),
    Emp(name: "Raze", email: "Boom@gmail.com", jobTitle: "Valorant Agent"),
    Emp(name: "Raze", email: "Boom@gmail.com", jobTitle: "Valorant Agent"),
    Emp(name: "Raze", email: "Boom@gmail.com", jobTitle: "Valorant Agent"),
  ]; */
  List<Emp> filteredempData = [];
  Emp emp;
  String searchKey = "";
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSearch && !_searchSubmitted) focusNode.requestFocus();
    //if(_searchSubmitted) focusNode.unfocus();
    Orientation _dir = MediaQuery.of(context).orientation;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: _isSearch
              ? TextField(
                  focusNode: focusNode,
                  onSubmitted: (_) {
                    _searchSubmitted = true;
                    focusNode.unfocus();
                  },
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    searchKey = value;
                    _FilterEmp(value);
                  },
                  decoration: InputDecoration(

                      //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25)),
                      // fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      //filled: true,
                      //hoverColor: Colors.white,
                      hintText: ' search emp',
                      hintStyle: TextStyle(color: Colors.grey)),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearch = !_isSearch;
                    });
                  },
                  child: Text("Employees")),
          actions: [
            _isSearch
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearch = false;
                        searchKey="";
                        //show all items normally again
                        filteredempData = empData;
                      });
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearch = true;
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.person_add,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => AddEmployee()));
          },
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.,
        backgroundColor: const Color(0XFF241e4e), //Color(0XFF2c255c),
        body: StreamBuilder(
            stream: employees.snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: _dir == Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (searchKey.isNotEmpty) {
                          if (snapshot.data.docs[index]
                              .data()['name']
                              .toString()
                              .toLowerCase()
                              .startsWith(searchKey)) {
                            Email = snapshot.data.docs[index].data()['email'];
                            late = snapshot.data.docs[index].data()['late'];
                            absence =
                                snapshot.data.docs[index].data()['absence'];
                            attended =
                                snapshot.data.docs[index].data()['attended'];

                            job = snapshot.data.docs[index].data()['job_title'];
                            phone = snapshot.data.docs[index].data()['phone'];

                            name = snapshot.data.docs[index].data()['name'];
                            dep =
                                snapshot.data.docs[index].data()['department'];
                            id = snapshot.data.docs[index].data()['id'];
                            work_time =
                                snapshot.data.docs[index].data()['work time'];
                            profileImage =
                                snapshot.data.docs[index].data()['image url'];
                            punishments = snapshot.data.docs[index]
                                .data()['punishment']
                                .cast<String>();
                            bonus = snapshot.data.docs[index]
                                .data()['bonus']
                                .cast<String>();

                            salary = int.parse(
                                snapshot.data.docs[index].data()['salary']);

                            emp = Emp(
                                attended: attended,
                                absence: absence,
                                late: late,
                                dep: dep,
                                phone: phone,
                                bonus: bonus,
                                punishments: punishments,
                                image: profileImage,
                                email: Email,
                                jobTitle: job,
                                name: name,
                                id: id,
                                work_time: work_time,
                                salary: salary);
                            //filteredempData.add(emp);

                          }
                          else{
                            emp=null;
                          }
                        } 
                        
                        else {
                          Email = snapshot.data.docs[index].data()['email'];
                          late = snapshot.data.docs[index].data()['late'];
                          absence = snapshot.data.docs[index].data()['absence'];
                          attended =
                              snapshot.data.docs[index].data()['attended'];

                          job = snapshot.data.docs[index].data()['job_title'];
                          phone = snapshot.data.docs[index].data()['phone'];

                          name = snapshot.data.docs[index].data()['name'];
                          dep = snapshot.data.docs[index].data()['department'];
                          id = snapshot.data.docs[index].data()['id'];
                          work_time =
                              snapshot.data.docs[index].data()['work time'];
                          profileImage =
                              snapshot.data.docs[index].data()['image url'];
                          punishments = snapshot.data.docs[index]
                              .data()['punishment']
                              .cast<String>();
                          bonus = snapshot.data.docs[index]
                              .data()['bonus']
                              .cast<String>();

                          salary = int.parse(
                              snapshot.data.docs[index].data()['salary']);

                          emp = Emp(
                              attended: attended,
                              absence: absence,
                              late: late,
                              dep: dep,
                              phone: phone,
                              bonus: bonus,
                              punishments: punishments,
                              image: profileImage,
                              email: Email,
                              jobTitle: job,
                              name: name,
                              id: id,
                              work_time: work_time,
                              salary: salary);
                          //filteredempData.add(emp);
                        }
                        return empItems(
                            data:emp,
                            ctx: context,
                            or: _dir);
                      })
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
            }));
  }

  //searching
  void _FilterEmp(String searchKey) {
    setState(() {
      _isSearch = true;

      /* filteredempData = empData
          .where((element) =>
              element.name.toLowerCase().startsWith(searchKey.toLowerCase()))
          .toList(); */

      //employees.doc().get()
    });
  }
}
