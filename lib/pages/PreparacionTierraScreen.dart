import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreparacionTierraScreen extends StatefulWidget {
  @override
  State<PreparacionTierraScreen> createState() =>
      _PreparacionTierraScreenState();
}

class _PreparacionTierraScreenState extends State<PreparacionTierraScreen> {
  int currentStep = 0;

  final List<Map<String, dynamic>> preparacionSteps = [
    {
      'title': 'Análisis del Suelo',
      'description': 'Evalúa las condiciones actuales de tu terreno',
      'details': [
        'pH ideal: 6.0 - 6.8 (ligeramente ácido)',
        'Profundidad mínima: 30-40 cm',
        'Buen drenaje es esencial',
        'Textura franco-arenosa preferible'
      ],
      'tips':
          'Puedes hacer una prueba casera: mezcla tierra con agua, si se forma barro pegajoso, necesitas mejorar el drenaje.',
      'icon': Icons.science,
      'color': Colors.blue.shade600,
    },
    {
      'title': 'Limpieza del Terreno',
      'description': 'Elimina malezas y residuos vegetales',
      'details': [
        'Retira piedras grandes y escombros',
        'Elimina malezas desde la raíz',
        'Remueve restos de cultivos anteriores',
        'Deja el terreno libre de obstáculos'
      ],
      'tips':
          'Las malezas compiten por nutrientes. Es mejor eliminarlas completamente antes de preparar el suelo.',
      'icon': Icons.cleaning_services,
      'color': Colors.orange.shade600,
    },
    {
      'title': 'Arado y Volteo',
      'description': 'Afloja y oxigena la tierra',
      'details': [
        'Ara a 25-30 cm de profundidad',
        'Realiza el arado cuando la tierra esté húmeda pero no embarrada',
        'Voltea completamente la tierra',
        'Deja reposar 15-20 días'
      ],
      'tips':
          'El mejor momento es después de una lluvia ligera. La tierra debe desmoronarse en tu mano, no formar barro.',
      'icon': Icons.agriculture,
      'color': Colors.brown.shade600,
    },
    {
      'title': 'Incorporación de Materia Orgánica',
      'description': 'Enriquece el suelo con nutrientes naturales',
      'details': [
        'Compost: 3-5 kg por m²',
        'Estiércol bien descompuesto: 2-3 kg por m²',
        'Humus de lombriz: 1-2 kg por m²',
        'Mezcla uniformemente con la tierra'
      ],
      'tips':
          'La materia orgánica mejora la retención de agua y aporta nutrientes de liberación lenta.',
      'icon': Icons.eco,
      'color': Colors.green.shade600,
    },
    {
      'title': 'Nivelación y Surcado',
      'description': 'Prepara la superficie para la siembra',
      'details': [
        'Nivela el terreno con rastrillo',
        'Forma surcos de 80 cm entre hileras',
        'Altura de surcos: 20-25 cm',
        'Drenaje adecuado entre surcos'
      ],
      'tips':
          'Los surcos elevados mejoran el drenaje y facilitan el mantenimiento del cultivo.',
      'icon': Icons.waves,
      'color': Colors.indigo.shade600,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(
          'Preparación de Tierra',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff2E7D32),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Header con información general
          _buildHeader(),

          // Stepper con los pasos
          Expanded(
            child: _buildStepperContent(),
          ),

          // Bottom navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff2E7D32),
            Color(0xff4CAF50),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
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
                child: const Icon(
                  Icons.agriculture,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cultivo de Tomate',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Preparación profesional del suelo',
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
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Tiempo estimado: 2-3 semanas',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff2E7D32),
          ),
        ),
        child: Stepper(
          currentStep: currentStep,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          controlsBuilder: (context, details) {
            return Row(
              children: [
                if (details.stepIndex < preparacionSteps.length - 1)
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2E7D32),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Siguiente',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                    ),
                  ),
                const SizedBox(width: 10),
                if (details.stepIndex > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(
                      'Anterior',
                      style: GoogleFonts.outfit(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            );
          },
          onStepContinue: () {
            if (currentStep < preparacionSteps.length - 1) {
              setState(() {
                currentStep++;
              });
            }
          },
          onStepCancel: () {
            if (currentStep > 0) {
              setState(() {
                currentStep--;
              });
            }
          },
          steps: preparacionSteps.map((step) {
            int index = preparacionSteps.indexOf(step);
            return Step(
              title: Text(
                step['title'],
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              content: _buildStepContent(step),
              isActive: currentStep == index,
              state: currentStep > index
                  ? StepState.complete
                  : currentStep == index
                      ? StepState.indexed
                      : StepState.disabled,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStepContent(Map<String, dynamic> step) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Descripción
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: (step['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: (step['color'] as Color).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  step['icon'],
                  color: step['color'],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    step['description'],
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Detalles
          Text(
            'Pasos a seguir:',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          ...((step['details'] as List<String>).map((detail) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: step['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      detail,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList()),

          const SizedBox(height: 15),

          // Tip
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber.shade700,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consejo útil:',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800,
                        ),
                      ),
                      Text(
                        step['tips'],
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.amber.shade800,
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
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: (currentStep + 1) / preparacionSteps.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xff2E7D32),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            '${currentStep + 1}/${preparacionSteps.length}',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: const Color(0xff2E7D32),
            ),
          ),
        ],
      ),
    );
  }
}
