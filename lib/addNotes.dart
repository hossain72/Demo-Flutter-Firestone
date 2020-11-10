import 'package:flutter/material.dart';
import 'package:flutter_firestone_demo/FirestoreService.dart';
import 'package:flutter_firestone_demo/models/note.dart';

class AddNotes extends StatefulWidget {
  final Note note;

  AddNotes({this.note});

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;

  get isEditMode => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMode ? widget.note.title : '');
    _descriptionController =
        TextEditingController(text: isEditMode ? widget.note.description : '');
    _descriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Update Note" : "Add Note"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Title can not empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Description can not empty";
                  }
                  return null;
                },
                maxLines: 4,
                decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                  child: Text(isEditMode ? "Update" : "Save"),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        if (isEditMode) {
                          Note note = Note(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              documentId: widget.note.documentId);
                          FirestoneService().updateNote(note);
                        } else {
                          Note note = Note(
                              title: _titleController.text,
                              description: _descriptionController.text);
                          await FirestoneService().addNote(note);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
