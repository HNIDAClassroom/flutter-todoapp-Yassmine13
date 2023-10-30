import 'package:flutter/material.dart';
import 'package:todolist_app/Widgets/new_task.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/tasks_list.dart';

class Tasks extends StatefulWidget {

const Tasks({super.key});

@override

State<Tasks> createState() {

return _TasksState();

}

}

class _TasksState extends State<Tasks> {
            final List<Task> _registeredTasks = [

              Task(
              title: 'Apprendre Flutter',
              description: 'Suivre le cours pour apprendre de nouvelles compétences et pratiquer',
              date: DateTime.now(),
              category: Category.work,
              ),

              Task(

              title: 'Faire les courses',
              description: 'Acheter des provisions pour la semaine,Acheter des provisions pour la semaine',
              date: DateTime.now().subtract(Duration(days: 1)),
              category: Category.shopping,
              ),

              Task(
              title: 'Rediger un CR',
              description: 'une tâche courante dans de nombreuses professions et contextes',
              date: DateTime.now().subtract(Duration(days: 2)),
              category: Category.personal,
              ),
              // Add more tasks with descriptions as needed

              ];
  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>  NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
    });
  }
      @override

      Widget build(BuildContext context) {

            return Scaffold(
              appBar: AppBar(
              title: const Center(child: Text('ToDoList'),),
              actions: [
                IconButton(onPressed: _openAddTaskOverlay,
                icon: Ink(
                  decoration : const BoxDecoration(
                  shape: BoxShape.circle , color :  Color.fromARGB(255, 143, 143, 193)),
                  child:  const Padding( padding:EdgeInsets.all(10),
                  child : Icon(Icons.add)))),
              ],
            ),

            body: Center(child: Column(children: [
            Expanded(child: TasksList(tasks: _registeredTasks)),
            ],
            ),
            ),
  
      );

      }

}