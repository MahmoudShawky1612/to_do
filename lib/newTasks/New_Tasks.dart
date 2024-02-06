import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/newTasks/constants.dart.dart';
import 'package:to_do/newTasks/reusable.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

class New_Tasks extends StatefulWidget {
  const New_Tasks({Key? key}) : super(key: key);

  @override
  State<New_Tasks> createState() => _New_TasksState();
}

class _New_TasksState extends State<New_Tasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var tasks =AppCubit.get(context).newTasks ;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}