import 'dart:convert';
import 'package:covid_19/data/slots.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //-------------------------------------------------------------------
  TextEditingController pincontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  //--------------------------------------------------------------------

  DateTime? datetime;
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  List slots = [];
  //--------------------------------------------------------------------

  void getslots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
                pincontroller.text +
                '&date=' +
                datecontroller.text))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
      });
      if (slots.isEmpty) {
        return CircularProgressIndicator();
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Slot(
                      slots: slots,
                    )));
      }
    });
  }

  //meathd----------------------------------------------------------https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=110001&date=31-03-2021

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text('Covid 19'),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height: 250,
                  child: Image.asset(
                    'images/01.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      maxLength: 7,
                      controller: pincontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Pin Code",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019),
                                lastDate: DateTime(2022))
                            .then((selectdate) {
                          if (selectdate != null) {
                            datecontroller.text = dateFormat.format(selectdate);
                          }
                        });
                      },
                      keyboardType: TextInputType.datetime,
                      controller: datecontroller,
                      decoration: InputDecoration(
                        hintText: 'Enter Date Time',
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54),
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Get Data',
                          style: TextStyle(color: Colors.white54),
                        )),
                  ),
                  onTap: () {
                    getslots();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
