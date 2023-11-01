import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gp/main.dart';
import 'package:gp/widget/date_picker.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'myAdd.dart';
import 'widget/stacked_widgets.dart';

class DayAttendance extends StatefulWidget {
  static const defultImages = [
    'https://patch.com/img/cdn20/users/22944156/20220602/035110/styles/patch_image/public/bestbuy___02152756085.jpg'
  ];

  @override
  State<DayAttendance> createState() => _DayAttendanceState();
}

class _DayAttendanceState extends State<DayAttendance> {
  DateTime date=DateTime.now();
  double widthOfScreen = 250;

  Color dark = const Color(0XFF241e4e);

  Color containerColor = const Color(0xffC8F7D5);

  Color color1 = const Color(0xff4a4d6f);

  CollectionReference daysRef =
      FirebaseFirestore.instance.collection("attendance");

  List<String> images8 = [];

  List<String> images9 = [];

  List<String> images10 = [];

  List<String> images11 = [];

  List<String> imagesL = [];

/* 
  List<String> id8 = [];

  List<String> id9 = [];

  List<String> id10 = [];

  List<String> id11 = [];

  List<String> idL = []; */
  @override
  Widget build(BuildContext context) {
    widthOfScreen = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: daysRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool found = true;
                    int index = 0;

                    print("${DateTime.now().day.toString()}d");

                    String n = "${DateTime.now().day.toString()}d";
                    index = date.day - 1;
                    //var doc = daysRef.doc(n).get();
                    //print('hnaaaaaaaaaahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhaaa');
                    //print(doc);

                    images8 = snapshot.data.docs[index]
                        .data()['08:00:AM']
                        .cast<String>();

                    //images8 = doc['08:00:AM'].cast<String>();

                    images9 = snapshot.data.docs[index]
                        .data()['09:00:AM']
                        .cast<String>();

                    images10 = snapshot.data.docs[index]
                        .data()['10:00:AM']
                        .cast<String>();

                    images11 = snapshot.data.docs[index]
                        .data()['11:00:AM']
                        .cast<String>();

                    imagesL =
                        snapshot.data.docs[index].data()['late'].cast<String>();
                  }
                  print(imagesL.length);

                  print('teeeeeeeeeeeeeeeeeest');
                  print(images8.length);
                  return Container(
                      color: dark,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 130,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, top: 30),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Attendance Page',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${date.year}/${date.month}/${date.day}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(dark),
                                      ),
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        DateTime newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: date,
                                          firstDate:
                                              DateTime(DateTime.now().year),
                                          lastDate: DateTime(2030),
                                        );
                                        if (newDate == null) return;
                                        if (newDate.month !=
                                            DateTime.now().month) return;
                                        if (newDate.day > DateTime.now().day)
                                          return;
                                        setState(() => date = newDate);
                                      }),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        //DatePicker(), //                   DatePicker**********************
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: TimelineTile(
                                                  alignment:
                                                      TimelineAlign.manual,
                                                  lineXY: 0.25,
                                                  hasIndicator: false,
                                                  afterLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  beforeLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  startChild: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      '08:00 AM',
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  endChild: Row(
                                                    children: [
                                                      buildExpandedBox(
                                                        color: const Color(
                                                            0xff87E0EA),
                                                        childrenNum:
                                                            //
                                                            images8.length,
                                                        children: [
                                                          buildStackedImages(
                                                              betweenColor:
                                                                  const Color(
                                                                      0xff87E0EA),
                                                              images: images8),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50, right: 10),
                                                child: TimelineTile(
                                                  alignment:
                                                      TimelineAlign.manual,
                                                  lineXY: 0.25,
                                                  hasIndicator: false,
                                                  afterLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  beforeLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  startChild: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      '09:00 AM',
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  endChild: Row(
                                                    children: [
                                                      buildExpandedBox(
                                                        color: const Color(
                                                            0xffFFC9BB),
                                                        childrenNum:
                                                            images9.length,
                                                        children: [
                                                          buildStackedImages(
                                                              betweenColor:
                                                                  const Color(
                                                                      0xffFFC9BB),
                                                              images: images9),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50, right: 10),
                                                child: TimelineTile(
                                                  alignment:
                                                      TimelineAlign.manual,
                                                  lineXY: 0.25,
                                                  hasIndicator: false,
                                                  afterLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  beforeLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  startChild: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      '10:00 AM',
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  endChild: Row(
                                                    children: [
                                                      buildExpandedBox(
                                                        color: const Color(
                                                            0xffC8D0F7),
                                                        childrenNum:
                                                            images10.length,
                                                        children: [
                                                          buildStackedImages(
                                                              betweenColor:
                                                                  const Color(
                                                                      0xffC8D0F7),
                                                              images: images10),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50, right: 10),
                                                child: TimelineTile(
                                                  alignment:
                                                      TimelineAlign.manual,
                                                  lineXY: 0.25,
                                                  hasIndicator: false,
                                                  afterLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  beforeLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  startChild: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      '11:00 AM',
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  endChild: Row(
                                                    children: [
                                                      buildExpandedBox(
                                                        color: const Color(
                                                            0xffC8F7D5),
                                                        childrenNum:
                                                            images11.length,
                                                        children: [
                                                          buildStackedImages(
                                                              betweenColor:
                                                                  const Color(
                                                                      0xffC8F7D5),
                                                              images: images11),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50, right: 10),
                                                child: TimelineTile(
                                                  alignment:
                                                      TimelineAlign.manual,
                                                  lineXY: 0.25,
                                                  hasIndicator: false,
                                                  afterLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  beforeLineStyle:
                                                      const LineStyle(
                                                          color: Colors.white,
                                                          thickness: 0),
                                                  startChild: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                      child: Text(
                                                        'Late',
                                                        style: TextStyle(
                                                            color: dark,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ), // photos are here ***********************************************************
                                                  endChild: Row(
                                                    children: [
                                                      buildExpandedBox(
                                                        color: const Color(
                                                            0xffFFC9BB),
                                                        childrenNum:
                                                            imagesL.length,
                                                        children: [
                                                          buildStackedImages(
                                                              betweenColor:
                                                                  const Color(
                                                                      0xffFFC9BB),
                                                              images: imagesL),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomeEmp()));
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomCenter,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        color: dark,
                                                      ),
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                              Icons.group,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Employees',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ));
                })));
  }

  Widget buildExpandedBox({
    List<Widget> children,
    Color color,
    int childrenNum = 0,
  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        width: (childrenNum < 5)
            ? (60 + ((childrenNum.toDouble() - 1) * 50))
            : (((50 * childrenNum.toDouble())) > 260)
                ? widthOfScreen - 120
                : ((50 * childrenNum.toDouble())),
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      );

  Widget buildStackedImages({
    TextDirection direction = TextDirection.ltr,
    Color betweenColor = Colors.white,
    List<String> images = DayAttendance.defultImages,
  }) {
    if (images.length == 0) {
      images = DayAttendance.defultImages;
    }
    final double size = 60;
    final double xShift = 15;
    final urlImages = images;

    final items = urlImages
        .map((urlImage) => buildImage(urlImage, betweenColor))
        .toList();

    return StackedWidgets(
      direction: direction,
      items: items,
      size: size,
      xShift: xShift,
    );
  }

/*   Future<List<String>> addImages(DocumentReference empRef, String key) async {
    var getdoc = await empRef.get();
    switch (key) {
      case "8":
        images8.add(getdoc.get('image url'));
        break;

      case "9":
        images9.add(getdoc.get('image url'));
        break;

      case "10":
        images10.add(getdoc.get('image url'));
        break;

      case "11":
        images11.add(getdoc.get('image url'));
        break;

      case "l":
        imagesL.add(getdoc.get('image url'));
        break;

      default:
        break;
    }

    //data = getdoc[tmp].cast<String>() ?? [];
  } */
  Widget buildImage(String urlImage, Color c1) {
    final double borderSize = 5;

    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(borderSize),
        color: c1,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
