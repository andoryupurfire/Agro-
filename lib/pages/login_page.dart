import 'package:agro_mas/pages/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Instancia del UserStorage
  final UserStorage _userStorage = UserStorage();

  // Diccionario de credenciales válidas (mantenemos algunas por defecto)
  final Map<String, String> _defaultCredentials = {
    'agricultor@agromas.com': 'agromas123',
    'admin@agromas.com': 'admin123'
  };

  // Método para manejar el inicio de sesión
  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validar campos vacíos
    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage('Por favor completa todos los campos');
      return;
    }

    // Primero verificar credenciales por defecto
    bool isDefaultUser = _defaultCredentials.containsKey(email) &&
        _defaultCredentials[email] == password;

    // Luego verificar usuarios registrados en UserStorage
    bool isRegisteredUser = _userStorage.validateCredentials(email, password);

    if (isDefaultUser || isRegisteredUser) {
      // Obtener información del usuario si está registrado
      Map<String, dynamic>? userData;
      if (isRegisteredUser) {
        userData = _userStorage.getUserByEmail(email);
      }

      // Navegar a la página de inicio si las credenciales son correctas
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            email: email,
            userData: userData,
          ),
        ),
      );
    } else {
      // Mostrar mensaje de error
      _showErrorMessage('Correo o contraseña incorrectos');
    }
  }

  // Método para mostrar mensajes de error
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                //ICONS
                Image.asset(
                  'assets/images/agromas.png',
                  width: 250,
                  height: 250,
                ),

                //INICIO SECCIÓN
                Text(
                  'Iniciar sesion',
                  style: GoogleFonts.outfit(
                      fontSize: 45,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                //LABEL CORREO ELECTRONICO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Correo electronico',
                      style: GoogleFonts.outfit(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //EMAIL TEXT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Agricultor@agromas.com',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //LABEL CONTRASEÑA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contraseña',
                      style: GoogleFonts.outfit(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //CONTRASEÑA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '..........',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                //BOTON DE INICIO DE SECCIÓN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    onTap: _handleLogin,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff1026f3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //RECUPERAR CONTRASEÑA Y REGISTRARSE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Recuperar\n contraseña',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff1026f3)),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Registrase',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff1026f3)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                // Botón para mostrar estadísticas (solo para debug)
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _userStorage.printAllUsers();
                    final stats = _userStorage.getStatistics();
                    print('Estadísticas: $stats');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Debug: Ver usuarios registrados (${_userStorage.getTotalUsers()})',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// Página de inicio después del login
class HomePage extends StatelessWidget {
  final String email;
  final Map<String, dynamic>? userData;

  const HomePage({
    super.key,
    required this.email,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: const Color(0xff1026f3),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido a AgroMas',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff1026f3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de la cuenta:',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Correo: $email',
                      style: GoogleFonts.outfit(fontSize: 16),
                    ),

                    // Mostrar información adicional si el usuario está registrado
                    if (userData != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Nombre: ${userData!['name']}',
                        style: GoogleFonts.outfit(fontSize: 16),
                      ),
                      if (userData!['selectedCrop'] != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Cultivo: ${userData!['selectedCrop']}',
                          style: GoogleFonts.outfit(fontSize: 16),
                        ),
                      ],
                      if (userData!['location'] != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Ubicación: ${userData!['location']}',
                          style: GoogleFonts.outfit(fontSize: 16),
                        ),
                      ],
                      if (userData!['experience'] != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Experiencia: ${userData!['experience']}',
                          style: GoogleFonts.outfit(fontSize: 16),
                        ),
                      ],
                    ] else ...[
                      const SizedBox(height: 8),
                      Text(
                        'Usuario por defecto',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Sesión iniciada correctamente',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  color: Colors.green.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
