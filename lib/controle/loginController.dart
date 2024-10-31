import 'package:novo_projeto/autenticacao/jwt.dart';
import 'package:novo_projeto/autenticacao/secureStorage.dart';
import 'package:novo_projeto/repositorio/DaoSqLite.dart';

import '../entidade/usuario.dart';

class Logincontroller {
  final DaoSqLite _dao = DaoSqLite();
  final SecureStorage _secureStorage = SecureStorage();
  final JwtService _jwtService = JwtService();

  Future<int> salvar(String nome, String senha) {
    Usuario login = Usuario(nome: nome, senha: senha);
    return _dao.addUser(login);
  }

  // Realiza o login, gera o token e armazena-o de forma segura
  Future<bool> login(String nome, String senha) async {
    bool autenticado = await _dao.login(nome, senha);
    if (autenticado) {
      // Gera o token JWT e salva no armazenamento seguro
      final token = _jwtService.generateToken(nome, senha);
      await _secureStorage.salvarToken(token);
      print('Login bem-sucedido! Token salvo.');
      return true;
    }
    print('Falha no login. Credenciais inválidas.');
    return false;
  }

  // Verifica o status do token armazenado
  Future<bool> verificarLogin() async {
    final token = await _secureStorage.carregarToken();
    if (token != null) {
      return _jwtService.verifyToken(token);
    }
    return false;
  }

  // Logout - remove o token do armazenamento seguro
  Future<void> logout() async {
    await _secureStorage.removerToken();
    print('Logout realizado. Token removido.');
  }
}
