import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:proton/alerts/info.dart';
import 'package:proton/components/task_tile.dart';
import 'package:proton/provider/tasks.dart';
import 'package:proton/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Tasks tasks = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Tarefas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.TASK_FORM,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.count,
        itemBuilder: (ctx, i) => TaskTile(tasks.all.elementAt(i)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            Text(
              'Proton version 1.0',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 143.0),
            ),
            IconButton(
              icon: Icon(Icons.date_range),
              color: Colors.white,
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.brightness_6),
              color: Colors.white,
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark);
              },
            ),
            IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              onPressed: () {
                information(context,
                    'Built in Visual Studio Code.\nFlutter version 1.17.4\nDeveloped by Matheus Jediel Ferreira.\nGraphic Design by Miguel Chiarello Fernandes.\nTester Renan de Souza Ramazzini.\nTeacher: Kléber de Oliveira Andrade.\nSpecial thanks: Victor Rodrigues and Guilherme Moriggi.\n2020');
              },
            ),
          ],
        ),
      ),
    );
  }
}
