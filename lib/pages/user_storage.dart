// Archivo para manejar el almacenamiento temporal de usuarios
// Guárdalo en lib/services/user_storage.dart

class UserStorage {
  static final UserStorage _instance = UserStorage._internal();
  factory UserStorage() => _instance;
  UserStorage._internal();

  // Lista para almacenar los usuarios registrados temporalmente
  final List<Map<String, dynamic>> _registeredUsers = [];

  // Método para agregar un usuario
  void addUser({
    required String name,
    required String email,
    required String password,
    required String selectedCrop,
    required String location,
    required String objective,
    required String experience,
    required bool hasInternet,
    required bool acceptTerms,
  }) {
    final user = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'email': email,
      'password': password,
      'selectedCrop': selectedCrop,
      'location': location,
      'objective': objective,
      'experience': experience,
      'hasInternet': hasInternet,
      'acceptTerms': acceptTerms,
      'registrationDate': DateTime.now().toIso8601String(),
    };

    _registeredUsers.add(user);

    // Imprimir en consola para debug
    print('=== USUARIO AGREGADO ===');
    print('ID: ${user['id']}');
    print('Nombre: ${user['name']}');
    print('Email: ${user['email']}');
    print('Cultivo: ${user['selectedCrop']}');
    print('Ubicación: ${user['location']}');
    print('Objetivo: ${user['objective']}');
    print('Experiencia: ${user['experience']}');
    print('Internet: ${user['hasInternet']}');
    print('Términos: ${user['acceptTerms']}');
    print('Fecha: ${user['registrationDate']}');
    print('Total usuarios: ${_registeredUsers.length}');
    print('========================');
  }

  // Método para obtener todos los usuarios
  List<Map<String, dynamic>> getAllUsers() {
    return List.unmodifiable(_registeredUsers);
  }

  // Método para buscar usuario por email
  Map<String, dynamic>? getUserByEmail(String email) {
    try {
      return _registeredUsers.firstWhere(
        (user) => user['email'].toString().toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Método para validar credenciales de login
  bool validateCredentials(String email, String password) {
    final user = getUserByEmail(email);
    if (user != null) {
      return user['password'] == password;
    }
    return false;
  }

  // Método para obtener el número total de usuarios
  int getTotalUsers() {
    return _registeredUsers.length;
  }

  // Método para eliminar un usuario por email
  bool removeUser(String email) {
    final userIndex = _registeredUsers.indexWhere(
      (user) => user['email'].toString().toLowerCase() == email.toLowerCase(),
    );

    if (userIndex != -1) {
      _registeredUsers.removeAt(userIndex);
      print('Usuario eliminado: $email');
      return true;
    }
    return false;
  }

  // Método para limpiar todos los usuarios (útil para testing)
  void clearAllUsers() {
    _registeredUsers.clear();
    print('Todos los usuarios han sido eliminados');
  }

  // Método para obtener usuarios filtrados por cultivo
  List<Map<String, dynamic>> getUsersByCrop(String crop) {
    return _registeredUsers
        .where(
          (user) =>
              user['selectedCrop'].toString().toLowerCase() ==
              crop.toLowerCase(),
        )
        .toList();
  }

  // Método para obtener usuarios filtrados por experiencia
  List<Map<String, dynamic>> getUsersByExperience(String experience) {
    return _registeredUsers
        .where(
          (user) =>
              user['experience'].toString().toLowerCase() ==
              experience.toLowerCase(),
        )
        .toList();
  }

  // Método para imprimir todos los usuarios (para debug)
  void printAllUsers() {
    print('=== LISTA COMPLETA DE USUARIOS ===');
    if (_registeredUsers.isEmpty) {
      print('No hay usuarios registrados');
    } else {
      for (int i = 0; i < _registeredUsers.length; i++) {
        final user = _registeredUsers[i];
        print('--- Usuario ${i + 1} ---');
        print('ID: ${user['id']}');
        print('Nombre: ${user['name']}');
        print('Email: ${user['email']}');
        print('Cultivo: ${user['selectedCrop']}');
        print('Ubicación: ${user['location']}');
        print('Experiencia: ${user['experience']}');
        print('Internet: ${user['hasInternet']}');
        print('Fecha registro: ${user['registrationDate']}');
        print('');
      }
    }
    print('Total: ${_registeredUsers.length} usuarios');
    print('===================================');
  }

  // Método para obtener estadísticas básicas
  Map<String, dynamic> getStatistics() {
    if (_registeredUsers.isEmpty) {
      return {
        'totalUsers': 0,
        'cropStats': {},
        'experienceStats': {},
        'internetStats': {'yes': 0, 'no': 0},
      };
    }

    // Estadísticas por cultivo
    Map<String, int> cropStats = {};
    Map<String, int> experienceStats = {};
    int internetYes = 0;
    int internetNo = 0;

    for (var user in _registeredUsers) {
      // Contar cultivos
      String crop = user['selectedCrop'];
      cropStats[crop] = (cropStats[crop] ?? 0) + 1;

      // Contar experiencias
      String experience = user['experience'];
      experienceStats[experience] = (experienceStats[experience] ?? 0) + 1;

      // Contar acceso a internet
      if (user['hasInternet'] == true) {
        internetYes++;
      } else {
        internetNo++;
      }
    }

    return {
      'totalUsers': _registeredUsers.length,
      'cropStats': cropStats,
      'experienceStats': experienceStats,
      'internetStats': {'yes': internetYes, 'no': internetNo},
    };
  }
}
