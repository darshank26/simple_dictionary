import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:34.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Dictionary",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merriweather(textStyle: TextStyle(fontSize: 38,color: Colors.black,fontWeight: FontWeight.bold,))

                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.grey[500],),
                  filled: true,
                  fillColor: Colors.grey[200], // Grey background color
                  hintText: 'Search here..', // Placeholder text
                  hintStyle: TextStyle(color: Colors.grey[500]), // Grey hint text color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No border
                  ),
                ),
                style: TextStyle(color: Colors.white), // White text color
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18.0,top: 12.0,bottom: 12.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Button background color
                  elevation: 2.0, // Add shadow to create a glossy effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
              ),
              onPressed: () {

              },
                    child:Text(
                        "Search",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSerif(textStyle: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 0.4))

                    ),
          ),
                ),
        ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0,top: 20.0),
              child: Row(
                children: [
                  Text(
                      "Recent",
                      style: GoogleFonts.merriweather(textStyle: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,))

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Lottie.asset('assets/empty.json',width: 300.0,height: 350.0)),
            ),


          ],
        ),
      ),
    );
  }
}
