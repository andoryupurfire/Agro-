import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Modelo para almacenar los datos de registro
class UserRegistrationData {
  final String name;
  final String email;
  final String password;
  final String selectedCrop;
  final String location;
  final String objective;
  final String experience;
  final bool hasInternet;
  final bool acceptTerms;

  UserRegistrationData({
    required this.name,
    required this.email,
    required this.password,
    required this.selectedCrop,
    required this.location,
    required this.objective,
    required this.experience,
    required this.hasInternet,
    required this.acceptTerms,
  });

  @override
  String toString() {
    return '''
Datos de Registro:
- Nombre: $name
- Email: $email
- Contraseña: $password
- Cultivo: $selectedCrop
- Ubicación: $location
- Objetivo: $objective
- Experiencia: $experience
- Internet: ${hasInternet ? 'Sí' : 'No'}
- Términos aceptados: ${acceptTerms ? 'Sí' : 'No'}
''';
  }
}

class MoreInfoPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String selectedCrop;
  final String location;
  final String objective;

  const MoreInfoPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.selectedCrop,
    required this.location,
    required this.objective,
  });

  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  // Variables para las selecciones
  String? _selectedExperience;
  bool? _hasInternet;
  bool _acceptTerms = false;
  bool _isLoading = false;

  // Opciones de experiencia
  final List<String> _experienceOptions = [
    'Principiante',
    'Intermedio',
    'Avanzado'
  ];

  // Lista temporal para almacenar usuarios registrados (simula base de datos)
  static final List<UserRegistrationData> _registeredUsers = [];

  // Método para crear la cuenta
  void _createAccount() async {
    // Validaciones
    if (_selectedExperience == null) {
      _showErrorMessage('Por favor selecciona tu nivel de experiencia');
      return;
    }

    if (_hasInternet == null) {
      _showErrorMessage('Por favor indica si tienes acceso a internet');
      return;
    }

    if (!_acceptTerms) {
      _showErrorMessage('Debes aceptar los términos y condiciones');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Crear objeto con todos los datos
      final userData = UserRegistrationData(
        name: widget.name,
        email: widget.email,
        password: widget.password,
        selectedCrop: widget.selectedCrop,
        location: widget.location,
        objective: widget.objective,
        experience: _selectedExperience!,
        hasInternet: _hasInternet!,
        acceptTerms: _acceptTerms,
      );

      // Simular delay de creación de cuenta
      await Future.delayed(const Duration(seconds: 2));

      // Guardar en la lista temporal (simula base de datos)
      _registeredUsers.add(userData);

      // Mostrar datos en consola para debug
      print('=== NUEVO USUARIO REGISTRADO ===');
      print(userData.toString());
      print('=== TOTAL DE USUARIOS: ${_registeredUsers.length} ===');

      // Mostrar mensaje de éxito
      _showSuccessDialog();
    } catch (e) {
      _showErrorMessage('Error al crear la cuenta: ${e.toString()}');
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

  // Método para mostrar el diálogo de éxito
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Cuenta creada exitosamente!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tu cuenta ha sido creada con los siguientes datos:'),
              const SizedBox(height: 10),
              Text('Nombre: ${widget.name}'),
              Text('Email: ${widget.email}'),
              Text('Cultivo: ${widget.selectedCrop}'),
              Text('Ubicación: ${widget.location}'),
              Text('Experiencia: $_selectedExperience'),
              const SizedBox(height: 10),
              const Text('Ya puedes iniciar sesión.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Cerrar el diálogo y volver al login
                Navigator.of(context).pop(); // Cerrar diálogo
                Navigator.of(context)
                    .popUntil((route) => route.isFirst); // Volver al login
              },
              child: const Text('Ir al Login'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Título
                  Center(
                    child: Text(
                      'Mas info.',
                      style: GoogleFonts.outfit(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff1026f3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Selecciona tu experiencia
                  Text(
                    'Selecciona tu experiencia',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Opciones de experiencia
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _experienceOptions.map((experience) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedExperience = experience;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedExperience == experience
                                ? const Color(0xff1026f3)
                                : Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            experience,
                            style: TextStyle(
                              color: _selectedExperience == experience
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),

                  // ¿Tienes acceso a internet?
                  Text(
                    '¿Tienes acceso a internet?',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Opción Sí
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _hasInternet = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Si',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: _hasInternet == true
                                  ? const Color(0xff1026f3)
                                  : Colors.white,
                            ),
                            child: _hasInternet == true
                                ? const Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Opción No
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _hasInternet = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: _hasInternet == false
                                  ? const Color(0xff1026f3)
                                  : Colors.white,
                            ),
                            child: _hasInternet == false
                                ? const Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Términos y condiciones
                  Text(
                    'Términos y condiciones',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Checkbox para términos
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xff1026f3),
                      ),
                      const Expanded(
                        child: Text(
                          'Aceptar términos y condiciones',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Link de políticas de privacidad
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        // Aquí puedes agregar la navegación a políticas de privacidad
                        print('Navegar a políticas de privacidad');
                      },
                      child: const Text(
                        'Políticas de privacidad',
                        style: TextStyle(
                          color: Color(0xff1026f3),
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Botón Crear cuenta
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _createAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isLoading ? Colors.grey : const Color(0xff1026f3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Crear cuenta',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
}
