class Pessoa {
  String _nome;
  int _id = 0;
  String _telefone;
  String _email;
  Pessoa({id, required nome, required telefone, required email})
      : _email = email,
        _nome = nome,
        _telefone = telefone;

  String get nome => _nome;
  String get telefone => _telefone;
  String get email => _email;
  int get id => _id;

  set id(int id) {
    _id = id;
  }

  set nome(String nome) {
    _nome = nome;
  }

  set email(String email) {
    _email = email;
  }

  set telefone(String telefone) {
    _telefone = telefone;
  }

  // Construtor de fábrica
  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      email: map['email'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'telefone': _telefone, 'email': _telefone};
  }
}
