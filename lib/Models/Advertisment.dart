class Advertisement {
  Advertisement({
    int? id,
    String? image,
    String? description,
  }) {
    _id = id;
    _image = image;
    _description = description;
  }

  Advertisement.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _description = json['description'];
  }
  int? _id;
  String? _image;
  String? _description;

  int? get id => _id;
  String? get image => _image;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['description'] = _description;
    return map;
  }
}
