import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidemo/controller/universityprovider.dart';

import 'package:uidemo/screens/widgets/universitylist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => UniversityProvider(),
        child: const UniversityList(),
      ),
    );
  }
}
