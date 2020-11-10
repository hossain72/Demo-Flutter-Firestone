class Note {
  String title;
  String description;
  String documentId;

  Note({this.title, this.description, this.documentId});

  Note.formMap(Map<String, dynamic> data, String id) {
    title = data['title'];
    description = data['description'];
    documentId = id;
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }
}
