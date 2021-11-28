import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guidance/src/models/trip.dart';
import 'package:guidance/src/screens/empty.dart';
import 'package:intl/intl.dart';

class TripPlan extends StatefulWidget {
  const TripPlan({Key? key}) : super(key: key);
  @override
  State<TripPlan> createState() => _TripPlanState();
}

class _TripPlanState extends State<TripPlan> {
  var planTripFormKey = GlobalKey<FormState>();
  String? country;
  String? city;
  String? language;
  DateTime? tripDateTime;
  String tripTimeStr = DateFormat("dd/MM/yyyy").format(DateTime.now());

  //List<String?> val = [language];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text("Plan Your Trip"),
        ),*/
        body: Container(
      margin: EdgeInsets.all(40.0),
      child: Form(
        key: planTripFormKey,
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Plan Your Trip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 30), 
                buildCountryField(),
                SizedBox(height: 10),
                buildCityField(),
                SizedBox(height: 10),
                buildLanguageField(),
                SizedBox(height: 50),
                buildSelectDateField(),
                SizedBox(height: 50),
                buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildCountryField() {
    final countries = [
      "Turkey",
    ];
    //print(country);
    return DropdownButtonFormField<String>(
      value: country,
      items: countries.map(buildMenuItem).toList(),
      onChanged: (value) => setState(() => this.country = value),
      hint: Text("Select Country"),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 32,
    );
  }

  Widget buildCityField() {
    final cities = [
      "Istanbul",
    ];
    //print(city);
    return DropdownButtonFormField<String>(
      value: city,
      items: cities.map(buildMenuItem).toList(),
      onChanged: (value) => setState(() => this.city = value),
      hint: Text("Select City"),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 32,
    );
  }

  Widget buildLanguageField() {
    final languages = [
      "English",
    ];
    //print(language);
    return DropdownButtonFormField<String>(
      value: language,
      items: languages.map(buildMenuItem).toList(),
      onChanged: (value) => setState(() => this.language = value),
      hint: Text("Select Language"),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 32,
    );
  }

  Widget buildSelectDateField() {
    String getText() {
      if (tripDateTime == null) {
        return "Select Trip Date";
      } else {
        return DateFormat("dd/MM/yyyy").format(tripDateTime!);
      }
    }

    return Container(
      width: 200,
      height: 50,
      child: ElevatedButton(
        child: Text(getText()),
        onPressed: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: tripDateTime ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2022),
            helpText: "Select Trip Date",
            fieldLabelText: 'Trip date',
            fieldHintText: 'Month/Day/Year',
          );
          if (date == null) return;

          setState(() {
            tripDateTime = date;
            //tripTimeStr = DateFormat("dd/MM/yyyy").format(tripDateTime!);
          });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF7AAC5D))),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        child: Text("GO"),
        onPressed: () {
          if (planTripFormKey.currentState!.validate() &&
              tripDateTime != null) {
            planTripFormKey.currentState!.save();

            Trip tripPlan = Trip(country!, city!, language!, tripDateTime!);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Empty(tripPlan)));

            //Navigator.pop(context);
          } else if (tripDateTime == null) {
            showAlert(context, "Empty Field!", "Please select a date");
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all(const Color(0xFF7AAC5D)),
        ),
      ),
    );
  }

  Widget createDropDownButton(String? item, List<String> items, String name) {
    return DropdownButton<String>(
      value: item,
      items: items.map(buildMenuItem).toList(),
      onChanged: (value) => setState(() => item = value),
      hint: Text("Select " + name),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String e) {
    return DropdownMenuItem(
      value: e,
      child: Text(
        e,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }

  void showAlert(BuildContext context, String title, String message) {
    var alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
