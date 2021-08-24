import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

class WidgetTask extends StatelessWidget {
  final Map model;

  //const WidgetTask(tak, {Key? key, required this.model}) : super(key: key);
  WidgetTask({required this.model});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        AppCubit.get(context).delete(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(children: [
              Text('${model['title']}',style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0
              ),)
            ],),
          ),
          SizedBox(width: 20.0,),
          IconButton(onPressed: (){

            AppCubit.get(context).updateStatues(status: 'done', id: model['id']);
          }, icon: Icon(Icons.check_box),color: Colors.green,),
          IconButton(onPressed: (){

            AppCubit.get(context).updateStatues(status: 'archived', id: model['id']);


          }, icon: Icon(Icons.archive),color: Colors.black45,)

        ],),
      ),
    );
  }
}
