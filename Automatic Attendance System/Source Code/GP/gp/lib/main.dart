import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp/Home.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        theme: ThemeData(
          // listTileTheme: ListTileThemeData(dense: true, textColor: Colors.white, tileColor: Color(0XFF2c255c)),

          // primarySwatch: Colors.blue,
          //floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 15, backgroundColor: Color(0XFFfef3b4)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 15, backgroundColor: Color.fromARGB(255, 50, 53, 104)),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              
              
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
              /* textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.purple)), */
              backgroundColor: MaterialStateProperty.all(
                const Color(0XFF241e4e),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),
        home: MyHomePage());
  }
}
