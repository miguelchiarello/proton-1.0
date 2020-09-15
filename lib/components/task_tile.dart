import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proton/alerts/details.dart';
import 'package:proton/models/task.dart';
import 'package:proton/provider/tasks.dart';
import 'package:proton/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile(this.task);
  @override
  Widget build(BuildContext context) {
    final avatar = task.avatarUrl == null || task.avatarUrl.isEmpty
        ? CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2016/03/31/19/50/checklist-1295319_960_720.png'),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(task.avatarUrl),
          );

    return Container(
      child: ListTile(
        leading: avatar,
        title: Text(
          task.description,
        ),
        subtitle: Text(
          task.priority,
        ),
        trailing: Container(
          width: 146,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.access_time),
                color: Colors.green,
                onPressed: () {
                  details(
                    context,
                    'Data: ${task.date}\nHora: ${task.hour}',
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.TASK_FORM,
                    arguments: task,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Excluir Tarefa'),
                      content: Text('Deseja excluir a tarefa?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Sim'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        FlatButton(
                          child: Text('Não'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
                    ),
                  ).then((confirmed) {
                    if (confirmed) {
                      Provider.of<Tasks>(context, listen: false).remove(task);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
