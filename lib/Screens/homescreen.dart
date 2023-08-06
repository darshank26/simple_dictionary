import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_dictionary/Screens/meaningscreen.dart';
import 'package:simple_dictionary/model/model.dart';
import 'package:simple_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  TextEditingController _wordController = TextEditingController();
  DictionaryModel data = DictionaryModel();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:34.0),
        child: SingleChildScrollView(
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
                  controller: _wordController,
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
                  style: GoogleFonts.ptSerif(textStyle: TextStyle(fontSize: 18,color: ksecondcolor,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
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
                onPressed: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MeaningScreen()));

                      },
                      child:Text(
                          "Search..",
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

              // Center(
              //   child: ( data.word.toString() == '')
              //       ? Text('Enter a word and press "Get Definition"')
              //       : Text(data.meanings![0].definitions![0].definition.toString()),
              // ),


            ],
          ),
        ),
      ),
    );
  }



  Future<void> fetchData() async {
    String word = _wordController.text;

    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );

    if (response.statusCode == 200) {
      setState(() {

        List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          setState(() {
            data = DictionaryModel.fromJson(responseData[0]);

          });
        }
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
  }
}
