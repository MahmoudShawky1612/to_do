import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/newTasks/reusable.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var tasks =AppCubit.get(context).archivedTasks ;
        return taskBuilder(tasks: tasks);
      },


    );
  }
}
