import 'package:flutter/material.dart';
import 'package:flutter_firestone_demo/FirestoreService.dart';
import 'package:flutter_firestone_demo/addNotes.dart';
import 'package:flutter_firestone_demo/models/note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      // body: SingleChildScrollView(),
      body: StreamBuilder(
          stream: FirestoneService().getNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final Note note = snapshot.data[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AddNotes(
                                              note: note,
                                            )));
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteNote(context, note.documentId);
                              }),
                        ],
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNotes()));
          }),
    );
  }

  void _deleteNote(BuildContext context, String documentId) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoneService().deleteNote(documentId);
        print(documentId);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text("Delete"),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("No"),
                ),
              ],
            ));
  }
}
