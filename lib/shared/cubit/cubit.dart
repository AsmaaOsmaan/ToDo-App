
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Modules/archived_screen.dart';
import 'package:todo/Modules/new_task_screen.dart';
import 'package:todo/Modules/done_screen.dart';
import 'package:todo/shared/cubit/states.dart';


class AppCubit extends Cubit<AppStates>{
  int currentIndex = 0;
  late Database database;
  List<Map>newTasks=[];
  List<Map>tasks=[];
  List<Map>archivedTasks=[];
  List<Map>doneTasks=[];
  List<Widget> screens = [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List<String> titles = [
    'TasksScreen',
    'DoneScreen',
    'ArchivedScreen',
  ];
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  void changeIndex(int index){
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }
  void createDatabase()  {
     openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('database created');
          database
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,data TEXT,time TEXT,statues TEXT)')
              .then((val) {
            print('table created');
          }).catchError((error) {
            print(error.toString());
          });
        }, onOpen: (database) {
        getDataFromDatabase(database);
     print('database opened');
        }).then((value) {
         database=value;
         emit(AppCreateDataBaseState());
     });
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
   database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title,data,time,statues)VALUES("$title","$date","$time","new")')
          .then((value) async{
        print("${value}inserted successfully");
        emit(AppInsertDataBaseState());
   // await     getDataFromDatabase(database).then((value) {
   //        print("getData");
   //
   //      });
    //    emit(AppGetDataBaseState());
        getDataFromDatabase(database);

      }).catchError((error) {
        print(error.toString());
      });
      return null;
    });
  }
  /////




  ////
 void getDataFromDatabase(database){
    newTasks=[];
   doneTasks=[];
   archivedTasks=[];

    emit(AppGetLoadingBaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks=value;

    //  tasks=value;
   print(tasks);
      value.forEach((element) {
        if(element['statues']=='new')
          newTasks.add(element);
        else if(element['statues']=='done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
        print(element['statues']);
      });
      emit(AppGetDataBaseState());
    });
//    emit(AppGetDataBaseState())

  }
 void updateStatues({required String status,required int id}){
   database.rawUpdate(
         'UPDATE tasks SET statues = ? WHERE id = ?',
         ['$status',  id]).then((value) {
           getDataFromDatabase(database);
           emit(AppUpdateDateBaseState());
   });
   }

  void delete({required int id}){
    database.rawDelete(
        'DELETE FROM tasks  WHERE id = ?',
        [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteFromDateBaseState());
    });
  }
  bool isBottomSheet = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({required isShow,required IconData icon}){
      isBottomSheet=isShow;
      fabIcon=icon;
      emit(AppChangeBottomSheetState());

  }
}