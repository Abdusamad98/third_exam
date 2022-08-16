import 'package:flutter/material.dart';
import 'package:third_exam/presentation/router.dart';
import 'package:third_exam/presentation/tabs/tab_box/tab_box.dart';
import 'package:third_exam/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabBox(),
      initialRoute: tabsRoute,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}

//flutter packages pub run build_runner build --delete-conflicting-outputs
