import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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
  double? currentTemp;
  String currentLocation = 'Cargando...';
  bool isLoadingLocation = true;
  bool hasLocationError = false;

  // Datos simulados para la demostración
  String get userName => widget.userData?['name'] ?? 'Brayan';
  String get userCrop => widget.userData?['selectedCrop'] ?? 'Tomate';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        isLoadingLocation = true;
        hasLocationError = false;
        currentLocation = 'Verificando permisos...';
      });

      // 1. Verificar si el servicio de ubicación está habilitado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          hasLocationError = true;
          currentLocation = 'GPS desactivado';
          isLoadingLocation = false;
        });
        
        // Mostrar diálogo para activar GPS
        _showLocationServiceDialog();
        return;
      }

      // 2. Verificar permisos actuales
      LocationPermission permission = await Geolocator.checkPermission();
      
      // 3. Si el permiso está denegado, solicitarlo
      if (permission == LocationPermission.denied) {
        setState(() {
          currentLocation = 'Solicitando permisos...';
        });
        
        permission = await Geolocator.requestPermission();
        
        if (permission == LocationPermission.denied) {
          setState(() {
            hasLocationError = true;
            currentLocation = 'Permiso denegado';
            isLoadingLocation = false;
          });
          _showPermissionDeniedDialog();
          return;
        }
      }

      // 4. Si el permiso está denegado permanentemente
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          hasLocationError = true;
          currentLocation = 'Sin permisos';
          isLoadingLocation = false;
        });
        _showPermissionDeniedForeverDialog();
        return;
      }

      // 5. Obtener la ubicación con configuración mejorada
      setState(() {
        currentLocation = 'Obteniendo ubicación...';
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      ).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          throw Exception('Timeout obteniendo ubicación');
        },
      );

      print('Ubicación obtenida: ${position.latitude}, ${position.longitude}');

      // 6. Obtener datos del clima
      await _getWeatherData(position.latitude, position.longitude);
      
    } catch (e) {
      print('Error obteniendo ubicación: $e');
      setState(() {
        hasLocationError = true;
        currentLocation = 'Error de ubicación';
        isLoadingLocation = false;
      });
      
      // Intentar usar ubicación aproximada como fallback
      _tryLastKnownPosition();
    }
  }

  Future<void> _tryLastKnownPosition() async {
    try {
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        print('Usando última ubicación conocida: ${lastPosition.latitude}, ${lastPosition.longitude}');
        await _getWeatherData(lastPosition.latitude, lastPosition.longitude);
      }
    } catch (e) {
      print('Error obteniendo última ubicación: $e');
      // Si todo falla, usar coordenadas de Barrancabermeja como fallback
      _useFallbackLocation();
    }
  }

  void _useFallbackLocation() {
    // Coordenadas de Barrancabermeja, Santander
    _getWeatherData(7.0653, -73.8547);
  }

  Future<void> _getWeatherData(double lat, double lon) async {
    const apiKey = 'b805e5e45416a3e8ae27c35a2566a732';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=es');

    try {
      setState(() {
        currentLocation = 'Obteniendo clima...';
      });

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          currentTemp = data['main']['temp']?.toDouble();
          currentLocation = data['name'] ?? 'Ubicación desconocida';
          isLoadingLocation = false;
          hasLocationError = false;
        });
        print('Clima obtenido para: $currentLocation, Temp: $currentTemp°C');
      } else {
        throw Exception('Error en API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error obteniendo clima: $e');
      setState(() {
        hasLocationError = true;
        currentLocation = 'Error de conexión';
        isLoadingLocation = false;
      });
    }
  }

  // Diálogos informativos
  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'GPS Desactivado',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Para obtener información del clima necesitas activar el GPS en tu dispositivo.',
            style: GoogleFonts.outfit(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.outfit()),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Geolocator.openLocationSettings();
                // Reintentar después de 2 segundos
                Future.delayed(const Duration(seconds: 2), () {
                  _getCurrentLocation();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2E7D32),
              ),
              child: Text('Abrir Configuración', style: GoogleFonts.outfit(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Permiso de Ubicación',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'La aplicación necesita acceso a tu ubicación para mostrar información del clima local.',
            style: GoogleFonts.outfit(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.outfit()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getCurrentLocation(); // Reintentar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2E7D32),
              ),
              child: Text('Intentar de nuevo', style: GoogleFonts.outfit(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Permisos Requeridos',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Los permisos de ubicación están permanentemente denegados. Ve a Configuración > Aplicaciones > Tu App > Permisos para habilitarlos.',
            style: GoogleFonts.outfit(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.outfit()),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Geolocator.openAppSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2E7D32),
              ),
              child: Text('Abrir Configuración', style: GoogleFonts.outfit(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E7D32),
      body: SafeArea(
        child: Column(
          children: [
            // Header con información del usuario
            _buildHeader(),
            
            // Contenido principal
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
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
                  currentTemp != null 
                    ? '${currentTemp!.toStringAsFixed(1)}°C' 
                    : '--°C',
                  Colors.orange,
                  customImage: 'assets/images/temperatura.png',
                  isLoading: isLoadingLocation,
                ),
                
                // Cultivo
                _buildInfoItem(
                  Icons.local_florist,
                  userCrop,
                  const Color(0xff2E7D32),
                  customImage: 'assets/images/icono_tomate.png',
                ),
                
                // Ubicación con botón de reintentar
                GestureDetector(
                  onTap: hasLocationError ? _getCurrentLocation : null,
                  child: _buildInfoItem(
                    Icons.location_on,
                    _truncateLocation(currentLocation),
                    hasLocationError ? Colors.red : Colors.blue,
                    customImage: 'assets/icons/ubicacion.png',
                    isLoading: isLoadingLocation,
                    hasError: hasLocationError,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _truncateLocation(String location) {
    if (location.length > 12) {
      return '${location.substring(0, 12)}...';
    }
    return location;
  }

  Widget _buildInfoItem(
    IconData icon, 
    String text, 
    Color color, {
    String? customImage,
    bool isLoading = false,
    bool hasError = false,
  }) {
    return Flexible(
      child: Column(
        children: [
          if (customImage != null)
            Container(
              width: 32,
              height: 32,
              child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : hasError
                  ? Icon(
                      Icons.refresh,
                      color: color,
                      size: 32,
                    )
                  : Image.asset(
                      customImage,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          icon,
                          color: color,
                          size: 32,
                        );
                      },
                    ),
            )
          else
            isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  hasError ? Icons.refresh : icon,
                  color: color,
                  size: 32,
                ),
          const SizedBox(height: 8),
          isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: hasError ? Colors.red : Colors.black87,
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
              if (currentTemp != null)
                Icon(
                  currentTemp! > 35 ? Icons.warning_amber : Icons.check_circle,
                  color: Colors.white,
                  size: 20,
                ),
              const SizedBox(width: 8),
              Text(
                currentTemp != null
                  ? 'Según tu temperatura actual'
                  : 'Información de clima',
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
            currentTemp != null
              ? currentTemp! > 35 
                  ? 'No es recomendable aplicar agua al cultivo ahora'
                  : 'Es buen momento para regar tu cultivo'
              : hasLocationError
                ? 'Toca el ícono de ubicación para reintentar'
                : 'Obteniendo datos meteorológicos...',
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  // [El resto de los métodos permanecen igual...]
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

  // [Resto de métodos de navegación y diálogos permanecen igual...]
  void _handleOptionTap(String action) {
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