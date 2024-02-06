import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:to_do/newTasks/New_Tasks.dart';
import 'package:to_do/newTasks/reusable.dart';
import 'package:to_do/newTasks/constants.dart.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';



import 'archived/Archive.dart';
import 'doneTasks/Done_Tasks.dart';

class Home_Layout extends StatelessWidget
{



  late Database database;
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..creatDatabasee(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(BuildContext context,AppStates state){
          if(state is AppInsertDatabase)
            {
              Navigator.pop(context);
            }
        } ,
        builder:(BuildContext context,AppStates state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
              key:scaffoldKey,
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                title: Center(child: Text(cubit.titles[cubit.currentIndex],style: TextStyle(color: Colors.white,fontSize: 30,fontWeight:FontWeight.bold),)),
                backgroundColor: Colors.brown,
                elevation: 05,
              ),
              body: ConditionalBuilder(
                condition:state is! AppGetDatabaseLoadingState ,
                builder: (context)=>cubit.screens[cubit.currentIndex],
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if(cubit.isBottomSheetShown)
                  {
                    if(formKey.currentState!.validate())
                    {
                      cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);

                    }
                  }
                  else
                  {
                    scaffoldKey.currentState?.showBottomSheet((context)=>
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormFiel(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (String value) {
                                    if(value.isEmpty)
                                    {
                                      return "title must not be empty";
                                    };
                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),

                                SizedBox(height: 20),

                                defaultFormFiel(
                                  controller: timeController,
                                  type: TextInputType.datetime,

                                  onTap: (){
                                    showTimePicker(context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text=value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  validate: (String value) {
                                    if(value.isEmpty)
                                    {
                                      return "time must not be empty";
                                    };
                                    return null;
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),

                                SizedBox(height: 20),

                                defaultFormFiel(
                                  controller: dateController,
                                  type: TextInputType.datetime,

                                  onTap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2024-03-04"),
                                    ).then((value)
                                    {
                                      print(DateFormat.yMMMd().format(value!));
                                      dateController.text=DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validate: (String value) {
                                    if(value.isEmpty)
                                    {
                                      return "date must not be empty";
                                    };
                                    return null;
                                  },
                                  label: 'Date Time',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),

                    ).closed.then((value) {
                      cubit.changeBottomSheetState(isShow: false, icon:Icons.edit);
                    });
                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }

                },
                child: Icon(cubit.fabIcon),
                backgroundColor: Colors.brown,
              ),

            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.brown,
                elevation: 0,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task,color: Colors.white,),
                    label: 'Tasks',



                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done,color: Colors.red,),
                    label: 'Done',

                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined,color: Colors.blue[500],),
                      label: 'Archived'

                  ),
                ],
              ),
                ),
          );

        } ,
      ),
    );
  }


}
