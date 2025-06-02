import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SiembraScreen extends StatefulWidget {
  @override
  State<SiembraScreen> createState() => _SiembraScreenState();
}

class _SiembraScreenState extends State<SiembraScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(
          'Siembra de Tomate',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff2E7D32),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Semillero'),
            Tab(text: 'Trasplante'),
            Tab(text: 'Calendario'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSemilleroTab(),
          _buildTrasplanteTab(),
          _buildCalendarioTab(),
        ],
      ),
    );
  }

  Widget _buildSemilleroTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del semillero
          _buildSectionHeader(
            'Preparación del Semillero',
            'Primeros 30-45 días del cultivo',
            Icons.eco,
            Colors.green.shade600,
          ),

          const SizedBox(height: 20),

          // Materiales necesarios
          _buildMaterialesCard(),

          const SizedBox(height: 20),

          // Pasos del semillero
          _buildPasosSemillero(),

          const SizedBox(height: 20),

          // Cuidados del semillero
          _buildCuidadosSemillero(),
        ],
      ),
    );
  }

  Widget _buildTrasplanteTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del trasplante
          _buildSectionHeader(
            'Trasplante al Terreno Definitivo',
            'Cuando las plántulas tienen 15-20 cm',
            Icons.agriculture,
            Colors.brown.shade600,
          ),

          const SizedBox(height: 20),

          // Cuándo trasplantar
          _buildCuandoTrasplantar(),

          const SizedBox(height: 20),

          // Pasos del trasplante
          _buildPasosTrasplante(),

          const SizedBox(height: 20),

          // Cuidados post-trasplante
          _buildCuidadosPostTrasplante(),
        ],
      ),
    );
  }

  Widget _buildCalendarioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del calendario
          _buildSectionHeader(
            'Calendario de Siembra',
            'Planifica tu cultivo durante el año',
            Icons.calendar_today,
            Colors.blue.shade600,
          ),

          const SizedBox(height: 20),

          // Épocas de siembra
          _buildEpocasSiembra(),

          const SizedBox(height: 20),

          // Timeline del cultivo
          _buildTimelineCultivo(),

          const SizedBox(height: 20),

          // Factores climáticos
          _buildFactoresClimaticos(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
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
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialesCard() {
    final materiales = [
      {'item': 'Semillas de tomate certificadas', 'cantidad': '2-3 g por m²'},
      {
        'item': 'Sustrato (turba + perlita + vermiculita)',
        'cantidad': '1 parte c/u'
      },
      {'item': 'Bandejas de germinación', 'cantidad': '128-200 alvéolos'},
      {'item': 'Regadera con rociador fino', 'cantidad': '1 unidad'},
      {
        'item': 'Plástico transparente o invernadero',
        'cantidad': 'Para cobertura'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
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
              Icon(Icons.shopping_cart,
                  color: Colors.orange.shade600, size: 24),
              const SizedBox(width: 10),
              Text(
                'Materiales Necesarios',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...materiales.map((material) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          material['item']!,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          material['cantidad']!,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPasosSemillero() {
    final pasos = [
      {
        'titulo': 'Preparar el sustrato',
        'descripcion':
            'Mezcla turba, perlita y vermiculita en partes iguales. El sustrato debe estar húmedo pero no encharcado.',
        'icon': Icons.grass,
        'color': Colors.brown.shade600,
      },
      {
        'titulo': 'Llenar las bandejas',
        'descripcion':
            'Llena los alvéolos dejando 1 cm libre en la parte superior. Presiona ligeramente para compactar.',
        'icon': Icons.view_module,
        'color': Colors.grey.shade600,
      },
      {
        'titulo': 'Sembrar las semillas',
        'descripcion':
            'Coloca 1-2 semillas por alvéolo a 0.5 cm de profundidad. Cubre con una fina capa de sustrato.',
        'icon': Icons.eco,
        'color': Colors.green.shade600,
      },
      {
        'titulo': 'Riego inicial',
        'descripcion':
            'Riega suavemente con rociador fino hasta que el sustrato esté uniformemente húmedo.',
        'icon': Icons.water_drop,
        'color': Colors.blue.shade600,
      },
      {
        'titulo': 'Cobertura y ubicación',
        'descripcion':
            'Cubre con plástico transparente y coloca en lugar cálido (20-25°C) con luz indirecta.',
        'icon': Icons.wb_sunny,
        'color': Colors.orange.shade600,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pasos para el Semillero',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        ...pasos.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> paso = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: (paso['color'] as Color).withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (paso['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: paso['color'],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paso['titulo'],
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        paso['descripcion'],
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCuidadosSemillero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.health_and_safety,
                  color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 10),
              Text(
                'Cuidados del Semillero',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildCuidadoItem(
              'Temperatura', '20-25°C durante el día, 15-18°C en la noche'),
          _buildCuidadoItem(
              'Humedad', 'Mantener sustrato húmedo pero sin encharcamiento'),
          _buildCuidadoItem('Luz',
              'Luz indirecta hasta la germinación, luego luz directa gradual'),
          _buildCuidadoItem('Ventilación',
              'Retirar plástico gradualmente después de germinación'),
          _buildCuidadoItem('Riego', 'Pulverización suave 1-2 veces al día'),
        ],
      ),
    );
  }

  Widget _buildCuidadoItem(String titulo, String descripcion) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
                Text(
                  descripcion,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCuandoTrasplantar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: Colors.amber.shade600, size: 24),
              const SizedBox(width: 10),
              Text(
                '¿Cuándo Trasplantar?',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildIndicadorTrasplante(
              'Altura de la plántula', '15-20 cm de altura'),
          _buildIndicadorTrasplante(
              'Hojas verdaderas', '4-6 hojas verdaderas desarrolladas'),
          _buildIndicadorTrasplante('Edad', '30-45 días desde la siembra'),
          _buildIndicadorTrasplante(
              'Sistema radicular', 'Raíces visibles en el fondo del alvéolo'),
          _buildIndicadorTrasplante(
              'Condiciones climáticas', 'Sin riesgo de heladas'),
        ],
      ),
    );
  }

  Widget _buildIndicadorTrasplante(String titulo, String descripcion) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade800,
                  ),
                ),
                Text(
                  descripcion,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasosTrasplante() {
    final pasos = [
      {
        'titulo': 'Preparar el terreno',
        'descripcion':
            'Ara el suelo a 30 cm de profundidad y añade compost o materia orgánica.',
        'color': Colors.brown.shade600,
      },
      {
        'titulo': 'Hacer los hoyos',
        'descripcion':
            'Excava hoyos de 15x15 cm, separados 60 cm entre plantas y 80 cm entre hileras.',
        'color': Colors.grey.shade600,
      },
      {
        'titulo': 'Regar antes del trasplante',
        'descripcion':
            'Riega las plántulas 2 horas antes para facilitar la extracción sin dañar raíces.',
        'color': Colors.blue.shade600,
      },
      {
        'titulo': 'Extraer con cuidado',
        'descripcion':
            'Retira la plántula presionando el fondo del alvéolo, manteniendo el cepellón intacto.',
        'color': Colors.orange.shade600,
      },
      {
        'titulo': 'Plantar y compactar',
        'descripcion':
            'Coloca la plántula al mismo nivel que tenía en el semillero y compacta suavemente.',
        'color': Colors.green.shade600,
      },
      {
        'titulo': 'Riego de establecimiento',
        'descripcion':
            'Riega abundantemente alrededor de la planta para eliminar bolsas de aire.',
        'color': Colors.cyan.shade600,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pasos del Trasplante',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        ...pasos.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> paso = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: (paso['color'] as Color).withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (paso['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: paso['color'],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paso['titulo'],
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        paso['descripcion'],
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCuidadosPostTrasplante() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_florist, color: Colors.green.shade600, size: 24),
              const SizedBox(width: 10),
              Text(
                'Cuidados Post-Trasplante',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildCuidadoPostItem('Primeros 7 días',
              'Sombrear las plantas durante las horas más calurosas'),
          _buildCuidadoPostItem('Riego',
              'Regar diariamente sin encharcar, preferiblemente temprano en la mañana'),
          _buildCuidadoPostItem(
              'Mulching', 'Aplicar mulch orgánico alrededor de las plantas'),
          _buildCuidadoPostItem(
              'Tutoreo', 'Instalar tutores a los 15 días del trasplante'),
          _buildCuidadoPostItem(
              'Fertilización', 'Aplicar fertilizante balanceado a los 10 días'),
        ],
      ),
    );
  }

  Widget _buildCuidadoPostItem(String titulo, String descripcion) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
                Text(
                  descripcion,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpocasSiembra() {
    final epocas = [
      {
        'temporada': 'Época Seca (Diciembre - Abril)',
        'descripcion':
            'Ideal para siembra en regiones cálidas. Menor incidencia de enfermedades.',
        'ventajas': [
          'Menos enfermedades fúngicas',
          'Mayor control del riego',
          'Mejor calidad de frutos'
        ],
        'color': Colors.orange.shade600,
        'icon': Icons.wb_sunny,
      },
      {
        'temporada': 'Época Lluviosa (Abril - Noviembre)',
        'descripcion':
            'Requiere mayor cuidado sanitario. Necesario buen drenaje.',
        'ventajas': [
          'Menor necesidad de riego',
          'Crecimiento más rápido',
          'Menor estrés hídrico'
        ],
        'color': Colors.blue.shade600,
        'icon': Icons.cloud,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Épocas de Siembra',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        ...epocas.map((epoca) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: (epoca['color'] as Color).withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (epoca['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        epoca['icon'] as IconData,
                        color: epoca['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        epoca['temporada'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  epoca['descripcion'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Ventajas:',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ...(epoca['ventajas'] as List<String>).map((ventaja) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: epoca['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            ventaja,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTimelineCultivo() {
    final timeline = [
      {
        'fase': 'Semillero',
        'duracion': '30-45 días',
        'actividades': 'Germinación y crecimiento inicial',
        'color': Colors.green.shade600
      },
      {
        'fase': 'Trasplante',
        'duracion': '1 semana',
        'actividades': 'Establecimiento en campo definitivo',
        'color': Colors.brown.shade600
      },
      {
        'fase': 'Crecimiento',
        'duracion': '30-40 días',
        'actividades': 'Desarrollo vegetativo y formación de estructura',
        'color': Colors.blue.shade600
      },
      {
        'fase': 'Floración',
        'duracion': '20-30 días',
        'actividades': 'Aparición de flores y polinización',
        'color': Colors.yellow.shade600
      },
      {
        'fase': 'Fructificación',
        'duracion': '45-60 días',
        'actividades': 'Formación y maduración de frutos',
        'color': Colors.red.shade600
      },
      {
        'fase': 'Cosecha',
        'duracion': '60-90 días',
        'actividades': 'Recolección escalonada de frutos maduros',
        'color': Colors.orange.shade600
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timeline del Cultivo',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: timeline.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> fase = entry.value;
              bool isLast = index == timeline.length - 1;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: fase['color'],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.grey.shade300,
                            ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fase['fase'],
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              fase['duracion'],
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: fase['color'],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              fase['actividades'],
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isLast) const SizedBox(height: 20),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFactoresClimaticos() {
    final factores = [
      {
        'factor': 'Temperatura',
        'optimo': '18-25°C',
        'descripcion':
            'Temperaturas muy altas (>35°C) o muy bajas (<10°C) afectan la producción',
        'icon': Icons.thermostat,
      },
      {
        'factor': 'Humedad Relativa',
        'optimo': '60-70%',
        'descripcion':
            'Humedad muy alta favorece enfermedades, muy baja causa estrés',
        'icon': Icons.water_drop,
      },
      {
        'factor': 'Precipitación',
        'optimo': '600-800 mm/año',
        'descripcion': 'Distribuida uniformemente durante el ciclo del cultivo',
        'icon': Icons.cloud,
      },
      {
        'factor': 'Luminosidad',
        'optimo': '8-10 horas/día',
        'descripcion':
            'Luz solar directa es esencial para buen desarrollo y fructificación',
        'icon': Icons.wb_sunny,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Factores Climáticos',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        ...factores.map((factor) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    factor['icon'] as IconData,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            factor['factor'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              factor['optimo'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        factor['descripcion'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        // Consejo adicional
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade600, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consejo Importante',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'En Barrancabermeja, la mejor época para sembrar tomate es entre diciembre y febrero, aprovechando la época seca. Considera el uso de malla sombra durante los meses más calurosos.',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
