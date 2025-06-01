import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDashboard extends StatefulWidget {
  final String email;
  final Map<String, dynamic>? userData;

  const MainDashboard({
    super.key,
    required this.email,
    this.userData,
  });

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  // Datos simulados para la demostración
  String get userName => widget.userData?['name'] ?? 'Usuario';
  String get userLocation => widget.userData?['location'] ?? 'Barrancabermeja';
  String get userCrop => widget.userData?['selectedCrop'] ?? 'Tomate';
  
  // Temperatura simulada
  int currentTemperature = 36;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E7D32), // Verde principal
      body: SafeArea(
        child: Column(
          children: [
            // Header con información del usuario
            _buildHeader(),
            
            // Contenido principal
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Recomendación según temperatura
                      _buildTemperatureRecommendation(),
                      
                      const SizedBox(height: 20),
                      
                      // Título de opciones
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Escoge la opción necesaria',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Grid de opciones
                      Expanded(
                        child: _buildOptionsGrid(),
                      ),
                      
                      // Doctor cultivo
                      _buildDoctorCultivo(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, $userName',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          
          // Tarjeta de información
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                // Temperatura
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.thermostat, color: Colors.orange.shade700, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        '${currentTemperature}°C',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 15),
                
                // Cultivo
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.eco, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        userCrop,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Ubicación
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red.shade600, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      userLocation.length > 10 ? '${userLocation.substring(0, 10)}...' : userLocation,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureRecommendation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xff1026f3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Según tu temperatura actual',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentTemperature > 35 
                ? 'No es recomendable aplicarte agua al cultivo justo ahora.'
                : 'Es un buen momento para regar tu cultivo.',
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOptionsGrid() {
    final options = [
      {
        'title': 'Preparación\ntierra',
        'icon': Icons.landscape,
        'color': Colors.brown.shade400,
      },
      {
        'title': 'Siembra',
        'icon': Icons.spa,
        'color': Colors.green.shade400,
      },
      {
        'title': 'Cuidado\ncultivo',
        'icon': Icons.lightbulb_outline,
        'color': Colors.yellow.shade600,
      },
      {
        'title': 'Cuidado\ndel agua',
        'icon': Icons.water_drop,
        'color': Colors.blue.shade400,
      },
      {
        'title': 'Prevención\nde plagas',
        'icon': Icons.bug_report,
        'color': Colors.red.shade400,
      },
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.9,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        if (index == 4) {
          // Para el último elemento, ocupar toda la fila
          return GridTile(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: options[index]['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      options[index]['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    options[index]['title'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        
        return GestureDetector(
          onTap: () => _handleOptionTap(index),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: options[index]['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    options[index]['icon'] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  options[index]['title'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorCultivo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doctor cultivo',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _handleDoctorCultivo(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Sube una foto de tu cultivo o planta y obtén un diagnóstico',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff2E7D32),
        unselectedItemColor: Colors.grey,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Mi Cultivo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Foro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi perfil',
          ),
        ],
      ),
    );
  }

  void _handleOptionTap(int index) {
    final options = ['Preparación tierra', 'Siembra', 'Cuidado cultivo', 'Cuidado del agua', 'Prevención de plagas'];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: ${options[index]}'),
        backgroundColor: const Color(0xff2E7D32),
      ),
    );
  }

  void _handleDoctorCultivo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Doctor Cultivo',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          content: const Text('Esta función te permitirá tomar una foto de tu cultivo para obtener un diagnóstico automático.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Aquí implementarías la funcionalidad de la cámara
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Función de cámara no implementada aún'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2E7D32),
                foregroundColor: Colors.white,
              ),
              child: const Text('Abrir Cámara'),
            ),
          ],
        );
      },
    );
  }
}