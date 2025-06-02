
// 2. Crea este archivo: lib/screens/plant_diagnosis_screen.dart
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
  PlantIdentificationResult? _identificationResult;
  PlantHealthResult? _healthResult;
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
            if (_isLoading) _buildLoadingSection(),
            if (_identificationResult != null) _buildIdentificationResults(),
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
            'Analizando tu planta...',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentificationResults() {
    if (_identificationResult == null) return Container();
    
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
                Icons.eco,
                color: const Color(0xff2E7D32),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Identificación de Planta',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          
          if (_identificationResult!.suggestions.isNotEmpty)
            ...(_identificationResult!.suggestions.take(3).map((suggestion) => 
              _buildPlantSuggestionCard(suggestion)
            ).toList())
          else
            Text(
              'No se pudo identificar la planta con certeza.',
              style: GoogleFonts.outfit(color: Colors.grey.shade600),
            ),
        ],
      ),
    );
  }

  Widget _buildPlantSuggestionCard(PlantSuggestion suggestion) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  suggestion.plantName.isNotEmpty 
                      ? suggestion.plantName 
                      : 'Planta no identificada',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getProbabilityColor(suggestion.probability),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(suggestion.probability * 100).toInt()}%',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          if (suggestion.commonNames.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Nombres comunes: ${suggestion.commonNames.take(3).join(', ')}',
              style: GoogleFonts.outfit(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
          
          if (suggestion.description != null && suggestion.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              suggestion.description!.length > 150
                  ? '${suggestion.description!.substring(0, 150)}...'
                  : suggestion.description!,
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHealthResults() {
    if (_healthResult == null) return Container();
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
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
          
          if (_healthResult!.diseases.isNotEmpty) ...[
            const SizedBox(height: 15),
            Text(
              'Posibles problemas detectados:',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...(_healthResult!.diseases.take(3).map((disease) => 
              _buildDiseaseCard(disease)
            ).toList()),
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
                  disease.name,
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
              disease.description!.length > 100
                  ? '${disease.description!.substring(0, 100)}...'
                  : disease.description!,
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

  Color _getProbabilityColor(double probability) {
    if (probability >= 0.8) return Colors.green;
    if (probability >= 0.6) return Colors.orange;
    return Colors.red;
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
          _identificationResult = null;
          _healthResult = null;
        });
        
        // Analizar automáticamente la imagen
        await _analyzeImage();
      }
    } catch (e) {
      _showErrorSnackBar('Error al seleccionar imagen: $e');
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Ejecutar ambos análisis en paralelo
      final results = await Future.wait([
        _plantService.identifyPlant(_selectedImage!),
        _plantService.checkPlantHealth(_selectedImage!),
      ]);
      
      setState(() {
        _identificationResult = results[0] as PlantIdentificationResult;
        _healthResult = results[1] as PlantHealthResult;
        _isLoading = false;
      });
      
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error al analizar la imagen: $e');
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