import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guidance/src/screens/empty.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Form(
        key: planTripFormKey,
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 7.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Plan Your Trip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 4.h,
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 10),
              buildCountryField(),
              SizedBox(height: 5.h),
              buildCityField(),
              SizedBox(height: 5.h),
              buildLanguageField(),
              SizedBox(height: 5.h),
              buildSelectDateField(),
              SizedBox(height: 5.h),
              buildSubmitButton(),
            ],
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
      hint: const Text(
        "Country",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.02.h),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 3.5.h,
      //style: Colors.color,
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
      hint: const Text(
        "City",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.02.h),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 3.5.h,
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
      hint: const Text(
        "Language",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      validator: (value) => value == null ? 'Field Required' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.02.h),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 3.5.h,
    );
  }

  Widget buildSelectDateField() {
    String getDateText() {
      if (tripDateTime == null) {
        return "Select Date";
      } else {
        return DateFormat("dd/MM/yyyy").format(tripDateTime!);
      }
    }

    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: OutlinedButton(
        child: Text(
          getDateText(),
          style: TextStyle(fontSize: 2.2.h),
        ),
        onPressed: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: tripDateTime ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month + 3,
                DateTime.now().day),
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
      height: 7.h,
      child: ElevatedButton(
        child: Text(
          "GO",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 4.h),
        ),
        onPressed: () {
          if (planTripFormKey.currentState!.validate() &&
              tripDateTime != null) {
            planTripFormKey.currentState!.save();
            // * We won't go to any screen anymore here
            // * Therefore, please add the necessary screen here
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

// failed for now
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
          fontSize: 3.h,
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
