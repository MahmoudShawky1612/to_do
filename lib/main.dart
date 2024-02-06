import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do/newTasks/bloc_observer.dart';

import 'homelayout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home_Layout(),
      debugShowCheckedModeBanner: false,


    );
  }
}

