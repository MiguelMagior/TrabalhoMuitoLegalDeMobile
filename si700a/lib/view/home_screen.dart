import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'training_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // Mesmo fundo do ProfileScreen
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- CARD 1: TREINO DE HOJE ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'TREINO DE HOJE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'TÍTULO DO PLANO',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),

                
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TrainingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E600),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300, width: 3),
                          
                        ),
                        child: const Center(
                          child: Text(
                            'INICIAR',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Ofensiva de ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'quantidade',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' dias',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- CARD 2: RESUMO SEMANAL ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'RESUMO SEMANAL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dias da semana
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _DayCircle(day: 'Dom', isCompleted: false, isCurrent: false),
                        _DayCircle(day: 'Seg', isCompleted: true, isCurrent: false),
                        _DayCircle(day: 'Ter', isCompleted: true, isCurrent: false),
                        _DayCircle(day: 'Qua', isCompleted: true, isCurrent: false),
                        _DayCircle(day: 'Qui', isCompleted: true, isCurrent: false),
                        _DayCircle(day: 'Sex', isCompleted: true, isCurrent: false),
                        _DayCircle(day: 'Sab', isCompleted: false, isCurrent: true),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 16),

                    // Estatísticas idênticas às do ProfileScreen
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _HomeStatItem(
                          title: 'QUANTIDADE',
                          value: 'quantidade treinos',
                        ),
                        _HomeStatItem(
                          title: 'TEMPO',
                          value: 'quantidade horas',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- CARD 3: GRÁFICO DE CATEGORIAS ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: CustomPaint(
                          painter: DonutChartPainter(
                            flexibilidade: 2,
                            cardio: 5,
                            forca: 4,
                          ),
                        ),
                      ),

                      const Positioned(
                        left: 8,
                        child: Text(
                          'Força(Quant)',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Positioned(
                        right: 8,
                        child: Text(
                          'Flexibilidade(Quant)',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Positioned(
                        bottom: 0,
                        child: Text(
                          'Cardio(Quant)',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-widget de estatística no estilo da ProfileScreen
class _HomeStatItem extends StatelessWidget {
  final String title;
  final String value;

  const _HomeStatItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DayCircle extends StatelessWidget {
  final String day;
  final bool isCompleted;
  final bool isCurrent;

  const _DayCircle({
    required this.day,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    Color fillColor;
    Border? border;

    if (isCompleted) {
      fillColor = const Color(0xFF00E600);
      border = null;
    } else if (isCurrent) {
      fillColor = Colors.transparent;
      border = Border.all(color: Colors.grey.shade600, width: 2.5);
    } else {
      fillColor = Colors.grey.shade400;
      border = null;
    }

    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: fillColor,
            shape: BoxShape.circle,
            border: border,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final int flexibilidade;
  final int cardio;
  final int forca;

  DonutChartPainter({
    required this.flexibilidade,
    required this.cardio,
    required this.forca,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10;
    const strokeWidth = 18.0;

    final total = flexibilidade + cardio + forca;

    if (total == 0) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -math.pi / 2;

    if (flexibilidade > 0) {
      final flexSweep = (flexibilidade / total) * 2 * math.pi;
      paint.color = Colors.deepPurple;
      canvas.drawArc(rect, startAngle, flexSweep, false, paint);
      startAngle += flexSweep;
    }

    if (cardio > 0) {
      final cardioSweep = (cardio / total) * 2 * math.pi;
      paint.color = Colors.blue;
      canvas.drawArc(rect, startAngle, cardioSweep, false, paint);
      startAngle += cardioSweep;
    }

    if (forca > 0) {
      final forcaSweep = (forca / total) * 2 * math.pi;
      paint.color = Colors.deepOrange;
      canvas.drawArc(rect, startAngle, forcaSweep, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return oldDelegate.flexibilidade != flexibilidade ||
        oldDelegate.cardio != cardio ||
        oldDelegate.forca != forca;
  }
}