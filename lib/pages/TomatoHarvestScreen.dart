import 'package:flutter/material.dart';

class TomatoHarvestScreen extends StatefulWidget {
  const TomatoHarvestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TomatoHarvestScreenState createState() => _TomatoHarvestScreenState();
}

class _TomatoHarvestScreenState extends State<TomatoHarvestScreen> {
  int selectedTab = 0;
  bool isHarvestTime = true; // Simulando que es tiempo de cosecha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: const Text(
          'Cosecha - Tomates',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con estado de cosecha
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange[600]!, Colors.orange[700]!],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isHarvestTime ? Colors.green[50] : Colors.orange[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              isHarvestTime ? Icons.check_circle : Icons.schedule,
                              color: isHarvestTime ? Colors.green[600] : Colors.orange[600],
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estado de Cosecha',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  isHarvestTime 
                                    ? '¡Listo para cosechar!'
                                    : 'Esperando maduración',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isHarvestTime ? Colors.green[600] : Colors.orange[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Indicadores de madurez
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
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
                  Text(
                    'Indicadores de Madurez',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildMaturityIndicator('Color', '85%', Colors.red, Icons.palette),
                      const SizedBox(width: 15),
                      _buildMaturityIndicator('Firmeza', '90%', Colors.green, Icons.touch_app),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildMaturityIndicator('Tamaño', '95%', Colors.blue, Icons.straighten),
                      const SizedBox(width: 15),
                      _buildMaturityIndicator('Aroma', '80%', Colors.purple, Icons.local_florist),
                    ],
                  ),
                ],
              ),
            ),
            
            // Tabs de navegación
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
              child: Row(
                children: [
                  _buildTab('Cuándo Cosechar', 0),
                  _buildTab('Cómo Cosechar', 1),
                  _buildTab('Post-Cosecha', 2),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Contenido según tab seleccionado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaturityIndicator(String label, String percentage, Color color, IconData icon) {
    double progress = double.parse(percentage.replaceAll('%', '')) / 100;
    
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            const SizedBox(height: 4),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange[600] : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildWhenToHarvest();
      case 1:
        return _buildHowToHarvest();
      case 2:
        return _buildPostHarvest();
      default:
        return Container();
    }
  }

  Widget _buildWhenToHarvest() {
    final maturityStages = [
      {
        'stage': 'Verde Maduro',
        'days': '70-80 días',
        'description': 'Tamaño completo, color verde claro',
        'harvest': false,
        'color': Colors.green,
        'uses': 'Fritos verdes, conservas'
      },
      {
        'stage': 'Rompiente',
        'days': '75-85 días',
        'description': 'Primeros signos de color rosado',
        'harvest': true,
        'color': Colors.pink,
        'uses': 'Maduración en casa'
      },
      {
        'stage': 'Rosado',
        'days': '80-90 días',
        'description': '25-50% de color rosado/rojo',
        'harvest': true,
        'color': Colors.red[300]!,
        'uses': 'Consumo fresco'
      },
      {
        'stage': 'Rojo Claro',
        'days': '85-95 días',
        'description': '75% de color rojo',
        'harvest': true,
        'color': Colors.red[500]!,
        'uses': 'Ideal para venta'
      },
      {
        'stage': 'Rojo Maduro',
        'days': '90-100 días',
        'description': 'Color rojo intenso completo',
        'harvest': true,
        'color': Colors.red[700]!,
        'uses': 'Consumo inmediato, salsas'
      },
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue[600]),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Los tomates pueden cosecharse en diferentes estados según su uso final.',
                  style: TextStyle(color: Colors.blue[800], fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...maturityStages.map((stage) => _buildMaturityStageCard(stage)).toList(),
      ],
    );
  }

  Widget _buildMaturityStageCard(Map<String, dynamic> stage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
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
        border: stage['harvest'] 
          ? Border.all(color: Colors.green[300]!, width: 2)
          : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: stage['color'],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stage['stage'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      stage['days'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (stage['harvest'])
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Cosechar',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            stage['description'],
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Usos: ${stage['uses']}',
            style: TextStyle(
              color: Colors.grey[600], 
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToHarvest() {
    final harvestSteps = [
      {
        'title': 'Preparación',
        'icon': Icons.build,
        'items': [
          'Cosechar en horas frescas (temprano en la mañana)',
          'Usar tijeras o cuchillo limpio y afilado',
          'Tener contenedores limpios y secos',
          'Evitar cosechar con plantas húmedas'
        ]
      },
      {
        'title': 'Técnica de Corte',
        'icon': Icons.content_cut,
        'items': [
          'Cortar el pedúnculo 1 cm arriba del fruto',
          'No tirar del tomate directamente',
          'Corte limpio para evitar desgarros',
          'Dejar el cáliz (corona verde) en el fruto'
        ]
      },
      {
        'title': 'Selección',
        'icon': Icons.check_circle,
        'items': [
          'Elegir frutos firmes y sin grietas',
          'Descartar tomates con manchas o golpes',
          'Separar por estado de madurez',
          'Cosechar regularmente (cada 2-3 días)'
        ]
      },
      {
        'title': 'Manejo',
        'icon': Icons.pan_tool,
        'items': [
          'Manipular con cuidado para evitar magulladuras',
          'No apilar demasiados tomates',
          'Transportar en cajas poco profundas',
          'Proteger del sol directo después del corte'
        ]
      },
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.green[600]),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Una cosecha adecuada mejora la calidad y prolonga la vida útil del tomate.',
                  style: TextStyle(color: Colors.green[800], fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...harvestSteps.map((step) => _buildHarvestStepCard(step)),
      ],
    );
  }

  Widget _buildHarvestStepCard(Map<String, dynamic> step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(step['icon'], color: Colors.orange[600], size: 24),
        ),
        title: Text(
          step['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: step['items'].map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.orange[600],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostHarvest() {
    return Column(
      children: [
        _buildStorageCard(),
        const SizedBox(height: 15),
        _buildRipeningCard(),
        const SizedBox(height: 15),
        _buildQualityCard(),
        const SizedBox(height: 15),
        _buildUsesCard(),
      ],
    );
  }

  Widget _buildStorageCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.storage, color: Colors.blue[600], size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Almacenamiento',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildStorageOption('Tomates Verdes', '15-20°C', '85-90% HR', '2-4 semanas'),
          const Divider(),
          _buildStorageOption('Tomates Maduros', '10-12°C', '85-90% HR', '1-2 semanas'),
          const Divider(),
          _buildStorageOption('Consumo Inmediato', 'Temperatura ambiente', 'Lugar fresco', '3-5 días'),
        ],
      ),
    );
  }

  Widget _buildStorageOption(String type, String temp, String humidity, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.thermostat, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(temp, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              const SizedBox(width: 15),
              Icon(Icons.water_drop, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(humidity, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(duration, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRipeningCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.wb_sunny, color: Colors.yellow[700], size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Maduración Post-Cosecha',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Para acelerar la maduración:',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          _buildTip('Coloca los tomates con una manzana madura'),
          _buildTip('Usa una bolsa de papel perforada'),
          _buildTip('Mantén a temperatura ambiente (18-24°C)'),
          _buildTip('Revisa diariamente el progreso'),
          const SizedBox(height: 10),
          Text(
            'Para retrasar la maduración:',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          _buildTip('Separa los tomates maduros de los verdes'),
          _buildTip('Almacena en lugar fresco y ventilado'),
          _buildTip('Evita la luz solar directa'),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.grade, color: Colors.purple[600], size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Control de Calidad',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildQualityMetric('Calibre', 'Mediano', Colors.green),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQualityMetric('Firmeza', 'Óptima', Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildQualityMetric('Color', 'Uniforme', Colors.red),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQualityMetric('Defectos', 'Mínimos', Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQualityMetric(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsesCard() {
    final uses = [
      {'use': 'Consumo Fresco', 'stage': 'Rojo maduro', 'icon': Icons.restaurant},
      {'use': 'Salsas y Conservas', 'stage': 'Muy maduro', 'icon': Icons.local_dining},
      {'use': 'Ensaladas', 'stage': 'Rojo claro', 'icon': Icons.eco},
      {'use': 'Cocción', 'stage': 'Rosado-Rojo', 'icon': Icons.soup_kitchen},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.restaurant_menu, color: Colors.teal[600], size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Usos Recomendados',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...uses.map((use) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(use['icon'] as IconData, color: Colors.teal[600], size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        use['use'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Ideal: ${use['stage']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}