// ignore: file_names
import 'package:flutter/material.dart';

class WaterCareScreen extends StatefulWidget {
  const WaterCareScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaterCareScreenState createState() => _WaterCareScreenState();
}

class _WaterCareScreenState extends State<WaterCareScreen> {
  int selectedTabIndex = 0;

  final List<WaterTip> generalTips = [
    WaterTip(
      title: "Momento ideal para regar",
      content:
          "Riega temprano en la mañana (6-8 AM) o al atardecer (5-6 PM). Evita las horas de mayor calor para reducir la evaporación.",
      icon: Icons.schedule,
      color: Colors.blue,
    ),
    WaterTip(
      title: "Calidad del agua",
      content:
          "Usa agua limpia, preferiblemente de lluvia recolectada o agua reposada. Evita agua con cloro excesivo o muy salada.",
      icon: Icons.water_drop,
      color: Colors.cyan,
    ),
    WaterTip(
      title: "Técnica de riego profundo",
      content:
          "Riega menos frecuente pero más profundo. Esto estimula el crecimiento de raíces fuertes y resistentes a la sequía.",
      icon: Icons.trending_down,
      color: Colors.indigo,
    ),
    WaterTip(
      title: "Conservación del agua",
      content:
          "Usa mulching (cobertura) para reducir la evaporación hasta en un 50%. Paja, hojas secas o compost funcionan bien.",
      icon: Icons.eco,
      color: Colors.green,
    ),
    WaterTip(
      title: "Sistema de riego por goteo",
      content:
          "Considera instalar riego por goteo casero con botellas plásticas perforadas para un riego constante y eficiente.",
      icon: Icons.opacity,
      color: Colors.lightBlue,
    ),
  ];

  final List<WaterTip> tomatoTips = [
    WaterTip(
      title: "Frecuencia para tomate",
      content:
          "En Barrancabermeja: diario en época seca, cada 2-3 días en época lluviosa. Ajusta según la humedad del suelo.",
      icon: Icons.calendar_today,
      color: Colors.red,
    ),
    WaterTip(
      title: "Cantidad por planta",
      content:
          "2-3 litros por planta adulta cada 2-3 días. Plantas jóvenes necesitan menos agua pero más frecuente.",
      icon: Icons.local_drink,
      color: Colors.orange,
    ),
    WaterTip(
      title: "Riego en la base",
      content:
          "Riega directamente en la base del tomate, evitando mojar las hojas para prevenir enfermedades fúngicas.",
      icon: Icons.grass,
      color: Colors.brown,
    ),
    WaterTip(
      title: "Indicadores de sed",
      content:
          "Hojas ligeramente caídas al mediodía es normal. Si persisten en la tarde/noche, necesita agua urgente.",
      icon: Icons.visibility,
      color: Colors.amber,
    ),
    WaterTip(
      title: "Etapas críticas",
      content:
          "Aumenta el riego durante floración y formación de frutos. Es cuando más agua necesita la planta de tomate.",
      icon: Icons.local_florist,
      color: Colors.pink,
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
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.water_drop, color: Colors.blue[600], size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Cuidado del Agua',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue[800]),
      ),
      body: Column(
        children: [
          // Header con información del clima
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.thermostat,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Temperatura: 28.2°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Alta evaporación - Aumenta la frecuencia de riego',
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

          // Tabs de navegación
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: selectedTabIndex == 0
                            ? Colors.blue[50]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.public,
                            color: selectedTabIndex == 0
                                ? Colors.blue[600]
                                : Colors.grey[400],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'General',
                            style: TextStyle(
                              fontWeight: selectedTabIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selectedTabIndex == 0
                                  ? Colors.blue[600]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: selectedTabIndex == 1
                            ? Colors.red[50]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🍅', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 8),
                          Text(
                            'Tomate',
                            style: TextStyle(
                              fontWeight: selectedTabIndex == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selectedTabIndex == 1
                                  ? Colors.red[600]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lista de consejos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: selectedTabIndex == 0
                  ? generalTips.length
                  : tomatoTips.length,
              itemBuilder: (context, index) {
                final tip = selectedTabIndex == 0
                    ? generalTips[index]
                    : tomatoTips[index];

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
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: tip.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            tip.icon,
                            color: tip.color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tip.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                tip.content,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer con recordatorio
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[400]!, Colors.blue[400]!],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Recuerda: Un riego adecuado es clave para cultivos saludables',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaterTip {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  WaterTip({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });
}
