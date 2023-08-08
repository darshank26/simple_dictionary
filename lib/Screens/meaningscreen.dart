import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;


class MeaningScreen extends StatefulWidget {

   final String wordd;


  const MeaningScreen({Key? key,required this.wordd}) : super(key: key);


  @override
  State<MeaningScreen> createState() => _MeaningScreenState();

}

class _MeaningScreenState extends State<MeaningScreen> {


  DictionaryModel data = DictionaryModel();


  @override
  void initState() {
    super.initState();
    fetchData();
  }



  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left:24.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.blue[800],size: 30,),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            title: Text("Search",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:10.0,left: 34.0,right: 10.0),
                  child: Text(
                      data.word.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merriweather(textStyle: TextStyle(fontSize: 42,color: Colors.black,fontWeight: FontWeight.w600,))

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:34.0),
                  child: Row(
                    children: [
                      Text( data.phonetics![1].text.toString(),
                        style: TextStyle(fontSize: 18,color: ktextcolor,fontWeight: FontWeight.w600,letterSpacing: 0.4, fontFamily: 'CustomPhoneticFont'), // White text color
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.volume_up, color: Colors.blue[800],size: 25,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:34.0,top: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RowWithBorders(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:24.0,left: 34.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "DEFINATIONS",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700,letterSpacing: 0.7))

                          ),
                          SizedBox(height: 10,),
                          Text("used as a greeting or to begin a phone conversation.",
                            style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 16,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:24.0,left: 34.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "EXAMPLE",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700,letterSpacing: 0.7))

                          ),
                          SizedBox(height: 10,),
                          Text("1. hello there, Katie!",
                            style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 16,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: DataTable(
                    border: TableBorder.all( color: kprimarycolor,borderRadius: BorderRadius.all(Radius.circular(8))),
                    columns: const [
                      DataColumn(label: Text('SYNONYMS',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,letterSpacing: 0.6),
                      )
                      ),
                      DataColumn(label:  Text('ANTONYMS',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,letterSpacing: 0.6),
                      )),
                    ],
                    rows: const [
                      DataRow(cells: [ DataCell(Text('Row 1',style: TextStyle(fontSize: 16),)), DataCell(Text('Row 1',style: TextStyle(fontSize: 16))),]),
                      DataRow(cells: [ DataCell(Text('Row 2',style: TextStyle(fontSize: 16))), DataCell(Text('Row 2',style: TextStyle(fontSize: 16))),]),
                      DataRow(cells: [ DataCell(Text('Row 3',style: TextStyle(fontSize: 16))), DataCell(Text('Row 3',style: TextStyle(fontSize: 16))),]),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:24.0,left: 34.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "ORIGIN",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700,letterSpacing: 0.7))

                          ),
                          SizedBox(height: 10,),
                          Text("early 19th century: variant of earlier hollo ; related to holla",
                            style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 16,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
                          ),
                        ],
                      ),
                    ),

                  ],
                ),



              ],
            ),
          ),
        );


  }

  Future<void> fetchData() async {
    String? word = widget.wordd;
    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        setState(() {
          data = DictionaryModel.fromJson(responseData[0]);
        });
      }
    } else {
      // If that call was not successful, handle the error accordingly.
      print('Failed to load data');
    }
  }
}

class RowWithBorders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)), // Rounded corners
            border: Border.all(
              color: Colors.blueAccent, // Inner inner border color
              width: 1.0, // Inner inner border width
            ),
          ),
          child: Text('Text 1',
            style: GoogleFonts.ptSerif(textStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
    ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent, // Inner inner border color
              width: 1.0, // Inner inner border width
            ),
          ),
          child:  Text('Text 2',
            style: GoogleFonts.ptSerif(textStyle: TextStyle(fontSize: 14,color: ktextcolor,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)), // Rounded corners
            border: Border.all(
              color: Colors.blueAccent, // Inner inner border color
              width: 1.0, // Inner inner border width
            ),
          ),
          child: Text('Text 3',
            style: GoogleFonts.ptSerif(textStyle: TextStyle(fontSize: 14,color: ktextcolor,fontWeight: FontWeight.w600,letterSpacing: 0.4)), // White text color
          ),
        ),
      ],
    );
  }
}


