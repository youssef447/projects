import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gp/shared/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final Color dark = const Color(0XFF241e4e);
  final Color color1 = const Color(0xff4a4d6f);
  String url = "";

  Uint8List bytes;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController hiringdateController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController salaryController = TextEditingController();
  TextEditingController depController = TextEditingController();
  TextEditingController worktimeController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  bool loading=false;
  File file;

  _handleDate() async {
    String _date = DateFormat.yMMMd().format(DateTime.now());
    final date = await showDatePicker(
        
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime.now());

    if (date != null) {
      _date = DateFormat.yMMMd().format(date);
    }
    setState(() {
      birthdateController.text = _date;
    });
  }

  _handleDate2() async {
    String _date = DateFormat.yMMMd().format(DateTime.now());
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime.now());

    if (date != null) {
      _date = DateFormat.yMMMd().format(date);
    }
    setState(() {
      hiringdateController.text = _date;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: keyboardIsOpened
              ? null
              : FloatingActionButton(
                  child: !loading? const Icon(Icons.add):const CircularProgressIndicator(color: Colors.white,),
                  backgroundColor: const Color.fromARGB(255, 54, 48, 91),
                  onPressed: () async {
                    if (formKey.currentState.validate() && file != null) {
                      formKey.currentState.save();
                      setState(() {
                        loading=true;
                      });
                      //add emp to database
                      var uploadTask = storageRef
                          .child(idController.text)
                          .child(idController.text)
                          .putFile(file);
                      await uploadTask.whenComplete(() async {
                       

                        url = await storageRef.child(idController.text)
                          .child(idController.text).getDownloadURL();
                        
                        await addData();
                      });
                    }
                  }),
          backgroundColor: dark,
          body: Column(
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
                      'asset/HR.png',

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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Employee Info',
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? 15
                                : 45,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: GestureDetector(
                              onTap: () async {
                                await _pickImage();
                              },
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            const Color(0XFF241e4e),
                                        radius: 47,
                                        backgroundImage: file != null
                                            ? FileImage(file)
                                            : null),
                                    file != null
                                        ? SizedBox()
                                        : Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                          ),
                                  ]),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter name';
                                  }
                                },
                                label: 'full name',
                                prefix: Icons.person),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter email';
                                  }
                                },
                                label: 'email',
                                prefix: Icons.email),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                              controller: idController,
                              type: TextInputType.number,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter id';
                                }
                              },
                              label: 'Id',
                              prefix: Icons.numbers_rounded,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                              controller: phoneController,
                              //isPassword: cubit.isPassword,
                              type: TextInputType.phone,

                              onSubmit: (value) {},

                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter phone';
                                }
                              },
                              label: 'Phone',
                              prefix: Icons.phone,
                              //suffix: cubit.suffix,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                              controller: birthdateController,
                              readonly: true,
                              onTap: _handleDate,
                              validate: (str) {
                                return str.trim().isEmpty
                                    ? 'Please Pick a date'
                                    : null;
                              },
                              label: 'birth date',
                              prefix: Icons.date_range,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                              controller: hiringdateController,
                              readonly: true,
                              onTap: _handleDate2,
                              validate: (str) {
                                return str.trim().isEmpty
                                    ? 'Please Pick a date'
                                    : null;
                              },
                              label: 'hiring date',
                              prefix: Icons.date_range,
                            ),
                          ),
                          /////////////////job infoooooo

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                                controller: depController,
                                type: TextInputType.name,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter department';
                                  }
                                },
                                label: 'Department',
                                prefix: Icons.category_sharp),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                                controller: jobController,
                                type: TextInputType.name,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter job title';
                                  }
                                },
                                label: 'job title',
                                prefix: Icons.work_outline),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                                controller: salaryController,
                                //isPassword: cubit.isPassword,
                                type: TextInputType.number,
                                onSubmit: (value) {},
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter salary';
                                  }
                                },
                                label: 'Salary',
                                prefix: Icons.attach_money_outlined
                                //suffix: cubit.suffix,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: defaultFormField(
                              controller: worktimeController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter work time';
                                }
                              },
                              label: 'work time',
                              prefix: Icons.timelapse,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _pickImage() async {
    imageCache.clear();
    imageCache.clearLiveImages();
    Directory dir = await getApplicationDocumentsDirectory();

    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    bytes = await image.readAsBytes();
    String appDocumentsPath = dir.path; // 2
    String filePath = '$appDocumentsPath/{${idController.text}}';
    file = File(filePath);
    await file.writeAsBytes(bytes);
    setState(() {});
    //final storageRef = FirebaseStorage.instance.ref();
  }

  addData() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("employees");
    await userRef.doc(idController.text).set({
      "name": nameController.text,
      "id":idController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "birth_date": birthdateController.text,
      "hiring_date": hiringdateController.text,
      "salary": salaryController.text,
      "job_title": jobController.text,
      "department" :depController.text,
      "work time": worktimeController.text,
      "absence": 0,
      "attended":0,
      "late": 0,
      "bonus": [],
      "punishment": [],
      "image url": url
    }).then((value) {
        setState(() {
          loading=false;
        });
      showToast(
       
          message: "emp added Successfully",
          state: ToastStates.right,
          context: context);
    }).catchError((onError) {
      
      showToast(
          message: "something went wrong",
          state: ToastStates.error,
          context: context);
    });
  }
}
