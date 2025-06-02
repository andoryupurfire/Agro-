// lib/screens/plant_diagnosis_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/plant_id_service.dart';

class PlantDiagnosisScreen extends StatefulWidget {
  @override
  _PlantDiagnosisScreenState createState() => _PlantDiagnosisScreenState();
}

class _PlantDiagnosisScreenState extends State<PlantDiagnosisScreen> {
  File? _selectedImage;
  bool _isLoading = false;
  PlantHealthResult? _healthResult;
  String? _errorMessage;
  final PlantIDService _plantService = PlantIDService();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(
          'Doctor Cultivo',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff2E7D32),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 20),
            if (_selectedImage != null && !_isLoading) _buildAnalyzeButton(),
            if (_isLoading) _buildLoadingSection(),
            if (_errorMessage != null) _buildErrorSection(),
            if (_healthResult != null) _buildHealthResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: _selectedImage == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 60,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 10),
                Text(
                  'Selecciona una imagen de tu planta',
                  style: GoogleFonts.outfit(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: Text(
              'Cámara',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4285F4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.gallery),
            icon: const Icon(Icons.photo_library),
            label: Text(
              'Galería',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _analyzeImage,
        icon: const Icon(Icons.local_hospital),
        label: Text(
          'Analizar Salud de la Planta',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2E7D32),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff2E7D32)),
          ),
          const SizedBox(height: 15),
          Text(
            'Analizando la salud de tu planta...',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Esto puede tomar unos segundos',
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade600,
            size: 48,
          ),
          const SizedBox(height: 15),
          Text(
            'Error al analizar la imagen',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.red.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _errorMessage = null;
              });
              _analyzeImage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Reintentar',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthResults() {
    if (_healthResult == null) return Container();
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
                _healthResult!.isHealthy ? Icons.check_circle : Icons.warning,
                color: _healthResult!.isHealthy ? Colors.green : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Estado de Salud',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _healthResult!.isHealthy 
                  ? Colors.green.shade50 
                  : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _healthResult!.isHealthy 
                    ? Colors.green.shade200 
                    : Colors.orange.shade200
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _healthResult!.isHealthy ? Icons.check : Icons.info,
                  color: _healthResult!.isHealthy ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _healthResult!.isHealthy
                        ? 'Tu planta parece estar saludable'
                        : 'Se detectaron posibles problemas en tu planta',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _healthResult!.isHealthy ? Colors.green.shade700 : Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filtrar enfermedades con probabilidad mayor al 50%
          if (_healthResult!.diseases.where((disease) => disease.probability > 0.5).isNotEmpty) ...[
            const SizedBox(height: 15),
            Text(
              'Problemas detectados:',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...(_healthResult!.diseases
                .where((disease) => disease.probability > 0.5)
                .take(3)
                .map((disease) => _buildDiseaseCard(disease))
                .toList()),
          ],
        ],
      ),
    );
  }

  Widget _buildDiseaseCard(DiseaseSuggestion disease) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _translateDiseaseName(disease.name),
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
              Text(
                '${(disease.probability * 100).toInt()}%',
                style: GoogleFonts.outfit(
                  color: Colors.red.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          if (disease.description != null && disease.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _translateDescription(disease.description!).length > 150
                  ? '${_translateDescription(disease.description!).substring(0, 150)}...'
                  : _translateDescription(disease.description!),
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: Colors.red.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Función para traducir nombres de enfermedades comunes
  String _translateDiseaseName(String diseaseName) {
    final translations = {
      'leaf spot': 'Mancha foliar',
      'powdery mildew': 'Oídio',
      'blight': 'Tizón',
      'rust': 'Roya',
      'bacterial wilt': 'Marchitez bacteriana',
      'viral infection': 'Infección viral',
      'fungal infection': 'Infección por hongos',
      'aphids': 'Pulgones',
      'spider mites': 'Ácaros',
      'scale insects': 'Cochinillas',
      'nutrient deficiency': 'Deficiencia de nutrientes',
      'overwatering': 'Exceso de riego',
      'underwatering': 'Falta de riego',
      'sunburn': 'Quemadura solar',
      'root rot': 'Pudrición de raíces',
    };
    
    String translated = diseaseName.toLowerCase();
    translations.forEach((key, value) {
      translated = translated.replaceAll(key, value);
    });
    
    return translated.split(' ').map((word) => 
      word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1)
    ).join(' ');
  }

  // Función para traducir descripciones básicas
  String _translateDescription(String description) {
    final translations = {
      'leaf': 'hoja',
      'leaves': 'hojas',
      'plant': 'planta',
      'disease': 'enfermedad',
      'infection': 'infección',
      'fungal': 'por hongos',
      'bacterial': 'bacteriana',
      'viral': 'viral',
      'spots': 'manchas',
      'yellowing': 'amarillamiento',
      'wilting': 'marchitez',
      'damage': 'daño',
      'growth': 'crecimiento',
      'water': 'agua',
      'nutrients': 'nutrientes',
      'sun': 'sol',
      'light': 'luz',
      'soil': 'suelo',
      'roots': 'raíces',
    };
    
    String translated = description.toLowerCase();
    translations.forEach((key, value) {
      translated = translated.replaceAll(key, value);
    });
    
    return translated;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _healthResult = null;
          _errorMessage = null;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error al seleccionar imagen: $e');
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _healthResult = null;
    });
    
    try {
      // Solo ejecutar análisis de salud
      final healthResult = await _plantService.checkPlantHealth(_selectedImage!);
      setState(() {
        _healthResult = healthResult;
        _isLoading = false;
      });
      
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = _getErrorMessage(e.toString());
      });
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('Failed host lookup')) {
      return 'Sin conexión a internet. Verifica tu conexión y vuelve a intentar.';
    } else if (error.contains('API key')) {
      return 'Clave de API no configurada. Contacta al desarrollador.';
    } else if (error.contains('timeout')) {
      return 'La conexión tardó demasiado. Intenta de nuevo.';
    } else if (error.contains('402') || error.contains('quota')) {
      return 'Límite de uso alcanzado. Intenta más tarde.';
    } else {
      return 'Error desconocido. Intenta de nuevo.';
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}