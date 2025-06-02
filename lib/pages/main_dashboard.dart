import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/plant_diagnosis_screen.dart';

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
  String get userName => widget.userData?['name'] ?? 'Luis Diaz';
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
                  color: Color(0xffF5F5F5), // Fondo gris claro
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Recomendación según temperatura
                      _buildTemperatureRecommendation(),
                      
                      const SizedBox(height: 24),
                      
                      // Título de opciones
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Escoge la opción necesaria',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Grid de opciones
                      Expanded(
                        child: _buildOptionsGrid(),
                      ),
                      
                      const SizedBox(height: 24),
                      
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Temperatura
                _buildInfoItem(
                  Icons.thermostat_outlined,
                  '${currentTemperature}°C',
                  Colors.orange,
                  customImage: 'assets/images/icono_tomate.png', // Tu icono personalizado
                ),
                
                // Cultivo
                _buildInfoItem(
                  Icons.local_florist,
                  userCrop,
                  const Color(0xff2E7D32),
                  customImage: 'assets/icons/tomato.png', // Tu icono personalizado
                ),
                
                // Ubicación
                _buildInfoItem(
                  Icons.location_on,
                  userLocation.length > 8 ? '${userLocation.substring(0, 8)}...' : userLocation,
                  Colors.red,
                  customImage: 'assets/icons/location.png', // Tu icono personalizado
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color color, {String? customImage}) {
    return Flexible(
      child: Column(
        children: [
          // Usar imagen personalizada si está disponible, sino usar icono
          if (customImage != null)
            Container(
              width: 32,
              height: 32,
              child: Image.asset(
                customImage,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Si falla cargar la imagen, usar el icono por defecto
                  return Icon(
                    icon,
                    color: color,
                    size: 32,
                  );
                },
              ),
            )
          else
            Icon(
              icon,
              color: color,
              size: 32,
            ),
          const SizedBox(height: 8),
          Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureRecommendation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff4285F4),
            const Color(0xff1976D2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff4285F4).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                currentTemperature > 35 ? Icons.warning_amber : Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Según tu temperatura actual',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currentTemperature > 35 
                ? 'No es recomendable aplicar agua al cultivo justo ahora.'
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
        'icon': Icons.agriculture,
        'color': Colors.brown.shade600,
        'action': 'preparacion_tierra',
      },
      {
        'title': 'Siembra',
        'icon': Icons.eco,
        'color': Colors.green.shade600,
        'action': 'siembra',
      },
      {
        'title': 'Consejos\ncultivo',
        'icon': Icons.lightbulb_outline,
        'color': Colors.orange.shade600,
        'action': 'consejos_cultivo',
      },
      {
        'title': 'Cuidado\ndel agua',
        'icon': Icons.water_drop,
        'color': Colors.blue.shade600,
        'action': 'cuidado_agua',
      },
      {
        'title': 'Prevención\nde plagas',
        'icon': Icons.pest_control,
        'color': Colors.red.shade600,
        'action': 'prevencion_plagas',
      },
      {
        'title': 'Cosecha',
        'icon': Icons.grass,
        'color': Colors.amber.shade600,
        'action': 'cosecha',
      },
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          // Primera fila - 3 elementos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOptionCard(options[0]),
              _buildOptionCard(options[1]),
              _buildOptionCard(options[2]),
            ],
          ),
          const SizedBox(height: 20),
          // Segunda fila - 3 elementos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOptionCard(options[3]),
              _buildOptionCard(options[4]),
              _buildOptionCard(options[5]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(Map<String, dynamic> option) {
    return GestureDetector(
      onTap: () => _handleOptionTap(option['action']),
      child: Container(
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (option['color'] as Color).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildOptionIcon(option),
            ),
            const SizedBox(height: 10),
            Text(
              option['title'] as String,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionIcon(Map<String, dynamic> option) {
    // Prioridad: imagen personalizada > icono por defecto
    if (option['imageIcon'] != null) {
      return ClipOval(
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: (option['color'] as Color).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            option['imageIcon'] as String,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Si falla cargar la imagen, usa el icono por defecto
              return Icon(
                option['icon'] as IconData,
                color: option['color'] as Color,
                size: 30,
              );
            },
          ),
        ),
      );
    } else {
      // Usar icono por defecto de Material Icons
      return Icon(
        option['icon'] as IconData,
        color: option['color'] as Color,
        size: 30,
      );
    }
  }

  Widget _buildDoctorCultivo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doctor cultivo',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () => _handleDoctorCultivo(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xff4285F4), 
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff4285F4).withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff4285F4),
                        const Color(0xff1976D2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'Sube una foto de tu cultivo o planta y obtén un diagnóstico',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff4285F4),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff2E7D32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
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
          _handleBottomNavTap(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff2E7D32),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
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

  void _handleOptionTap(String action) {
    // Manejo más específico de cada acción
    switch (action) {
      case 'preparacion_tierra':
        _navigateToPreparacionTierra();
        break;
      case 'siembra':
        _navigateToSiembra();
        break;
      case 'consejos_cultivo':
        _navigateToConsejosCultivo();
        break;
      case 'cuidado_agua':
        _navigateToCuidadoAgua();
        break;
      case 'prevencion_plagas':
        _navigateToPrevencionPlagas();
        break;
      case 'cosecha':
        _navigateToCosecha();
        break;
      default:
        _showGenericMessage(action);
    }
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Ya estamos en inicio
        break;
      case 1:
        _navigateToMiCultivo();
        break;
      case 2:
        _navigateToForo();
        break;
      case 3:
        _navigateToMiPerfil();
        break;
    }
  }

  // Métodos de navegación específicos
  void _navigateToPreparacionTierra() {
    _showFeatureDialog('Preparación de Tierra', 
        'Aprende cómo preparar la tierra correctamente para tu cultivo de $userCrop.');
  }

  void _navigateToSiembra() {
    _showFeatureDialog('Siembra', 
        'Guía paso a paso para sembrar tu $userCrop en las mejores condiciones.');
  }

  void _navigateToConsejosCultivo() {
    _showFeatureDialog('Consejos de Cultivo', 
        'Consejos especializados para el cuidado de tu $userCrop.');
  }

  void _navigateToCuidadoAgua() {
    _showFeatureDialog('Cuidado del Agua', 
        'Aprende sobre riego y manejo del agua para tu cultivo.');
  }

  void _navigateToPrevencionPlagas() {
    _showFeatureDialog('Prevención de Plagas', 
        'Identifica y prevé plagas comunes en el cultivo de $userCrop.');
  }

  void _navigateToCosecha() {
    _showFeatureDialog('Cosecha', 
        'Guía para cosechar tu $userCrop en el momento perfecto.');
  }

  void _navigateToMiCultivo() {
    _showFeatureDialog('Mi Cultivo', 
        'Aquí podrás ver el progreso y estado de tu cultivo de $userCrop.');
  }

  void _navigateToForo() {
    _showFeatureDialog('Foro', 
        'Conecta con otros agricultores y comparte experiencias.');
  }

  void _navigateToMiPerfil() {
    _showFeatureDialog('Mi Perfil', 
        'Gestiona tu información personal y configuración de la app.');
  }

  void _showGenericMessage(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: $action'),
        backgroundColor: const Color(0xff2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showFeatureDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: const Color(0xff2E7D32),
            ),
          ),
          content: Text(
            description,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cerrar',
                style: GoogleFonts.outfit(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showGenericMessage('Función "$title" próximamente');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continuar',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

void _handleDoctorCultivo() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlantDiagnosisScreen(),
    ),
  );
}

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selecciona una opción',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xff4285F4)),
                title: Text(
                  'Tomar foto',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showGenericMessage('Cámara no implementada aún');
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xff4285F4)),
                title: Text(
                  'Seleccionar de galería',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showGenericMessage('Galería no implementada aún');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}