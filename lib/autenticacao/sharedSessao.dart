import 'package:shared_preferences/shared_preferences.dart';

class SharedSessao {
// Função para salvar o token de autenticação
  static Future<void> salvarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

// Função para carregar o token de autenticação
  static Future<String?> carregarToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

// Função para verificar se o usuário está logado
  static Future<bool> estaLogado() async {
    final token = await carregarToken();
    return token != null;
  }

// Função para remover o token de autenticação (logout)
  static Future<void> removerToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

// Uso das funções em um fluxo de login/logout
  void login(String token) async {
    await salvarToken(token); // Salva o token no login
  }

  static void logout() async {
    await removerToken(); // Remove o token no logout
  }
}
