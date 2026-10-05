import 'package:flutter/material.dart';
import '../model/workout.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  DateTime? _selectedDate;

  // Lista de exemplo
  final List<Workout> _allHistory = [
    Workout(
      date: DateTime(2026, 8, 30),
      title: 'Descanso',
      isCompleted: false,
      isRest: true,
    ),
    Workout(
      date: DateTime(2026, 8, 31),
      title: 'Força - Inferior',
      isCompleted: true,
    ),
    Workout(
      date: DateTime(2026, 9, 1),
      title: 'Força - Superior',
      isCompleted: true,
    ),
    Workout(
      date: DateTime(2026, 9, 2),
      title: 'Corrida - 2km',
      isCompleted: true,
    ),
    Workout(
      date: DateTime(2026, 9, 3),
      title: 'Cardio - 30min',
      isCompleted: true,
    ),
    Workout(
      date: DateTime(2026, 9, 4),
      title: 'Flexibilidade',
      isCompleted: false,
    ),
  ];

  // Função para abrir o calendário
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Exibe a mensagem flutuante na tela (SnackBar)
  void _showStatusMessage(String title, bool isCompleted) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Limpa mensagens anteriores
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCompleted
              ? 'Treino "$title" marcado como concluído!'
              : 'Treino "$title" desmarcado.',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: isCompleted ? Colors.green.shade700 : Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredHistory = _selectedDate == null
        ? _allHistory
        : _allHistory.where((item) {
            return item.date.year == _selectedDate!.year &&
                item.date.month == _selectedDate!.month &&
                item.date.day == _selectedDate!.day;
          }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- CARD DE CABEÇALHO ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'HISTÓRICO',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            size: 28,
                            color: Colors.black87,
                          ),
                          tooltip: 'Filtrar por data',
                        ),
                      ],
                    ),
                    if (_selectedDate != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Filtro: ${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDate = null;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- LISTA ROLÁVEL COM CHECKBOX ---
              Expanded(
                child: filteredHistory.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum registo encontrado para esta data.',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredHistory.length,
                        itemBuilder: (context, index) {
                          final item = filteredHistory[index];
                          final formattedDate =
                              '${item.date.day.toString().padLeft(2, '0')}/${item.date.month.toString().padLeft(2, '0')}/${item.date.year}';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dia $formattedDate',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          item.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Checkbox Interativo
                                Transform.scale(
                                  scale: 1.2, // Aumenta levemente o tamanho do checkbox
                                  child: Checkbox(
                                    value: item.isCompleted,
                                    activeColor: Colors.black87,
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (bool? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          item.isCompleted = newValue;
                                        });
                                        _showStatusMessage(
                                          item.title,
                                          newValue,
                                        );
                                      }
                                    },
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
        ),
      ),
    );
  }
}