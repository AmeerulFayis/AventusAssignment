import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todoapp/function/db_functions.dart';
import 'package:todoapp/model/data_model.dart';
import 'package:todoapp/util/app_color.dart';
import 'package:todoapp/util/app_constants.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  bool checked=false;
  
  TextEditingController titleController =TextEditingController();
  TextEditingController dateController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  @override

  void addTask(){
    showDialog(context: context, builder: (context){
return  AlertDialog(
  backgroundColor: AppColor.green,
  content: Container(height: screenHeight(context),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        //title
        TextField(
          cursorColor: Colors.black,
controller: titleController,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
              hintText: "title"
          ),),
//due date
        TextField(
          cursorColor: Colors.black,
          controller: dateController,

          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
              hintText: "Due date"
          ),),
        // description
        TextField(
          maxLines: 10,
          controller: descriptionController,
          cursorColor: Colors.black,

          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
              hintText: "Description"
          ),),

        // save button + cancel button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Save button
            MaterialButton(onPressed: (){
              saveButtonFunction();
              titleController.clear();
              descriptionController.clear();
              dateController.clear();
              Navigator.pop(context);
            },color: AppColor.darkGreen,child: Text("Save"),),
            const SizedBox(width: 8,),
            // Cancel button
            MaterialButton(onPressed: (){
              Navigator.pop(context);
            },color: AppColor.darkGreen,child: Text("Cancel"),),

          ],
        )


      ],
    ),
  ),
);
    });

  }

//app exit dialogue
  Future<bool> exitDialog() async {
    return (await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: AppColor.green,
              title: const Text(
                "Are you sure...?", style: TextStyle(color: Colors.black),),
              content: const Text("Do you want to exit from the App",
                style: TextStyle(color: Colors.black),),
              actions: [
                TextButton(onPressed: () {
                  SystemNavigator.pop();
                }, child: const Text("YES",style: TextStyle(color: Colors.black),)),
                TextButton(onPressed: () {
                  Navigator.of(context).pop(false);
                }, child: const Text("NO",style: TextStyle(color: Colors.black),))
              ],
            )))??false;
  }

  Widget build(BuildContext context) {
    getAllTodo();
    return  WillPopScope(
      onWillPop:exitDialog,
      child: Scaffold(
        
        appBar: AppBar(
          title: const Text("Todo App"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
            
            valueListenable: todoListNotifier,
            builder: (BuildContext context, List<TodoModel> todoList, Widget? child) {
              return   ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount:todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data=todoList[index];
                  return Container(
                    margin: commonPaddingAll20,
                    padding: commonPaddingAll10,
                    decoration: BoxDecoration(
                        color: AppColor.green,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.title,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:checked?Colors.grey:AppColor.black,decoration:checked?TextDecoration.lineThrough:TextDecoration.none ),),
                        dividerH5(),
                        Text(data.description,style:TextStyle(color:checked?Colors.grey:AppColor.black,decoration:checked?TextDecoration.lineThrough:TextDecoration.none )),
                        dividerH5(),
                        Text(data.date),
                        dividerH5(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( checked==true?"task completed":"task not completed",style: TextStyle(color:checked?AppColor.white:AppColor.red ),),
                            IconButton(onPressed: (){}, icon:Icon(Icons.edit,color:AppColor.white,)),
                            IconButton(onPressed: (){
                                deleteTodo(index);

      
      
                            }, icon:Icon(Icons.delete,color:AppColor.red,)),
                            //check box
                            InkWell(
                              onTap: (){
                                setState(() {
                                  checked=!checked;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    border: Border.all(
                                        color: AppColor.black,
                                        width:2
                                    )
                                ),
                                child: Center(child: checked==true?Icon(Icons.done):Container()),
      
                              ),
                            )
                          ],
                        ),
      
                      ],
                    ),
                  );
                },);
            },
      
      
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.darkGreen,
            onPressed: (){
             addTask();
            },
        child: Icon(Icons.note_add,color: AppColor.white,),
        ),
      ),
    );
  }
  Future <void> saveButtonFunction()async {
    final _title=titleController.text.trim();
    final _date=dateController.text.trim();
    final _description=descriptionController.text.trim();
   if(_title.isEmpty || _date.isEmpty || _description.isEmpty){
     return;

   }
   final _todo=TodoModel(title: _title, description: _description, date: _date);
   addTodo(_todo);

  }
}
