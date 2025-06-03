import 'package:flutter/material.dart';

class TomatoPestPreventionScreen extends StatefulWidget {
  const TomatoPestPreventionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TomatoPestPreventionScreenState createState() => _TomatoPestPreventionScreenState();
}

class _TomatoPestPreventionScreenState extends State<TomatoPestPreventionScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text(
          'Prevención de Plagas - Tomates',
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
            // Header con información del cultivo
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green[600]!, Colors.green[700]!],
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
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.bug_report, color: Colors.red[600], size: 30),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estado de Prevención',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Activo - Monitoreo diario recomendado',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green[600],
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
            
            // Tabs de navegación
            Container(
              margin: const EdgeInsets.all(20),
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
                  _buildTab('Plagas Comunes', 0),
                  _buildTab('Prevención', 1),
                  _buildTab('Tratamientos', 2),
                ],
              ),
            ),

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

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green[600] : Colors.transparent,
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
        return _buildCommonPests();
      case 1:
        return _buildPrevention();
      case 2:
        return _buildTreatments();
      default:
        return Container();
    }
  }

  Widget _buildCommonPests() {
    final pests = [
      {
        'name': 'Gusano del Fruto (Heliothis)',
        'description': 'Larvas que perforan y dañan los frutos',
        'symptoms': 'Agujeros en frutos, excremento en interior',
        'icon': Icons.coronavirus,
        'color': Colors.red,
      },
      {
        'name': 'Mosca Blanca',
        'description': 'Insectos que chupan savia y transmiten virus',
        'symptoms': 'Hojas amarillas, insectos blancos volando',
        'icon': Icons.flutter_dash,
        'color': Colors.orange,
      },
      {
        'name': 'Pulgón',
        'description': 'Pequeños insectos verdes o negros',
        'symptoms': 'Hojas curvadas, crecimiento retardado',
        'icon': Icons.pest_control,
        'color': Colors.green,
      },
      {
        'name': 'Trips',
        'description': 'Insectos diminutos que causan daño foliar',
        'symptoms': 'Manchas plateadas en hojas, deformación',
        'icon': Icons.bug_report,
        'color': Colors.purple,
      },
    ];

    return Column(
      children: pests.map((pest) => _buildPestCard(pest)).toList(),
    );
  }

  Widget _buildPestCard(Map<String, dynamic> pest) {
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
            color: pest['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(pest['icon'], color: pest['color'], size: 24),
        ),
        title: Text(
          pest['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          pest['description'],
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Síntomas:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
                const SizedBox(height: 5),
                Text(
                  pest['symptoms'],
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrevention() {
    final preventionMethods = [
      {
        'title': 'Monitoreo Regular',
        'description': 'Inspecciona las plantas diariamente',
        'icon': Icons.search,
        'steps': [
          'Revisa el envés de las hojas',
          'Observa cambios en color o textura',
          'Busca insectos o larvas',
          'Documenta cualquier anomalía'
        ]
      },
      {
        'title': 'Control Biológico',
        'description': 'Usa enemigos naturales de las plagas',
        'icon': Icons.eco,
        'steps': [
          'Introduce mariquitas para pulgones',
          'Usa Trichogramma para gusanos',
          'Mantén plantas refugio',
          'Evita pesticidas químicos'
        ]
      },
      {
        'title': 'Manejo Cultural',
        'description': 'Prácticas agrícolas preventivas',
        'icon': Icons.agriculture,
        'steps': [
          'Rotación de cultivos',
          'Eliminación de malezas',
          'Poda sanitaria',
          'Riego por goteo'
        ]
      },
    ];

    return Column(
      children: preventionMethods.map((method) => _buildPreventionCard(method)).toList(),
    );
  }

  Widget _buildPreventionCard(Map<String, dynamic> method) {
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
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(method['icon'], color: Colors.green[600], size: 24),
        ),
        title: Text(
          method['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          method['description'],
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pasos a seguir:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
                const SizedBox(height: 10),
                ...method['steps'].map<Widget>((step) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6, right: 10),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          step,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatments() {
    final treatments = [
      {
        'name': 'Aceite de Neem',
        'type': 'Orgánico',
        'effectiveness': 'Alta',
        'target': 'Pulgones, Mosca Blanca',
        'application': 'Aspersión foliar cada 7-10 días',
        'color': Colors.green,
      },
      {
        'name': 'Jabón Potásico',
        'type': 'Orgánico',
        'effectiveness': 'Media',
        'target': 'Insectos de cuerpo blando',
        'application': 'Aspersión en horas frescas',
        'color': Colors.blue,
      },
      {
        'name': 'Bacillus thuringiensis',
        'type': 'Biológico',
        'effectiveness': 'Alta',
        'target': 'Gusanos y larvas',
        'application': 'Aplicar al atardecer',
        'color': Colors.purple,
      },
      {
        'name': 'Trampas Cromáticas',
        'type': 'Físico',
        'effectiveness': 'Media',
        'target': 'Mosca Blanca, Trips',
        'application': 'Instalar a altura de planta',
        'color': Colors.orange,
      },
    ];

    return Column(
      children: [
        ...treatments.map((treatment) => _buildTreatmentCard(treatment)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, color: Colors.amber[700]),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Siempre lee las etiquetas y sigue las dosis recomendadas. Consulta con un agrónomo para casos severos.',
                  style: TextStyle(color: Colors.amber[800], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentCard(Map<String, dynamic> treatment) {
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: treatment['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.healing, color: treatment['color'], size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      treatment['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Tipo: ${treatment['type']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: treatment['effectiveness'] == 'Alta' ? Colors.green[100] : Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  treatment['effectiveness'],
                  style: TextStyle(
                    color: treatment['effectiveness'] == 'Alta' ? Colors.green[700] : Colors.orange[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildInfoRow('Objetivo:', treatment['target']),
          SizedBox(height: 6),
          _buildInfoRow('Aplicación:', treatment['application']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}