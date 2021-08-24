
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Modules/archived_screen.dart';
import 'package:todo/Modules/new_task_screen.dart';
import 'package:todo/Modules/done_screen.dart';
import 'package:todo/shared/constant.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';
// @dart=2.9
class Home extends StatelessWidget {



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  //List<Map>tasks=[];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){
          if (state is AppInsertDataBaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,AppStates state){
          AppCubit cubit=AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // var name= await getName();
                // print(name);
                //insertToDatabase();
                if (cubit.isBottomSheet) {
                  if (formKey.currentState!.validate()) {
                    print("3333333");
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    // await insertToDatabase(
                    //     title: titleController.text,
                    //     date: dateController.text,
                    //     time: timeController.text)
                    //     .then((value) {
                    //   Navigator.pop(context);
                    //
                    //   getDataFromDatabase(database).then((value) {
                    //     // setState(() {
                    //     //   isBottomSheet = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasks=value;
                    //     //
                    //     //
                    //     // });
                    //     print(tasks);
                    //     // setState(() {
                    //     //
                    //     // });
                    //   });
                    //
                    //
                    //
                    //
                    //
                    // }).catchError((error) {
                    //   print("error${error.toString()}");
                    // });
                  }
                } else {
                  scaffoldKey.currentState!.showBottomSheet((context) => Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'title must not be empty';
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              focusColor: Colors.grey,
                              hintText: 'title',
                              labelText: 'title',
                            ),
                          ),
                          TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'date must not be empty';
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              focusColor: Colors.grey,
                              hintText: 'Date',
                              labelText: 'Date',
                            ),
                            onTap: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2021-09-17'))
                                  .then((value) {

                                dateController.text=DateFormat.yMMMd().format(value!);
                              });
                            },
                          ),
                          TextFormField(
                            controller: timeController,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'time must not be empty';
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              focusColor: Colors.grey,
                              hintText: 'Time',
                              labelText: 'Time',
                            ),
                            onTap: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                                  .then((value) {
                                if(value!=null){
                                  timeController.text = value.format(context);

                                }
                                else{
                                  print("error");
                                }
                                //     print(value!.format(context));
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  )).closed.then((value) {
                    cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                   // isBottomSheet = false;
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                  // setState(() {
                  //   isBottomSheet = true;
                  //
                  //   fabIcon = Icons.add;
                  // });

                }
              },
              child: Icon(cubit.fabIcon),
            ),
            body: //cubit.screens[cubit.currentIndex],
           state is !AppGetLoadingBaseState?cubit.screens[cubit.currentIndex]:Center(child: CircularProgressIndicator(),),


            // ConditionalBuilder(builder:(context) =>screens[currentIndex],condition: tasks.length>0,fallback: (context)=>Center(child: CircularProgressIndicator(),),),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
              ],
              onTap: (index) {
                cubit.changeIndex(index);
                // setState(() {
                //   currentIndex = index;
                // });
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }

  // run in backGround thread
  Future<String> getName() async {
    return 'Ahmed Ali';
  }


}


