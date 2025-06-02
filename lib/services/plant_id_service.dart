import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PlantIDService {
  static const String _apiKey = 'rB9YbIVsq6HMF0te1XoRGNtZtu1kMrMVLdY0nLjC73GZiSD1S7';
  static const String _baseUrl = 'https://api.plant.id/v2/identify';
  
  Future<PlantIdentificationResult> identifyPlant(File imageFile) async {
    try {
      // Convertir imagen a base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      // Agregar data: prefix para base64
      String base64WithPrefix = 'data:image/jpeg;base64,$base64Image';
      
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': _apiKey,
        },
        body: jsonEncode({
          'images': [base64WithPrefix], // Usar imagen con prefix
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
      
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PlantIdentificationResult.fromJson(data);
      } else {
        print('Error Response: ${response.body}');
        throw Exception('Error en la API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception en identifyPlant: $e');
      throw Exception('Error al identificar planta: $e');
    }
  }
  
  Future<PlantHealthResult> checkPlantHealth(File imageFile) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      // Agregar data: prefix para base64
      String base64WithPrefix = 'data:image/jpeg;base64,$base64Image';
      
      final response = await http.post(
        Uri.parse('https://api.plant.id/v2/health_assessment'),
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': _apiKey,
        },
        body: jsonEncode({
          'images': [base64WithPrefix], // Usar imagen con prefix
          'modifiers': ["crops_fast", "similar_images"],
          'disease_details': ["common_names", "url", "description"]
        }),
      );
      
      print('Health Status Code: ${response.statusCode}');
      print('Health Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PlantHealthResult.fromJson(data);
      } else {
        print('Health Error Response: ${response.body}');
        throw Exception('Error en análisis de salud: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception en checkPlantHealth: $e');
      throw Exception('Error al analizar salud: $e');
    }
  }
}

// Modelos de datos mejorados con validación
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
    try {
      print('Parsing PlantIdentificationResult: $json');
      
      return PlantIdentificationResult(
        isPlant: json['is_plant'] ?? false,
        probability: _parseDouble(json['is_plant_probability']),
        suggestions: _parseSuggestions(json['suggestions']),
      );
    } catch (e) {
      print('Error parsing PlantIdentificationResult: $e');
      throw Exception('Error al procesar resultado de identificación: $e');
    }
  }
  
  static List<PlantSuggestion> _parseSuggestions(dynamic suggestions) {
    if (suggestions == null) return [];
    
    try {
      return (suggestions as List)
          .map((s) => PlantSuggestion.fromJson(s as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error parsing suggestions: $e');
      return [];
    }
  }
  
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
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
    try {
      print('Parsing PlantSuggestion: $json');
      
      return PlantSuggestion(
        id: json['id']?.toString() ?? '',
        plantName: json['plant_name']?.toString() ?? '',
        commonNames: _parseStringList(json['plant_details']?['common_names']),
        probability: PlantIdentificationResult._parseDouble(json['probability']),
        description: json['plant_details']?['wiki_description']?['value']?.toString(),
        similarImages: _parseSimilarImages(json['similar_images']),
      );
    } catch (e) {
      print('Error parsing PlantSuggestion: $e');
      throw Exception('Error al procesar sugerencia de planta: $e');
    }
  }
  
  static List<String> _parseStringList(dynamic list) {
    if (list == null) return [];
    
    try {
      return (list as List).map((item) => item.toString()).toList();
    } catch (e) {
      print('Error parsing string list: $e');
      return [];
    }
  }
  
  static List<String> _parseSimilarImages(dynamic images) {
    if (images == null) return [];
    
    try {
      return (images as List)
          .map((img) => img['url']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList();
    } catch (e) {
      print('Error parsing similar images: $e');
      return [];
    }
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
    try {
      print('Parsing PlantHealthResult: $json');
      
      return PlantHealthResult(
        isHealthy: json['is_healthy'] ?? true,
        healthyProbability: PlantIdentificationResult._parseDouble(json['is_healthy_probability']),
        diseases: _parseDiseases(json['suggestions']),
      );
    } catch (e) {
      print('Error parsing PlantHealthResult: $e');
      throw Exception('Error al procesar resultado de salud: $e');
    }
  }
  
  static List<DiseaseSuggestion> _parseDiseases(dynamic suggestions) {
    if (suggestions == null) return [];
    
    try {
      return (suggestions as List)
          .map((s) => DiseaseSuggestion.fromJson(s as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error parsing diseases: $e');
      return [];
    }
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
    try {
      print('Parsing DiseaseSuggestion: $json');
      
      return DiseaseSuggestion(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        probability: PlantIdentificationResult._parseDouble(json['probability']),
        description: json['disease_details']?['description']?.toString(),
        commonNames: PlantSuggestion._parseStringList(json['disease_details']?['common_names']),
      );
    } catch (e) {
      print('Error parsing DiseaseSuggestion: $e');
      throw Exception('Error al procesar sugerencia de enfermedad: $e');
    }
  }
}