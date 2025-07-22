import 'package:basic_flutter/projectlogin.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  String selectedUnit = 'Kilograms';
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightFeetController = TextEditingController();
  final TextEditingController heightInchesController = TextEditingController();

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectLogin()),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, double bmi, String bmiCategory,
      String weightMessage) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 250,
          color: Colors.green[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Result',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    'BMI: ${bmi.toStringAsFixed(2)} ($bmiCategory)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    weightMessage,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BMIChartScreen()),
                      );
                    },
                    child: Text(
                      'BMI CHART',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _calculateBMI(BuildContext context) {
    if (weightController.text.isEmpty ||
        heightFeetController.text.isEmpty ||
        heightInchesController.text.isEmpty) {
      _showAlertDialog('Please fill in all fields');
      return;
    }

    double weight = double.tryParse(weightController.text) ?? 0.0;
    double heightFeet = double.tryParse(heightFeetController.text) ?? 0.0;
    double heightInches = double.tryParse(heightInchesController.text) ?? 0.0;
    double height = heightFeet * 12 + heightInches;
    double bmi;

    if (selectedUnit == 'Kilograms') {
      height *= 2.54; // Convert height to cm
      height /= 100; // Convert height to meters
      bmi = weight / pow(height, 2);
    } else {
      bmi = (weight / pow(height, 2)) * 703;
    }

    String bmiCategory;
    if (bmi < 18.5) {
      bmiCategory = 'Underweight';
    } else if (bmi < 24.9) {
      bmiCategory = 'Normal weight';
    } else if (bmi < 29.9) {
      bmiCategory = 'Overweight';
    } else {
      bmiCategory = 'Obesity';
    }

    // Calculate the weight range for normal BMI
    double minNormalWeight, maxNormalWeight;
    if (selectedUnit == 'Kilograms') {
      minNormalWeight = 18.5 * pow(height, 2);
      maxNormalWeight = 24.9 * pow(height, 2);
    } else {
      minNormalWeight = (18.5 * pow(height, 2)) / 703;
      maxNormalWeight = (24.9 * pow(height, 2)) / 703;
    }

    String weightMessage;
    if (weight < minNormalWeight) {
      double weightToGain = minNormalWeight - weight;
      weightMessage =
          'You need to gain ${weightToGain.toStringAsFixed(2)} ${selectedUnit.toLowerCase()} to reach a normal weight.';
    } else if (weight > maxNormalWeight) {
      double weightToLose = weight - maxNormalWeight;
      weightMessage =
          'You need to lose ${weightToLose.toStringAsFixed(2)} ${selectedUnit.toLowerCase()} to reach a normal weight.';
    } else {
      weightMessage = 'You are within the normal weight range.';
    }

    _showBottomSheet(context, bmi, bmiCategory, weightMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.blue[300],
        title: Center(
          child: Text(
            "BMI CALCULATOR",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green[200],
          ),
          height: 400,
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: selectedUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUnit = newValue!;
                      });
                    },
                    items: <String>['Kilograms', 'Pounds']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: "Units (weight)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  child: TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: "Weight",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  child: TextField(
                    controller: heightFeetController,
                    decoration: InputDecoration(
                      labelText: "Height (feet)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  child: TextField(
                    controller: heightInchesController,
                    decoration: InputDecoration(
                      labelText: "Height (inches)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    _calculateBMI(context);
                  },
                  child: Text("Submit"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                  child: Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BMIChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Chart'),
      ),
      body: Center(
        child: Image.asset('assets/images/bmi_chart.png'),
      ),
    );
  }
}
