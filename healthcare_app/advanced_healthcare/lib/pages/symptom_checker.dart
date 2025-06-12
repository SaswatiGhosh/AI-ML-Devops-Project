import 'package:flutter/material.dart';


class SymptomCheckerPage extends StatelessWidget {
  const SymptomCheckerPage({super.key});
  @override
  Widget build(BuildContext context) => 
  Scaffold(
    appBar: AppBar(title: Text("Symptom Checker")), 
    // body: RadioMenuButton(value: value, groupValue: groupValue, onChanged: onChanged, child: child)
    body: Center(child: Text("Sympton Checker"))
    );
}



