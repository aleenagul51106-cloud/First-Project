import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      backgroundColor: Colors.white,
      appBar: AppBar(


        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back_outlined, color: Colors.white),
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 8),
                Icon(Icons.menu, color: Colors.white),
              ],
            ),
          ),
        ],
      ),




      body: Padding(
        padding: const EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,

              backgroundImage: AssetImage("assets/images/icon.png"),
            ),


            // Image.asset("assets/images/vector art icon.png",height: 50,),
            SizedBox(height: 10),



            Text(
              "Aleena",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            Text(
              "Flutter Developer",
              style: TextStyle(fontSize: 16, color: Colors.black45),
            ),

            SizedBox(height: 10),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "120",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Project",
                        style: TextStyle(fontSize: 18, color: Colors.black45),
                      ),
                    ],
                  ),

                  Container(height: 50, width: 0.5, color: Colors.grey),
                  Column(
                    children: [
                      Text(
                        "850",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(fontSize: 18, color: Colors.black45),
                      ),
                    ],
                  ),

                  Container(height: 50, width: 0.5, color: Colors.grey),
                  Column(
                    children: [
                      Text(
                        "230",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(fontSize: 18, color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Card(
              elevation: 5,

              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.person, size: 35),
                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Me",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "I am a passionate Flutter developer.\n I love building beautiful and functional \nmobile apps.",
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            Card(
              color: Colors.white,
              elevation: 10,
              margin: const EdgeInsetsGeometry.all(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.call, size: 28),
                        SizedBox(width: 10),

                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.email, size: 20),
                        SizedBox(width: 10),

                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "aleena@gmail.com",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.call, size: 20),
                        SizedBox(width: 10),

                        Text(
                          "Phone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "03331234567",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                    ),

                    Row(
                      children: [
                        Icon(Icons.location_on, size: 20),
                        SizedBox(width: 10),

                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Kohat, Pakistan",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            Card(
              elevation: 5,

              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 25,
                          color: (Colors.blueAccent.shade700),
                        ),
                        Text(
                          "Skills",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 12,
                            ),
                            child: Text(
                              "Flutter",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            child: Text(
                              "Dart",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            child: Text(
                              "Firebase",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            child: Text(
                              "SQLite",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
