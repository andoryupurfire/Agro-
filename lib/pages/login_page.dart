import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Diccionario de credenciales válidas
  final Map<String, String> _validCredentials = {
    'agricultor@agromas.com': 'agromas123',
    'admin@agromas.com': 'admin123'
  };

  // Método para manejar el inicio de sesión
  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validación de credenciales
    if (_validCredentials.containsKey(email) &&
        _validCredentials[email] == password) {
      // Navegar a la página de inicio si las credenciales son correctas
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(email: email)));
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Correo o contraseña incorrectos'),
        backgroundColor: Colors.red,
      ));
    }
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Recuperar\n contraseña',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff1026f3)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Registrase',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
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

  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: const Color(0xff1026f3),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sesión Iniciada',
              style:
                  GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Correo: $email',
              style: GoogleFonts.outfit(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
