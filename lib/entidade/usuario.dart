class Usuario {
  String nome;
  String senha;
  int? id;
  Usuario({required this.nome, required this.senha});
  Map<String, dynamic> toMap() {
    var map = {
      'nome': nome,
      'senha': senha,
    };
    return map;
  }
}
