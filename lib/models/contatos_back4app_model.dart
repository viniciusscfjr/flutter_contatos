class ContatosBack4AppModel {
  List<Contato> contatos = [];

  ContatosBack4AppModel(this.contatos);

  ContatosBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <Contato>[];
      json['results'].forEach((v) {
        contatos.add(Contato.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = contatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class Contato {
  String objectId = "";
  String name = "";
  String path = "";
  String createdAt = "";
  String updatedAt = "";

  Contato(this.objectId, this.name, this.path, this.createdAt, this.updatedAt);

  Contato.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    path = json['path'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['name'] = name;
    data['path'] = path;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
