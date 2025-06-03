// ignore: file_names
import 'package:flutter/material.dart';

class TomatoAdviceScreen extends StatefulWidget {
  const TomatoAdviceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TomatoAdviceScreenState createState() => _TomatoAdviceScreenState();
}

class _TomatoAdviceScreenState extends State<TomatoAdviceScreen> {
  int selectedCategoryIndex = 0;

  final List<AdviceCategory> categories = [
    AdviceCategory(
      title: "Siembra",
      icon: Icons.eco,
      color: Colors.green,
      advice: [
        AdviceItem(
          title: "Época de siembra",
          content:
              "En Barrancabermeja, siembra preferiblemente en épocas menos lluviosas (diciembre-marzo). La temperatura ideal es entre 20-25°C.",
          icon: Icons.calendar_today,
        ),
        AdviceItem(
          title: "Preparación de semillas",
          content:
              "Remoja las semillas 24 horas antes de sembrar. Utiliza semillas certificadas y resistentes al clima tropical.",
          icon: Icons.grain,
        ),
        AdviceItem(
          title: "Profundidad de siembra",
          content:
              "Siembra las semillas a 1-1.5 cm de profundidad en semilleros antes del trasplante.",
          icon: Icons.height,
        ),
      ],
    ),
    AdviceCategory(
      title: "Riego",
      icon: Icons.water_drop,
      color: Colors.blue,
      advice: [
        AdviceItem(
          title: "Frecuencia de riego",
          content:
              "Riega diariamente en clima seco, cada 2-3 días en época lluviosa. Mantén el suelo húmedo pero no encharcado.",
          icon: Icons.schedule,
        ),
        AdviceItem(
          title: "Momento del día",
          content:
              "Riega temprano en la mañana (6-8 AM) o al atardecer (5-6 PM) para evitar la evaporación excesiva.",
          icon: Icons.wb_sunny,
        ),
        AdviceItem(
          title: "Cantidad de agua",
          content:
              "Aproximadamente 2-3 litros por planta adulta cada 2-3 días, ajustando según las lluvias.",
          icon: Icons.local_drink,
        ),
      ],
    ),
    AdviceCategory(
      title: "Fertilización",
      icon: Icons.science,
      color: Colors.orange,
      advice: [
        AdviceItem(
          title: "Fertilización inicial",
          content:
              "Aplica compost o humus de lombriz al momento del trasplante. Mezcla 2-3 puñados por hoyo.",
          icon: Icons.compost,
        ),
        AdviceItem(
          title: "Fertilización de crecimiento",
          content:
              "Cada 15 días aplica fertilizante rico en nitrógeno durante los primeros 2 meses.",
          icon: Icons.trending_up,
        ),
        AdviceItem(
          title: "Fertilización de floración",
          content:
              "Cuando aparezcan las flores, cambia a fertilizante rico en fósforo y potasio.",
          icon: Icons.local_florist,
        ),
      ],
    ),
    AdviceCategory(
      title: "Plagas y Enfermedades",
      icon: Icons.bug_report,
      color: Colors.red,
      advice: [
        AdviceItem(
          title: "Prevención",
          content:
              "Mantén buena ventilación entre plantas. Evita el exceso de humedad en las hojas.",
          icon: Icons.shield,
        ),
        AdviceItem(
          title: "Plagas comunes",
          content:
              "Vigila pulgones, mosca blanca y gusanos. Usa jabón potásico o neem como control orgánico.",
          icon: Icons.coronavirus,
        ),
        AdviceItem(
          title: "Enfermedades frecuentes",
          content:
              "En clima húmedo, prevé el tizón tardío y la antracnosis con fungicidas preventivos orgánicos.",
          icon: Icons.local_hospital,
        ),
      ],
    ),
    AdviceCategory(
      title: "Cuidados Especiales",
      icon: Icons.favorite,
      color: Colors.purple,
      advice: [
        AdviceItem(
          title: "Poda y entutorado",
          content:
              "Coloca tutores de 1.5-2 metros. Poda los brotes laterales (chupones) semanalmente.",
          icon: Icons.content_cut,
        ),
        AdviceItem(
          title: "Mulching",
          content:
              "Cubre el suelo con paja o hojas secas para conservar humedad y controlar malezas.",
          icon: Icons.grass,
        ),
        AdviceItem(
          title: "Cosecha",
          content:
              "Los tomates están listos cuando cambian de verde a rojizo. Cosecha cada 2-3 días.",
          icon: Icons.agriculture,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('🍅', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),
            Text(
              'Consejos para Tomate',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green[800]),
      ),
      body: Column(
        children: [
          // Header con información del clima
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[400]!, Colors.green[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.wb_sunny, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Condiciones actuales: 28.1°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ideal para el crecimiento del tomate',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Categorías horizontales
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategoryIndex == index;
                final category = categories[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    width: 90,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? category.color : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (isSelected ? category.color : Colors.grey)
                                        .withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            category.icon,
                            color: isSelected ? Colors.white : category.color,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color:
                                isSelected ? category.color : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Lista de consejos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories[selectedCategoryIndex].advice.length,
              itemBuilder: (context, index) {
                final advice = categories[selectedCategoryIndex].advice[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: categories[selectedCategoryIndex]
                            .color
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        advice.icon,
                        color: categories[selectedCategoryIndex].color,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      advice.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          advice.content,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AdviceCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<AdviceItem> advice;

  AdviceCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.advice,
  });
}

class AdviceItem {
  final String title;
  final String content;
  final IconData icon;

  AdviceItem({
    required this.title,
    required this.content,
    required this.icon,
  });
}
