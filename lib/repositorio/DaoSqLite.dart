import 'package:novo_projeto/entidade/pessoa.dart';
import 'package:novo_projeto/entidade/usuario.dart';
import 'package:novo_projeto/repositorio/interfaceDao';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DaoSqLite implements InterfaceDao {
  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'bd.db');
    // deleteDatabase(path); //para desenvolvimento
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE pessoas(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT, telefone TEXT);');
      await db.execute(
          'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, nome TEXT, senha TEXT);');
    },
        onUpgrade: (db, oldVersion, newVersion) {},
        version: 1); //qd já estiver em produção
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  @override
  Future<void> add(Pessoa pessoa) async {
    final Database db = await initializeDB();
    await db.insert('pessoas', pessoa.toMap());
    db.close();
  }

  @override
  Future<int> remove(Pessoa pessoa) async {
    final Database db = await initializeDB();
    return await db.delete("pessoas", where: 'id = ?', whereArgs: [pessoa.id]);
  }

  @override
  Future<List<Pessoa>> get dados async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('pessoas');
    return List.generate(maps.length, (i) {
      return Pessoa.fromMap(maps[i]);
    });
  }

  Future<int> addUser(Usuario usuario) async {
    final Database db = await initializeDB();
    int retorno = await db.insert('usuarios', usuario.toMap());
    db.close();
    return retorno;
  }

  Future<bool> login(String usuario, String senha) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'nome = ? AND senha = ?',
      whereArgs: [usuario, senha],
    );
    return maps.isNotEmpty;
  }
}
