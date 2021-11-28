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
      margin: const EdgeInsets.all(40.0),
      child: Form(
        key: planTripFormKey,
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Plan Your Trip",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                buildCountryField(),
                const SizedBox(height: 10),
                buildCityField(),
                const SizedBox(height: 10),
                buildLanguageField(),
                const SizedBox(height: 30),
                buildSelectDateField(),
                const SizedBox(height: 50),
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
      onChanged: (value) => setState(() => country = value),
      hint: const Text("Select Country"),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
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
      onChanged: (value) => setState(() => city = value),
      hint: const Text("Select City"),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
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
      onChanged: (value) => setState(() => language = value),
      hint: const Text("Select Language"),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
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

    return SizedBox(
      width: double.infinity,
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
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: const Text("GO"),
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
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF7AAC5D))),
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
        style: const TextStyle(
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
