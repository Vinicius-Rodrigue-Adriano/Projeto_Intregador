class UserModelManu {
  int? id; // Permitindo que o id seja nulo, pois será gerado pelo banco de dados
  String name;

  UserModelManu({required this.name, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
