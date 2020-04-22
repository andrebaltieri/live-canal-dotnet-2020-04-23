class TodoItem {
  int id;
  String title;
  bool done;
  String user;

  TodoItem({this.id, this.title, this.done, this.user});

  TodoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    done = json['done'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['done'] = this.done;
    data['user'] = this.user;
    return data;
  }
}
