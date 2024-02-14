import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/todo_controller.dart';

class ToDoPage extends StatelessWidget {
  ToDoPage({super.key});

  final ToDoController todoController =Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController=TextEditingController();
    TextEditingController descriptionController=TextEditingController();
    String selectItem="Personal";

    return Scaffold(
      appBar: AppBar(
        title: Text("My ToDo List"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.list), label: "MyList"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.apple), label: "Mydata")
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: "Title-ชื่อเรื่อง", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: "Description-รายละเอียด",
                  border: OutlineInputBorder()),
            ),
          ),
          DropdownButtonFormField(
            value:selectItem,
              items: ["Personal", "Work", "Study", "Others"]
                  .map((category) => DropdownMenuItem(
                        child: Text(category),
                        value: category,
                      )).toList(),
              onChanged: (value) {
                selectItem=value.toString();
              },
            decoration: InputDecoration(labelText: "Category",border: OutlineInputBorder()),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            todoController.addToDo(titleController.text, descriptionController.text, selectItem);
            print("Add data success");
            titleController.clear();
            descriptionController.clear();
          }, child: Text("Add Todo")),
          Expanded(child: Obx(() {
            return ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                Color? c;
                IconData ic;
                if(todoController.todos[index]["category"]=="Study"){
                  c=Colors.orangeAccent;
                  ic=FontAwesomeIcons.bookBible;
                }else{
                  c=Colors.blue;
                  ic=FontAwesomeIcons.airbnb;
                }

              return Card(
                child: ListTile(
                  leading: Icon(ic,color: c,size: 30,),
                  title: Text("Title:: ${todoController.todos[index]["title"]}"),
                  subtitle: Text("Description:: ${todoController.todos[index]["description"]}"),
                  trailing: IconButton(icon: Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Are you sure to delete data",
                        onCancel: () => Get.back(),
                        onConfirm: () {
                          todoController.deleteToDo(todoController.todos[index]["id"]);
                          Get.back();
                        },
                      );
                      //todoController.deleteToDo(todoController.todos[index]["id"]);
                  },),
                ),
              );
            },);
          }))
        ],
      ),
    );
  }
}
