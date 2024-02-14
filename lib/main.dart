import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab08_todo/pages/todo_page.dart';
void main() {
  runApp( GetMaterialApp(
    home: WelcomePage(),
  ));
}
class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My ToDoList Application",style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey
            ),),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
              Get.offAll(ToDoPage());
            }, child: Text("GetStarted"))
          ],
        ),
      ),
    );
  }
}
