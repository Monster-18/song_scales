class ScaleModel{
  int id;
  String name;
  String scale;
  String comments;

  ScaleModel({this.id, this.name, this.scale, this.comments});

  ScaleModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    scale = map['scale'];
    comments = map['comments'];
  }

  Map<String, dynamic> toMap(){
    return {'id': id, 'name': name, 'scale': scale, 'comments': comments};
  }
}