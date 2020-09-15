import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proton/models/task.dart';
import 'package:proton/provider/tasks.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(Task task) {
    if (task != null) {
      _formData['id'] = task.id;
      _formData['description'] = task.description;
      _formData['priority'] = task.priority;
      _formData['date'] = task.date;
      _formData['hour'] = task.hour;
      _formData['avatarUrl'] = task.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Task task = ModalRoute.of(context).settings.arguments;

    _loadFormData(task);
  }

  String _validator(String text) {
    if (text.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Tarefa'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState.validate();

              if (isValid) {
                _form.currentState.save();

                setState(() {
                  _isLoading = true;
                });

                await Provider.of<Tasks>(context, listen: false).put(
                  Task(
                    id: _formData['id'],
                    description: _formData['description'],
                    priority: _formData['priority'],
                    date: _formData['date'],
                    hour: _formData['hour'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: 'Descrição'),
                      validator: _validator,
                      onSaved: (value) => _formData['description'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['priority'],
                      decoration: InputDecoration(labelText: 'Prioridade'),
                      onSaved: (value) => _formData['priority'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['date'],
                      decoration: InputDecoration(labelText: 'Data'),
                      onSaved: (value) => _formData['date'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['hour'],
                      decoration: InputDecoration(labelText: 'Horario'),
                      onSaved: (value) => _formData['hour'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      onSaved: (value) => _formData['avatarUrl'] = value,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
