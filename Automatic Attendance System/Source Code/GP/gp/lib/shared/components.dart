import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:gp/adminSignup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../draggable.dart';
import '../edit_employee.dart';
import '../models/employee.dart';

final storageRef = FirebaseStorage.instance.ref();

Future<Directory> getAppDir() async => await getApplicationDocumentsDirectory();
Image profile;

enum _MenuValues {
  edit,
  delete,
}
/* Widget empCardItems() {
    return Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
      Container(
        alignment: Alignment.bottomCenter,
        height: 110,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF3d3963).withOpacity(0.4),
              //spreadRadius: 11,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
          //color: Color(0XFF241e4e),
          //color: Color(0XFF055680),
          color: Color(0XFF434273),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Raze",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            "Valorant Agent",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ]),

        /*  Spacer(),
            Column(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ),
                //IconButton(onPressed: null, icon: Icon(Icons.edit, color: Colors.white)),
                Expanded(
                  child: Image(
                    image: AssetImage('assets/performance.png'),
                  ),
                )
              ],
            )
          */
      ),
      Positioned(
        top: -5,
        child: CircleAvatar(
          radius: 35,
          backgroundColor: Color(0XFF3d3963),
          child: CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage("https://valorant-guides.netlify.app/images/agents/Raze.jpg"),
          ),
        ),
      ),
      //child: Image.network("https://valorant-guides.netlify.app/images/agents/Raze.jpg"),

      // backgroundImage: NetworkImage("https://valorant-guides.netlify.app/images/agents/Raze.jpg"),
    ]);
  } */

/*  Widget search(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 45,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                //shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Row(children: [
                Icon(Icons.search),
                SizedBox(width: 20),
                Text('Search')
              ]),
            ),
          ),
        ),
      ],
    );
  }
 */
/* Future<Image> getImageFromFile(File file) async {
  List<int> imageBase64 = file.readAsBytesSync();
  String imageAsString = base64Encode(imageBase64);
  Uint8List uint8list = base64.decode(imageAsString);
  Image image = Image.memory(uint8list);
  return image;
} */

Widget empItems(
    {@required Emp data,
    @required BuildContext ctx,
    @required Orientation or}) {
  //final pathReference = storageRef.child("${data.id}/${data.id}.jpg");
  /* Directory d;
  getAppDir().then((value) {
    d = value.absolute;
    print("ddddddddddddddddddddddddd");
    print(pathReference.fullPath);
    final filePath = "${d.path}/${data.id}.jpg";
   file = File(filePath);
  
//  pathReference.writeToFile(file).;

  });  */

/* getImageFromFile(file).then((value) {

  profile=value;
}); */

  return data==null?const SizedBox() :GestureDetector(
    onTap: () {
      Navigator.of(ctx).push(MaterialPageRoute(
          builder: (ctx) => DraggableWidget(
                hero: data.id.toString(),
                emp: data,
              )));
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0XFF2c255c), // Color(0XFF060822),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            //spreadRadius: 11,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        //color: Color(0XFF241e4e),
        //color: Color(0XFF055680),

        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      // height: 150,
      width: MediaQuery.of(ctx).size.width * 0.3,
      margin: or == Orientation.portrait
          ? const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
          : const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: data.id.toString(),
                  child: CircleAvatar(
                    radius: 37,
                    backgroundImage: NetworkImage(data.image),
                  ),
                ),
                const Spacer(),
                //Icon(Icons.more_vert, color: Colors.white),
                PopupMenuButton(
                  // color: Color(0XFF2c255c),

                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      child: ListTile(
                        dense: true,
                        trailing: Icon(
                          Icons.attach_money,
                        ),
                        title: FittedBox(
                          child: Text(
                            'Bonus/Punishment',
                            //style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      value: _MenuValues.edit,
                    ),
                    PopupMenuItem(
                      child: Container(
                        color: Colors.red,
                        child: const ListTile(
                          dense: true,
                          trailing: Icon(Icons.delete, color: Colors.white),
                          title: Text(
                            'Delete ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      value: _MenuValues.delete,
                    ),
                  ],
                  onSelected: (value) async {
                    switch (value) {
                      case _MenuValues.edit:
                        Navigator.of(ctx).push(
                          MaterialPageRoute(
                            builder: (ctx) => EditEmployees(
                              empId: data.id,
                            ),
                          ),
                        );
                        break;
                      case _MenuValues.delete:
                        await delete_employee(data.id);
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ]),

          FittedBox(
            child: Text(
              data.name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),

          // SizedBox(height: 4),
          FittedBox(
            child: Text(
              data.jobTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),

          FittedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 5, top: 9, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0XFF40434c),
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 2.0),
                    child: Icon(Icons.done, color: Colors.green),
                  ),
                  Text(
                    data.email,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            "commitment",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 3,
          ),

          //Divider(color: Colors.white, height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: data.attended / DateTime.now().day,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.green),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ]),
          ),

          FittedBox(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.work_time,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Text(
                    "\$${data.salary.toString()}/M",
                    style: TextStyle(color: Colors.white),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Text(
                    "${data.dep}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showToast(
    {@required String message,
    @required ToastStates state,
    @required context}) {
  Toast.show(message, context,
      duration: Toast.lengthLong,
      backgroundColor: ToastColor(state),
      gravity: Toast.bottom);
}

enum ToastStates { error, wrong, right }

Color ToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.wrong:
      color = Colors.amber;
      break;
    case ToastStates.right:
      color = Color.fromARGB(255, 174, 168, 207);
      break;
  }
  return color;
}

/* Widget defaultButton({
  double width = double.infinity,
  Color background = const Color.fromARGB(51, 30, 37, 105),
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
        width: width,
      child: MaterialButton(
        //minWidth: double.infinity,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
 */
Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  bool readonly = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      readOnly: readonly,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.all(30),

        // hintStyle:TextStyle (color:Colors.white),
        //labelStyle: const TextStyle(color: Colors.white),
        //labelText: label,
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: const Color(0XFF241e4e),
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: Colors.white,
                ),
              )
            : null,
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );

SafeArea adminSign(
    {BuildContext context,
    dynamic cubit,
    IconData icon,
    String title,
    bool signIn,
    bool signUp,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController idController,
    String heroTag,
    GlobalKey<FormState> formKey,
    bool keyboardIsOpened}) {
  return SafeArea(
    child: Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,

      floatingActionButton: keyboardIsOpened
          ? null
          : //cubit.loading
              //?  CircularProgressIndicator()
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: const Color.fromARGB(255, 54, 48, 91),
                  onPressed: () {
                    cubit.toggleLoading();
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      if (!signIn) {
                        cubit.signUp(
                            emailController.text,
                            passwordController.text,
                            idController.text,
                            context);
                        //show toast
                        //move to SignIn page

                      } else {
                        cubit.signIn(emailController.text,
                            passwordController.text, context);
                        //show toast
                        //move to Admin page

                      }
                    }
                  },
                  child: Icon(
                    icon,
                    color: Colors.white,
                  )),
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color.fromARGB(255, 182, 176, 250),
      //backgroundColor: Color.fromARGB(255, 197, 195, 234),
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ClipPath(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0XFF241e4e),
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage('asset/admin.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    clipper: _CustomClipper2(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: adminForm(context, title, signIn, emailController,
                      passwordController, idController, formKey),
                ),
              ],
            ),
             Positioned(
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed:(){ Navigator.of(context).pop();},
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget addEmpForm(
  BuildContext context,
  String title,
  TextEditingController nameController,
  TextEditingController phoneController,
  TextEditingController idController,
  TextEditingController jobController,
  GlobalKey<FormState> formKey,
) {}

Widget adminForm(
  BuildContext context,
  String title,
  bool signIn,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController idController,
  GlobalKey<FormState> formKey,
) {
  return Form(
      key: formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? 15
                : 45,
          ),
          defaultFormField(
            controller: emailController,
            type: TextInputType.emailAddress,
            validate: (String value) {
              if (value.isEmpty) {
                return 'please enter your email address';
              }
            },
            label: 'Email Address',
            prefix: Icons.email_outlined,
          ),
          SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? 15
                : 45,
          ),
          defaultFormField(
            controller: passwordController,
            //isPassword: cubit.isPassword,
            type: TextInputType.visiblePassword,
            isPassword: true,
            onSubmit: (value) {},
            suffixPressed: () {
              //cubit.changePasswordVisibility();
            },
            validate: (String value) {
              if (value.isEmpty) {
                return 'please enter your password';
              }
            },
            label: 'Password',
            prefix: Icons.lock_outline,
            //suffix: cubit.suffix,
          ),
          SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? 10
                : 30,
          ),
          if (signIn)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Do\'nt have an account? ',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminSignUp()),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 15
                      : 25,
            ),
          !signIn
              ? defaultFormField(
                  controller: idController,
                  type: TextInputType.number,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'please enter your id';
                    }
                  },
                  label: 'Id',
                  prefix: Icons.numbers_rounded,
                )
              : const SizedBox(),
        ],
      ));
}

/* class _CustomClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    Offset controlPoint = Offset(size.width * 0.2, size.height * 0.8);
    Offset endPoint = Offset(size.width * 0.28, size.height / 2);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    /////////////////////////////////////////////
    Offset controlPoint2 = Offset(size.width * 0.4, size.height / 8);
    Offset endPoint2 = Offset(size.width, 0);

    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    //path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
} */

class _CustomClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    Offset controlPoint = Offset(size.width * 0.2, size.height - 40);
    Offset endPoint = Offset(size.width * 0.5, size.height - 20);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    /////////////////////////////////////////////
    Offset controlPoint2 = Offset(size.width * 3 / 4, size.height);
    Offset endPoint2 = Offset(size.width, size.height - 30);

    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

delete_employee(String emp_id) async {
  CollectionReference usersref =
      FirebaseFirestore.instance.collection("employees");
  await usersref.doc(emp_id).delete();
  await FirebaseStorage.instance.ref("$emp_id/$emp_id").delete();
}
//gs://automatic-attendance-sys.appspot.com/54