import 'package:flutter/material.dart';
import 'package:universal_form_validation/universal_form_validation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (v) => BasicValidators.email(v),
                decoration: InputDecoration(labelText: 'Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    print('Valid!');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
