import './add_employee.dart';
import './day_attendance.dart';
import './draggable.dart';
import './edit_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeesScreen extends StatefulWidget {
  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  Color dark = Color(0xff060822);

  Color color1 = Color(0xff4a4d6f);

  Color color2 = Colors.white;

  final names = [
    'Mazen Mohammed',
    'Youssef Hany',
    'Mohammed Ahmed',
    'Youssef Ashraf',
    'Nour Taha',
    'Sara Magdy',
  ];

  final images8 = [
    'asset/employee1.jpg',
    'asset/employee2.jpg',
    'asset/employee3.jpg',
    'asset/employee4.jpg',
    'asset/emp5.jpg',
    'asset/emp6.jpg',
    'asset/employee1.jpg',
    'asset/employee2.jpg',
    'asset/employee3.jpg',
    'asset/employee4.jpg',
    'asset/emp5.jpg',
    'asset/emp6.jpg',
    'asset/employee1.jpg',
    'asset/employee2.jpg',
    'asset/employee3.jpg',
    'asset/employee4.jpg',
    'asset/emp5.jpg',
    'asset/emp6.jpg',
  ];

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: dark,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: color1,
                      ),
                      child: TextFormField(
                        style: TextStyle(color: color2),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search',
                          focusedBorder: InputBorder.none,
                          fillColor: color2,
                          hoverColor: color2,
                          hintStyle: TextStyle(
                              color: color2, fontSize: 18, height: 0.75),
                          prefixIcon: Icon(
                            Icons.search,
                            color: color2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.home,
                            color: dark,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5, left: 20),
              child: Text(
                'Employees',
                style: TextStyle(
                    fontSize: 25, color: color2, fontWeight: FontWeight.w500),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEmployee()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: color1,
                  ),
                  child: ListTile(
                    //                                    Add Employee
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    leading: Container(
                      child: CircleAvatar(
                        backgroundColor: color2,
                        radius: 30,
                        child: Icon(
                          Icons.add,
                          size: 35,
                          color: Color(0xff060822),
                        ),
                      ),
                    ),
                    title: Text(
                      'Add Employee',
                      style: TextStyle(
                          color: color2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'jop title',
                      style: TextStyle(color: Colors.grey[200], fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),

            //                                                             listview
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10),
                child: ListView.separated(
                    itemCount: 20,
                    separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                          height: 0.1,
                          color: color2,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DraggableWidget())); // go to emp_profile
                          },
                          child: getSlidableItem(index, context));
                    }),
              ),
            ),
            // FloatingActionButton(
            //   onPressed: () {},
            //   backgroundColor: Colors.white,
            //   child: Icon(
            //     Icons.add,
            //     size: 35,
            //     color: Color(0xff060822),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }

  Widget getSlidableItem(
    int index,
    BuildContext context,
  ) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          onTap: () {
            print('Edit Employe $index');
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEmployees(),
                ));
          },
          caption: 'Performance',
          color: color2,
          iconWidget: Icon(
            Icons.settings,
            size: 30,
          ),
          foregroundColor: dark,
        ),
        IconSlideAction(
          onTap: () {
            print('Delete Employe $index');
          },
          caption: 'Dismissal',
          color: Color(0xffff5151),
          foregroundColor: color2,
          iconWidget: Icon(
            Icons.person_remove_alt_1_sharp,
            size: 30,
            color: Colors.white,
          ),
        ),
      ],
      child: Container(
        width: double.infinity,
        height: 90,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('asset/employee1.jpg'),
          ),
          title: Text(
            'Mazen Mohammed',
            style: TextStyle(
                color: color2, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            ' mobile developer ',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 12,
              backgroundColor: color1,
            ),
          ),
        ),
      ),
    );
  }

  // String getName() {
  //   if (i > 0) {
  //     setState(() {
  //       i++;
  //       if (i > 6) i = 0;
  //     });
  //   }
  //   return names[i] == null ? 'employee' : names[i];
  // }
}
