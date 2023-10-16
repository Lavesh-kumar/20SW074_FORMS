import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



void main(){

runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Form Debugging Test',
      home: DebugFormScreen(),
    );
  }
}

class DebugFormScreen extends StatefulWidget {
  const DebugFormScreen({Key? key});

  @override
  DebugFormScreenState createState() => DebugFormScreenState();
}

class DebugFormScreenState extends State<DebugFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  
     DateTime? dob; // Add date of birth field
File? selectedImage;








  void submitForm() {

    print(dob);
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Form submitted: Username - $username, Password - $password,Date-of-Birth  -$dob',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Form Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),





const SizedBox(height: 20),
              // Date of Birth Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  return null;
                },
                onTap: () {
                  // Show date picker when the field is tapped
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        dob = selectedDate;
                      });
                    }
                  });
                },
                readOnly: true, // Make the field read-only
                controller: TextEditingController(
                  text: dob != null ? "${dob!.toLocal()}".split(' ')[0] : '',
                  
                ),
              ),




















              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
