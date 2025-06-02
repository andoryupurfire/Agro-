// 1. Primero crea este archivo: lib/services/plant_id_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PlantIDService {
  static const String _apiKey = 'rB9YbIVsq6HMF0te1XoRGNtZtu1kMrMVLdY0nLjC73GZiSD1S7'; // Reemplaza con tu API key
  static const String _baseUrl = 'https://api.plant.id/v2/identify';
  
  Future<PlantIdentificationResult> identifyPlant(File imageFile) async {
    try {
      // Convertir imagen a base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': _apiKey,
        },
        body: jsonEncode({
          'images': [base64Image],
          'modifiers': ["crops_fast", "similar_images"],
          'plant_details': [
            "common_names",
            "url", 
            "name_authority",
            "wiki_description",
            "taxonomy"
          ]
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PlantIdentificationResult.fromJson(data);
      } else {
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al identificar planta: $e');
    }
  }
  
  Future<PlantHealthResult> checkPlantHealth(File imageFile) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      final response = await http.post(
        Uri.parse('https://api.plant.id/v2/health_assessment'),
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': _apiKey,
        },
        body: jsonEncode({
          'images': [base64Image],
          'modifiers': ["crops_fast", "similar_images"],
          'disease_details': ["common_names", "url", "description"]
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PlantHealthResult.fromJson(data);
      } else {
        throw Exception('Error en análisis de salud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al analizar salud: $e');
    }
  }
}

// Modelos de datos
class PlantIdentificationResult {
  final bool isPlant;
  final double probability;
  final List<PlantSuggestion> suggestions;
  
  PlantIdentificationResult({
    required this.isPlant,
    required this.probability,
    required this.suggestions,
  });
  
  factory PlantIdentificationResult.fromJson(Map<String, dynamic> json) {
    return PlantIdentificationResult(
      isPlant: json['is_plant'] ?? false,
      probability: (json['is_plant_probability'] ?? 0.0).toDouble(),
      suggestions: (json['suggestions'] as List? ?? [])
          .map((s) => PlantSuggestion.fromJson(s))
          .toList(),
    );
  }
}

class PlantSuggestion {
  final String id;
  final String plantName;
  final List<String> commonNames;
  final double probability;
  final String? description;
  final List<String> similarImages;
  
  PlantSuggestion({
    required this.id,
    required this.plantName,
    required this.commonNames,
    required this.probability,
    this.description,
    required this.similarImages,
  });
  
  factory PlantSuggestion.fromJson(Map<String, dynamic> json) {
    return PlantSuggestion(
      id: json['id'] ?? '',
      plantName: json['plant_name'] ?? '',
      commonNames: List<String>.from(
        json['plant_details']?['common_names'] ?? []
      ),
      probability: (json['probability'] ?? 0.0).toDouble(),
      description: json['plant_details']?['wiki_description']?['value'],
      similarImages: List<String>.from(
        json['similar_images']?.map((img) => img['url']) ?? []
      ),
    );
  }
}

class PlantHealthResult {
  final bool isHealthy;
  final double healthyProbability;
  final List<DiseaseSuggestion> diseases;
  
  PlantHealthResult({
    required this.isHealthy,
    required this.healthyProbability,
    required this.diseases,
  });
  
  factory PlantHealthResult.fromJson(Map<String, dynamic> json) {
    return PlantHealthResult(
      isHealthy: json['is_healthy'] ?? false,
      healthyProbability: (json['is_healthy_probability'] ?? 0.0).toDouble(),
      diseases: (json['suggestions'] as List? ?? [])
          .map((s) => DiseaseSuggestion.fromJson(s))
          .toList(),
    );
  }
}

class DiseaseSuggestion {
  final String id;
  final String name;
  final double probability;
  final String? description;
  final List<String> commonNames;
  
  DiseaseSuggestion({
    required this.id,
    required this.name,
    required this.probability,
    this.description,
    required this.commonNames,
  });
  
  factory DiseaseSuggestion.fromJson(Map<String, dynamic> json) {
    return DiseaseSuggestion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      probability: (json['probability'] ?? 0.0).toDouble(),
      description: json['disease_details']?['description'],
      commonNames: List<String>.from(
        json['disease_details']?['common_names'] ?? []
      ),
    );
  }
}