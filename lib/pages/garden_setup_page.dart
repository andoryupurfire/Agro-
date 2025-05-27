import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'more_info_page.dart';

class GardenSetupPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const GardenSetupPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<GardenSetupPage> createState() => _GardenSetupPageState();
}

class _GardenSetupPageState extends State<GardenSetupPage> {
  // Controladores para campos de texto
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();

  // Variables para las selecciones
  String? _selectedCrop;
  String? _selectedSoilType;

  // Opciones disponibles
  final List<String> _cropOptions = ['Tomate', 'Maíz', 'Yuca'];
  final List<String> _soilOptions = [
    'Arenoso',
    'Arcilloso',
    'Franco',
    'Limoso',
    'Salino'
  ];

  // Método para continuar al siguiente paso
  void _continueToNextStep() {
    // Validaciones
    if (_selectedCrop == null) {
      _showErrorMessage('Por favor selecciona un cultivo de preferencia');
      return;
    }

    if (_locationController.text.trim().isEmpty) {
      _showErrorMessage('Por favor ingresa la ubicación del terreno');
      return;
    }

    if (_selectedSoilType == null) {
      _showErrorMessage('Por favor selecciona el tipo de suelo');
      return;
    }

    if (_objectiveController.text.trim().isEmpty) {
      _showErrorMessage('Por favor ingresa los objetivos del cultivo');
      return;
    }

    // Navegar a la siguiente página pasando todos los datos
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoreInfoPage(
          name: widget.name,
          email: widget.email,
          password: widget.password,
          selectedCrop: _selectedCrop!,
          location: _locationController.text.trim(),
          objective: _objectiveController.text.trim(),
        ),
      ),
    );
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
    _locationController.dispose();
    _objectiveController.dispose();
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
                      'Crea tu huerta',
                      style: GoogleFonts.outfit(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff1026f3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ¿Cultivo de preferencia?
                  Text(
                    '¿Cultivo de preferencia?',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Opciones de cultivo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _cropOptions.map((crop) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCrop = crop;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedCrop == crop
                                ? const Color(0xff1026f3)
                                : Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            crop,
                            style: TextStyle(
                              color: _selectedCrop == crop
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),

                  // Ubicación del terreno
                  Text(
                    'Ubicación del terreno',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: 'Ingresa tu ubicación',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tipo de suelo
                  Text(
                    'Tipo de suelo',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Primera fila de opciones de suelo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _soilOptions.take(3).map((soil) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSoilType = soil;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedSoilType == soil
                                ? const Color(0xff1026f3)
                                : Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            soil,
                            style: TextStyle(
                              color: _selectedSoilType == soil
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
                  const SizedBox(height: 15),

                  // Segunda fila de opciones de suelo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Añadir espacios vacíos para centrar los últimos elementos
                      const SizedBox(width: 80),
                      ...(_soilOptions.skip(3).map((soil) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSoilType = soil;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedSoilType == soil
                                  ? const Color(0xff1026f3)
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              soil,
                              style: TextStyle(
                                color: _selectedSoilType == soil
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                      const SizedBox(width: 80),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Objetivos del cultivo
                  Text(
                    'Objetivos del cultivo',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _objectiveController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Ingresa una razón',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Botón Siguiente
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _continueToNextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1026f3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Siguiente',
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
