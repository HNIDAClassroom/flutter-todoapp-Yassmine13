import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  Category _selectedCategory = Category.personal;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _submitTaskData() {
    final enteredTitle = _titleController.text.trim();
    final enteredDescription = _descriptionController.text.trim();
    final enteredDate = _dateController.text.trim();

    if (enteredTitle.isEmpty ||  enteredDate.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Merci de remplir tous les champs requis.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // Parse enteredDate to a DateTime, assuming it's in a specific format
    final dateParts = enteredDate.split('/');
    final date = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
    );

    final task = Task(
      title: enteredTitle,
      description: enteredDescription,
      date: date,
      category: _selectedCategory,
    );

    widget.onAddTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Date (DD/MM/YYYY)'),
          ),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values
                .map((category) => DropdownMenuItem<Category>(
                      value: category,
                      child: Text(
                        category.name.toUpperCase(),
                      ),
                    ))
                .toList(),
            onChanged: (Category? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: _submitTaskData,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}




