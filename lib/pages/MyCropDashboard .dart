import 'package:flutter/material.dart';

class MyCropDashboard extends StatefulWidget {
  const MyCropDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCropDashboardState createState() => _MyCropDashboardState();
}

class _MyCropDashboardState extends State<MyCropDashboard> {
  DateTime? plantingDate;
  DateTime? germinationDate;
  DateTime? floweringDate;
  DateTime? firstFruitDate;
  DateTime? harvestDate;
  
  int daysToHarvest = 0;
  int currentDays = 0;
  String currentPhase = 'Sin plantar';
  double progressPercentage = 0.0;

  // Simulamos datos del cultivo
  Map<String, dynamic> cropData = {
    'variety': 'Tomate Cherry',
    'planted': true,
    'plantsCount': 12,
    'area': '15 m²',
    'location': 'Invernadero A',
    'irrigationSystem': 'Goteo',
    'lastWatering': DateTime.now().subtract(const Duration(days: 1)),
    'lastFertilization': DateTime.now().subtract(const Duration(days: 7)),
    'temperature': 28.2,
    'humidity': 65,
    'soilMoisture': 75,
  };

  @override
  void initState() {
    super.initState();
    // Simulamos una siembra hace 45 días
    plantingDate = DateTime.now().subtract(const Duration(days: 45));
    _calculateDates();
    _updateCurrentStatus();
  }

  void _calculateDates() {
    if (plantingDate != null) {
      germinationDate = plantingDate!.add(const Duration(days: 7));
      floweringDate = plantingDate!.add(const Duration(days: 35));
      firstFruitDate = plantingDate!.add(const Duration(days: 65));
      harvestDate = plantingDate!.add(const Duration(days: 85));
      
      currentDays = DateTime.now().difference(plantingDate!).inDays;
      daysToHarvest = harvestDate!.difference(DateTime.now()).inDays;
      
      if (daysToHarvest < 0) daysToHarvest = 0;
      
      progressPercentage = (currentDays / 85).clamp(0.0, 1.0);
    }
  }

  void _updateCurrentStatus() {
    if (currentDays >= 85) {
      currentPhase = 'Cosecha';
    } else if (currentDays >= 65) {
      currentPhase = 'Fructificación';
    } else if (currentDays >= 35) {
      currentPhase = 'Floración';
    } else if (currentDays >= 7) {
      currentPhase = 'Crecimiento Vegetativo';
    } else if (currentDays >= 0) {
      currentPhase = 'Germinación';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text(
          'Mi Cultivo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => _showCropSettings(),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con información general
            _buildHeaderCard(),
            
            // Estado actual del cultivo
            _buildCurrentStatusCard(),
            
            // Progreso del cultivo
            _buildProgressCard(),
            
            // Calendario de fases
            _buildPhaseCalendar(),
            
            // Métricas del cultivo
            _buildMetricsCards(),
            
            // Actividades recientes
            _buildRecentActivities(),
            
            // Próximas tareas
            _buildUpcomingTasks(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddActivityDialog(),
        backgroundColor: Colors.green[600],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green[600]!, Colors.green[700]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.eco, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cropData['variety'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${cropData['plantsCount']} plantas • ${cropData['area']}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildInfoChip(Icons.location_on, cropData['location']),
              const SizedBox(width: 10),
              _buildInfoChip(Icons.water_drop, cropData['irrigationSystem']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStatusCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Text(
            'Estado Actual',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: _getPhaseColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_getPhaseIcon(), color: _getPhaseColor(), size: 30),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPhase,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _getPhaseColor(),
                      ),
                    ),
                    Text(
                      'Día $currentDays desde la siembra',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    if (daysToHarvest > 0)
                      Text(
                        'Faltan $daysToHarvest días para cosechar',
                        style: TextStyle(color: Colors.orange[600], fontSize: 12),
                      )
                    else
                      Text(
                        '¡Listo para cosechar!',
                        style: TextStyle(color: Colors.green[600], fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progreso del Cultivo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                '${(progressPercentage * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: progressPercentage,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
            minHeight: 8,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Siembra',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                'Cosecha',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseCalendar() {
    final phases = [
      {
        'name': 'Germinación',
        'date': germinationDate,
        'days': '0-7 días',
        'completed': currentDays >= 7,
        'current': currentDays < 7,
        'icon': Icons.spa,
        'color': Colors.green,
      },
      {
        'name': 'Crecimiento',
        'date': plantingDate?.add(const Duration(days: 21)),
        'days': '7-35 días',
        'completed': currentDays >= 35,
        'current': currentDays >= 7 && currentDays < 35,
        'icon': Icons.park,
        'color': Colors.lightGreen,
      },
      {
        'name': 'Floración',
        'date': floweringDate,
        'days': '35-65 días',
        'completed': currentDays >= 65,
        'current': currentDays >= 35 && currentDays < 65,
        'icon': Icons.local_florist,
        'color': Colors.yellow,
      },
      {
        'name': 'Fructificación',
        'date': firstFruitDate,
        'days': '65-85 días',
        'completed': currentDays >= 85,
        'current': currentDays >= 65 && currentDays < 85,
        'icon': Icons.circle,
        'color': Colors.orange,
      },
      {
        'name': 'Cosecha',
        'date': harvestDate,
        'days': '85+ días',
        'completed': false,
        'current': currentDays >= 85,
        'icon': Icons.agriculture,
        'color': Colors.red,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Text(
            'Calendario de Fases',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          ...phases.map((phase) => _buildPhaseItem(phase)),
        ],
      ),
    );
  }

  Widget _buildPhaseItem(Map<String, dynamic> phase) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: phase['completed'] || phase['current'] 
                ? phase['color'].withOpacity(0.2) 
                : Colors.grey[100],
              shape: BoxShape.circle,
              border: Border.all(
                color: phase['completed'] || phase['current'] 
                  ? phase['color'] 
                  : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Icon(
              phase['completed'] 
                ? Icons.check 
                : phase['icon'],
              color: phase['completed'] || phase['current'] 
                ? phase['color'] 
                : Colors.grey[400],
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: phase['current'] ? phase['color'] : Colors.grey[800],
                  ),
                ),
                Text(
                  phase['days'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                if (phase['date'] != null)
                  Text(
                    '${phase['date']!.day}/${phase['date']!.month}/${phase['date']!.year}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
          if (phase['current'])
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: phase['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Actual',
                style: TextStyle(
                  color: phase['color'],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetricsCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Condiciones Actuales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Temperatura', '${cropData['temperature']}°C', Icons.thermostat, Colors.red)),
              const SizedBox(width: 10),
              Expanded(child: _buildMetricCard('Humedad', '${cropData['humidity']}%', Icons.water_drop, Colors.blue)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Humedad Suelo', '${cropData['soilMoisture']}%', Icons.grass, Colors.brown)),
              const SizedBox(width: 10),
              Expanded(child: _buildMetricCard('Plantas', '${cropData['plantsCount']}', Icons.eco, Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    final activities = [
      {
        'title': 'Riego aplicado',
        'date': cropData['lastWatering'],
        'icon': Icons.water_drop,
        'color': Colors.blue,
      },
      {
        'title': 'Fertilización realizada',
        'date': cropData['lastFertilization'],
        'icon': Icons.scatter_plot,
        'color': Colors.orange,
      },
      {
        'title': 'Poda sanitaria',
        'date': DateTime.now().subtract(const Duration(days: 14)),
        'icon': Icons.content_cut,
        'color': Colors.green,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Text(
            'Actividades Recientes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 15),
          ...activities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    final daysAgo = DateTime.now().difference(activity['date']).inDays;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(activity['icon'], color: activity['color'], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Hace $daysAgo días',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTasks() {
    final tasks = [
      {
        'title': 'Próximo riego',
        'dueDate': DateTime.now().add(const Duration(days: 1)),
        'priority': 'Alta',
        'icon': Icons.water_drop,
        'color': Colors.blue,
      },
      {
        'title': 'Aplicar fertilizante',
        'dueDate': DateTime.now().add(const Duration(days: 3)),
        'priority': 'Media',
        'icon': Icons.scatter_plot,
        'color': Colors.orange,
      },
      {
        'title': 'Inspección de plagas',
        'dueDate': DateTime.now().add(const Duration(days: 5)),
        'priority': 'Media',
        'icon': Icons.search,
        'color': Colors.red,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Text(
            'Próximas Tareas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 15),
          ...tasks.map((task) => _buildTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    final daysUntil = task['dueDate'].difference(DateTime.now()).inDays;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: const Border(
        left: BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      ),
      child: Row(
        children: [
          Icon(task['icon'], color: task['color'], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  daysUntil == 0 ? 'Hoy' : 'En $daysUntil días',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: task['priority'] == 'Alta' 
                ? Colors.red[100] 
                : Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              task['priority'],
              style: TextStyle(
                fontSize: 10,
                color: task['priority'] == 'Alta' 
                  ? Colors.red[700] 
                  : Colors.orange[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPhaseColor() {
    switch (currentPhase) {
      case 'Germinación': return Colors.green;
      case 'Crecimiento Vegetativo': return Colors.lightGreen;
      case 'Floración': return Colors.yellow[700]!;
      case 'Fructificación': return Colors.orange;
      case 'Cosecha': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getPhaseIcon() {
    switch (currentPhase) {
      case 'Germinación': return Icons.spa;
      case 'Crecimiento Vegetativo': return Icons.park;
      case 'Floración': return Icons.local_florist;
      case 'Fructificación': return Icons.circle;
      case 'Cosecha': return Icons.agriculture;
      default: return Icons.eco;
    }
  }

  void _showCropSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Configuración del Cultivo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar información del cultivo'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Cambiar fecha de siembra'),
              onTap: () => _selectPlantingDate(),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Configurar recordatorios'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _selectPlantingDate() async {
    Navigator.pop(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: plantingDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        plantingDate = picked;
        _calculateDates();
        _updateCurrentStatus();
      });
    }
  }

  void _showAddActivityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar Actividad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.water_drop, color: Colors.blue),
              title: const Text('Riego'),
              onTap: () {
                Navigator.pop(context);
                _recordActivity('Riego aplicado');
              },
            ),
            ListTile(
              leading: const Icon(Icons.scatter_plot, color: Colors.orange),
              title: const Text('Fertilización'),
              onTap: () {
                Navigator.pop(context);
                _recordActivity('Fertilización realizada');
              },
            ),
            ListTile(
              leading: const Icon(Icons.content_cut, color: Colors.green),
              title: const Text('Poda'),
              onTap: () {
                Navigator.pop(context);
                _recordActivity('Poda realizada');
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report, color: Colors.red),
              title: const Text('Control de plagas'),
              onTap: () {
                Navigator.pop(context);
                _recordActivity('Control de plagas aplicado');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _recordActivity(String activity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$activity registrado exitosamente'),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}