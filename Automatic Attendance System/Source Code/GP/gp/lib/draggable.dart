import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'models/employee.dart';

class DraggableWidget extends StatefulWidget {
  final Emp emp;
  final String hero;
  const DraggableWidget({
    @required this.hero,
    @required this.emp,
  });
  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  double openH = 20;
  bool isopen = false;
  double initialSize = 0.75;
  List<StatData> EmpAtt;
  List<StatData> FinData;
  @override
  void initState() {
    EmpAtt = getAttData();
    FinData = getFinanceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0XFF241e4e),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // go to emp_profile
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.hero,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 43,
                            backgroundImage: NetworkImage(widget.emp.image),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.emp.name,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.emp.jobTitle,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  backgroundColor: Color(0xff690303),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        DraggableScrollableSheet(
            // Scrollable Sheet
            maxChildSize: topEnding(),
            minChildSize: 0.75,
            initialChildSize: initialSize,
            builder: (context, controler) => SingleChildScrollView(
                  controller: controler,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius:  BorderRadius.only(
                        topLeft:  Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      //color: Color(0xff4b19c9),

                      color:  Color(0xff4a4d6f),
                    ),
                    width: double.infinity,
                    height: screenSize(),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            //color: Color(0xff4b19c9),
                            color: Color(0xff4a4d6f),
                          ),
                          height: 50, // clickable blue
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isopen == true) {
                                  isopen = false;
                                } else {
                                  isopen = true;
                                }
                                isopen ? initialSize = 0.9 : initialSize = 0.75;
                                isopen ? openH = 200 : openH = 20;
                              });
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  //color: Color(0xff4b19c9),
                                  color: Color(0xff4a4d6f),
                                ),
                                padding: const EdgeInsets.only(left: 30),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Performance',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        getChart1(),
                        Container(
                          //                                            ***** white
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: whiteSpace(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    // SizedBox(
                                    //   height: 0,
                                    // ),
                                    ExpansionTile(
                                      title: const Text('Personal Info',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          )),
                                      leading: const Icon(Icons.person),
                                      iconColor: const Color(0xff4a4d6f),
                                      collapsedIconColor:
                                          const Color(0xff060822),
                                      textColor: const Color(0xff4a4d6f),
                                      collapsedTextColor:
                                          const Color(0xff060822),
                                      backgroundColor: Colors.grey[50],
                                      childrenPadding:
                                          const EdgeInsets.only(left: 50),
                                      children: [
                                        ListTile(
                                          title:
                                              Text('Name: ${widget.emp.name}'),
                                        ),
                                        ListTile(
                                          title: Text('ID: ${widget.emp.id}'),
                                        ),
                                        ListTile(
                                          title:
                                              Text('pho: ${widget.emp.phone}'),
                                        ),
                                        ListTile(
                                          title: Text('dep: ${widget.emp.dep}'),
                                        ),
                                        /*  ListTile(
                                          title: Text('birthdate : ${widget.emp.birthd}'),
                                        ), */
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: const Text('Job Info',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          )),
                                      leading: const Icon(Icons.shopping_bag),
                                      iconColor: const Color(0xff4a4d6f),
                                      collapsedIconColor:
                                          const Color(0xff060822),
                                      textColor: const Color(0xff4a4d6f),
                                      collapsedTextColor:
                                          const Color(0xff060822),
                                      backgroundColor: Colors.grey[50],
                                      childrenPadding:
                                          const EdgeInsets.only(left: 50),
                                      children: [
                                        ListTile(
                                          title: Text(
                                              'work time: ${widget.emp.work_time}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'salary: \$${widget.emp.salary}'),
                                        ),
                                        /* ListTile(
                                          title:  Text('8 hours'),
                                        ),
                                         ListTile(
                                          title:  Text('from 8 am'),
                                        ), */
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: const Text('Lates',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          )),
                                      leading: const Icon(Icons.watch),
                                      iconColor: const Color(0xff4a4d6f),
                                      collapsedIconColor:
                                          const Color(0xff060822),
                                      textColor: const Color(0xff4a4d6f),
                                      collapsedTextColor:
                                          const Color(0xff060822),
                                      backgroundColor: Colors.grey[50],
                                      childrenPadding:
                                          const EdgeInsets.only(left: 50),
                                      children: [
                                        ListTile(
                                          title: Text(
                                              'Attended late ${widget.emp.late} days'),
                                        ),
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: const Text(
                                        'Absence',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      leading: const Icon(Icons.not_interested),
                                      iconColor: const Color(0xff4a4d6f),
                                      collapsedIconColor:
                                          const Color(0xff060822),
                                      textColor: const Color(0xff4a4d6f),
                                      collapsedTextColor:
                                          const Color(0xff060822),
                                      backgroundColor: Colors.grey[50],
                                      childrenPadding:
                                          const EdgeInsets.only(left: 50),
                                      children: [
                                        ListTile(
                                          title: Text(
                                            DateTime.now().day - widget.emp.attended<0?
                                            'Missed 0 days'
                                             : 'Missed ${DateTime.now().day - widget.emp.attended} days'),
                                        ),
                                      ],
                                    ),
                                    ExpansionTile(
                                        title: const Text('Bonus',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            )),
                                        leading: const Icon(Icons.add),
                                        iconColor: const Color(0xff4a4d6f),
                                        collapsedIconColor:
                                            const Color(0xff060822),
                                        textColor: const Color(0xff4a4d6f),
                                        collapsedTextColor:
                                            const Color(0xff060822),
                                        backgroundColor: Colors.grey[50],
                                        childrenPadding:
                                            const EdgeInsets.only(left: 50),
                                        children: widget.emp.bonus.map((e) {
                                          return ListTile(
                                            title: Text(e),
                                          );
                                        }).toList()),
                                    ExpansionTile(
                                      title: const Text('Punishment',
                                          style:  TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          )),
                                      leading: const Icon(Icons.remove),
                                      iconColor: const Color(0xff4a4d6f),
                                      collapsedIconColor:
                                          const Color(0xff060822),
                                      textColor: const Color(0xff4a4d6f),
                                      collapsedTextColor:
                                          const Color(0xff060822),
                                      backgroundColor: Colors.grey[50],
                                      childrenPadding:
                                          const EdgeInsets.only(left: 50),
                                      children: widget.emp.punishments.map((e) {
                                          return ListTile(
                                            title: Text(e),
                                          );
                                        }).toList()),
                                      
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
      ],
    ));
  }

  double screenSize() {
    double height = MediaQuery.of(context).size.height;
    double barHeight = MediaQuery.of(context).viewPadding.top;
    var safeHeight = height - barHeight;
    return safeHeight;
  }

  double topEnding() {
    double height = MediaQuery.of(context).size.height;
    double barHeight = MediaQuery.of(context).viewPadding.top;
    double h = ((height - barHeight) / height);
    return h;
  }

  double whiteSpace() {
    double height = MediaQuery.of(context).size.height;
    double barHeight = MediaQuery.of(context).viewPadding.top;
    double w;
    if (isopen)
      w = height -
          barHeight -
          50 -
          160; //  50 -> clickable blue + 10 sized box + 150 getChart1
    else
      w = height - barHeight - 50 - 10; //  50 -> clickable blue + 10 sized box
    return w;
  }

  List<StatData> getAttData() {
    final List<StatData> AttData = [
      StatData('Presence', widget.emp.attended),
      StatData('Absence', widget.emp.absence),
      StatData('Late', widget.emp.late),
    ];
    return AttData;
  }

  List<StatData> getFinanceData() {
    final List<StatData> FinanceData = [
      StatData('Normal', widget.emp.attended-widget.emp.late),
      StatData('Bonus', widget.emp.bonus.length),
      StatData('Punishment', widget.emp.punishments.length),
    ];
    return FinanceData;
  }

  Widget getChart1() {
    if (isopen == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 150,
                height: 150,
                child: SfCircularChart(
                  palette: [
                    const Color(0xff93c8f8),
                    const Color(0xff0b5394),
                    const Color(0xff3d85c6),
                  ],
                  series: <CircularSeries>[
                    PieSeries<StatData, String>(
                      dataSource: EmpAtt,
                      xValueMapper: (StatData data, _) => data.behavior,
                      yValueMapper: (StatData data, _) => data.times,
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      color: const Color(0xff93c8f8),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child:  Text(
                        'presence',
                        style:
                             TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      color: const Color(0xff3d85c6),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: const Text(
                        'Late',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      color: const Color(0xff0b5394),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: const Text(
                        'Absence',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                width: 150,
                height: 150,
                child: SfCircularChart(
                  palette: [
                    const Color(0xffcdacac),
                    const Color(0xffb14e4e),
                    const Color(0xff690303),
                  ],
                  series: <CircularSeries>[
                    PieSeries<StatData, String>(
                      dataSource: FinData,
                      xValueMapper: (StatData data, _) => data.behavior,
                      yValueMapper: (StatData data, _) => data.times,
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      color: const Color(0xffcdacac),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: const Text(
                        'Normal',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      color: const Color(0xffb14e4e),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: const Text(
                        'Bonus',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      color: const Color(0xff690303),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Punishment',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    } else
      return const SizedBox(
        height: 0,
      );
  }
}

class StatData {
  StatData(this.behavior, this.times);
  final String behavior;
  final int times;
}
