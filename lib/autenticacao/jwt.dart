import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService {
  static const _secretKey = 'my_secret_key';

  // Gera o token JWT
  String generateToken(String nome, String senha) {
    final jwt = JWT({
      'nome': nome,
      'senha': senha,
    });
    return jwt.sign(SecretKey(_secretKey));
  }

  // Verifica o token JWT
  bool verifyToken(String token) {
    try {
      JWT.verify(token, SecretKey(_secretKey));
      return true;  // Token é válido
    } catch (e) {
      print('Token inválido: $e');
      return false;  // Token é inválido ou expirado
    }
  }
}
