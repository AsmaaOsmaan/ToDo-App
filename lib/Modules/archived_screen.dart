// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// class ArchivedScreen extends StatelessWidget {
//   var f = NumberFormat("###,###.000#", "en_US");
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GestureDetector(
//           onTap: (){
//             print("######");
//             print(f.format(double.parse("1000300.5588")));
//           },
//           child: Text('Archived')),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/build_empty_list.dart';
import 'package:todo/shared/constant.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';
import 'package:todo/shared/widget_task.dart';
import 'package:intl/intl.dart';

class ArchivedScreen extends StatelessWidget {
  //final List<Map>tasks;
  ArchivedScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks=AppCubit.get(context).archivedTasks;

        return  tasksBuilder(tasks: tasks,);
      },

    );
  }
}

