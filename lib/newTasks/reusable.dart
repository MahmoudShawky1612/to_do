import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_do/shared/cubit/cubit.dart';

Widget defaultFormFiel({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword=false,
  Function(String)? onSubmit,
  Function(String)? onChange,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isClickable=true,
  Function()? onTap,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  enabled: isClickable,
  validator: (value) => validate(value),
  decoration:  InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    border: OutlineInputBorder(),
  ),
  onTap: onTap,

);


Widget buildTaskItem (Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).statusDelete(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            "${model['date']}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize:19,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column  (
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model['title']}",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              Text(
                "${model['time']}",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15,),
        IconButton(
          icon: Icon(
              Icons.check_circle,
              color: Colors.red,
          ),
          onPressed: ()
        {
          AppCubit.get(context).statusUpdate(status: 'done', id: model['id'],);
        },
        ),
        IconButton(
          icon: Icon(
            Icons.archive_rounded,
            color: Colors.blue[500],

          ), onPressed: ()
        {
          AppCubit.get(context).statusUpdate(status: 'archive', id: model['id'],);
        },
        ),
      ],
    ),
  ),
);

Widget taskBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition:tasks.length>0 ,
  builder: (context)=>
      ListView.separated(
        itemBuilder: (context,index) => buildTaskItem(tasks[index],context  ),
        separatorBuilder: (context,index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20,
          ),
          child: Container(
            height: 2,
            color: Colors.white,
            width: double.infinity,
          ),
        ),
        itemCount:tasks.length,
      ),
  fallback: (BuildContext context) =>
      Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.brown,
            ),
            Text("Add Some Tasks To Be Shown Here !",
              style: TextStyle(color: Colors.white,fontSize: 15,),

            ),

          ],
        ),
      ),
);