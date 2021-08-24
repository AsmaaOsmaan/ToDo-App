import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/build_empty_list.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';


class TaskScreen extends StatelessWidget {
  TaskScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
     builder: (context,state){
       var tasks=AppCubit.get(context).newTasks;

       return  tasksBuilder(tasks: tasks,);
     },

    );
  }
}

