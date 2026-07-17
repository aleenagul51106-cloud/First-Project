import 'package:first_project/signin_screen.dart';
import 'package:flutter/material.dart';

import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, String>> studentList = [
    {
      "studentName": "Aleena",
      "qualification": "Developer",
    },
    {
      "studentName": "Ali",
      "qualification": "Designer",
    },
    {
      "studentName": "Ahmad",
      "qualification": "Medical Student",
    },
    {
      "studentName": "Ayesha",
      "qualification": "Software Engineer",
    },
    {
      "studentName": "Fatima",
      "qualification": "Graphic Designer",
    },
    {
      "studentName": "Hassan",
      "qualification": "Civil Engineer",
    },
    {
      "studentName": "Usman",
      "qualification": "Data Analyst",
    },
    {
      "studentName": "Afnan",
      "qualification": "Flutter Developer",
    },
    {
      "studentName": "Sara",
      "qualification": "Teacher",
    },
    {
      "studentName": "Hina",
      "qualification": "Doctor",
    },
    {
      "studentName": "Bilal",
      "qualification": "Mechanical Engineer",
    },
    {
      "studentName": "Areeba",
      "qualification": "UI/UX Designer",
    },
    {
      "studentName": "Hamza",
      "qualification": "Web Developer",
    },
    {
      "studentName": "Noor",
      "qualification": "Nurse",
    },
    {
      "studentName": "Ibrahim",
      "qualification": "Cyber Security Expert",
    },
    {
      "studentName": "Maham",
      "qualification": "Pharmacist",
    },
    {
      "studentName": "Saad",
      "qualification": "Accountant",
    },
    {
      "studentName": "Maryam",
      "qualification": "Dentist",
    },
    {
      "studentName": "Talha",
      "qualification": "AI Engineer",
    },
    {
      "studentName": "Laiba",
      "qualification": "Business Analyst",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,



        appBar: AppBar(backgroundColor: Colors.white,


        bottom: TabBar(tabs: [
          Tab(text: "Home Screen",),
          Tab(text: "Setting Screen",),

        ]),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/image.jpg"),
                      radius: 30,

                      // child: Icon(Icons.person),
                    ),

                    Text(
                      "Aleena",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("Developer"),
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),

              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),

              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                onTap: () {},
              ),

              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout", style: TextStyle(color: Colors.red)),
                trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.red),
                onTap: () {
                  ShowDialogWidget();
                },
              ),
            ],
          ),
        ),

        body: TabBarView(children: [

          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            ///forming lists of students
            children: [
              Expanded(child: ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index){
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person)),
                        title: Text("${studentList[index]["studentName"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text("${studentList[index]["qualification"]}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black38,size: 16,),
                      ),
                    );
                  }
              ),
              ),



              // // Container(
              // //   height: 200,
              // //   // color: Colors.grey,
              // //   child: Stack(
              // //     children: [
              // //
              // //       ///yellow container
              // //       Container(
              // //         height: 100,
              // //         width: double.infinity,
              // //         decoration: BoxDecoration(
              // //           color: Colors.yellow,
              // //           borderRadius: BorderRadius.circular(25),
              // //         ),
              // //         child: Text("YELLOW CONTAINER", style: TextStyle(fontSize: 30)),
              // //       ),
              // //
              // //
              // //       ///red container
              // //       Positioned(
              // //         top: 50,
              // //         left: 10,
              // //         right: 10,
              // //         child: Container(
              // //           height: 100,
              // //           width: double.infinity,
              // //           decoration: BoxDecoration(
              // //             color: Colors.red,
              // //             borderRadius: BorderRadius.circular(25),
              // //           ),
              // //           child: Text("RED CONTAINER", style: TextStyle(fontSize: 30)),
              // //         ),
              // //       ),
              // //
              // //     ],
              // //   ),
              // // ),
              // //
              // //
              //
              //
              // Spacer(),
              //



              ///show dialog button

              InkWell(
                onTap: () {
                  ShowDialogWidget(); //code is present below
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Show Dialog",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 390,
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 23),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text("Aleena"),
                              subtitle: Text("Flutter Developer"),
                              trailing: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                            Text("This is Bottom Sheet"),
                            SizedBox(height: 23),
                            Text("This is Bottom Sheet"),
                            SizedBox(height: 23),
                            Text("This is Bottom Sheet"),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Bottom Sheet",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          MenuScreen(),

        ]),




        
      ),
    );
  }

  ShowDialogWidget() {
    //code of above widget to prevent mixing above
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert Dialog"),
          content: Text("This is alert dialog..!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SignInScreen(),
                //   ),
                // );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
