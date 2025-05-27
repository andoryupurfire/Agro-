import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'garden_setup_page.dart'; // Importa la siguiente página

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variable para manejar el estado de carga
  bool _isLoading = false;

  // Método para validar el email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Método para manejar el registro básico
  void _handleRegister() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validaciones básicas
    if (name.isEmpty) {
      _showErrorMessage('Por favor ingresa tu nombre completo');
      return;
    }

    if (email.isEmpty || !_isValidEmail(email)) {
      _showErrorMessage('Por favor ingresa un correo electrónico válido');
      return;
    }

    if (password.isEmpty || password.length < 6) {
      _showErrorMessage('La contraseña debe tener al menos 6 caracteres');
      return;
    }

    // Mostrar indicador de carga
    setState(() {
      _isLoading = true;
    });

    try {
      // Simular delay de validación
      await Future.delayed(const Duration(seconds: 1));

      // Navegar a la página "Crear tu huerta" (GardenSetupPage)
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GardenSetupPage(
            name: name,
            email: email,
            password: password,
          ),
        ),
      );
    } catch (e) {
      _showErrorMessage('Error al procesar: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
    _nameController.dispose();
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
              child: Column(
                children: [
                  // Ilustración del agricultor
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/register.png',
                      width: 400,
                      height: 400,
                    ),
                  ),

                  // Título Registrate
                  Text(
                    'Registrate',
                    style: GoogleFonts.outfit(
                      fontSize: 45,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Campo Nombre Completo
                  _buildInputField(
                    label: 'Nombre Completo',
                    controller: _nameController,
                    hintText: 'Ingresa tu nombre',
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 20),

                  // Campo Correo Electrónico
                  _buildInputField(
                    label: 'Correo Electronico',
                    controller: _emailController,
                    hintText: 'Ingresa tu correo',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Campo Contraseña
                  _buildInputField(
                    label: 'Contraseña',
                    controller: _passwordController,
                    hintText: 'Ingresa una contraseña',
                    icon: Icons.lock,
                    obscureText: true,
                  ),

                  const SizedBox(height: 30),

                  // Botón Siguiente
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: GestureDetector(
                      onTap: _isLoading ? null : _handleRegister,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? Colors.grey
                              : const Color(0xff1026f3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Enlace para volver al login
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia sesión',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff1026f3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper para crear campos de entrada
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      children: [
        // Label del campo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Campo de texto
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  suffixIcon: Icon(
                    icon,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
