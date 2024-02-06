import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/newTasks/reusable.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

class Done_Tasks extends StatefulWidget {
  const Done_Tasks({Key? key}) : super(key: key);

  @override
  State<Done_Tasks> createState() => _Done_TasksState();
}

class _Done_TasksState extends State<Done_Tasks> {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var tasks =AppCubit.get(context).doneTasks ;
        return taskBuilder(tasks: tasks);
      },


    );
  }
}
