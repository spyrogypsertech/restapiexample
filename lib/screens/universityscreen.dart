import 'package:flutter/material.dart';
import 'package:uidemo/screens/widgets/universitylist.dart';

class UniversitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: UniversityList(),
    );
  }
}
