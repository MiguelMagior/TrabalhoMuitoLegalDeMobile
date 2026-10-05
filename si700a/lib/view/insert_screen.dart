import 'package:flutter/material.dart';

class InsertScreen extends StatefulWidget {
  const InsertScreen({super.key});

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  final _nomeController = TextEditingController();
  String _categoriaSelecionada = 'Força';

  // Dias da semana: [Dom, Seg, Ter, Qua, Qui, Sex, Sab]
  final List<String> _diasSemana = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];
  final List<bool> _diasSelecionados = [false, true, false, false, false, true, false];

  bool _temAlarme = false;

  // Lista dinâmica de etapas (Descrição + Repetições/Tempo)
  final List<Map<String, TextEditingController>> _etapas = [
    {
      'nome': TextEditingController(),
      'detalhe': TextEditingController(),
    },
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    for (var etapa in _etapas) {
      etapa['nome']?.dispose();
      etapa['detalhe']?.dispose();
    }
    super.dispose();
  }

  void _adicionarEtapa() {
    setState(() {
      _etapas.add({
        'nome': TextEditingController(),
        'detalhe': TextEditingController(),
      });
    });
  }

  void _removerEtapa(int index) {
    if (_etapas.length > 1) {
      setState(() {
        _etapas[index]['nome']?.dispose();
        _etapas[index]['detalhe']?.dispose();
        _etapas.removeAt(index);
      });
    }
  }

  void _salvarTreino() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Treino "${_nomeController.text.isEmpty ? 'Sem Nome' : _nomeController.text}" cadastrado!'),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // Fundo padrão das outras telas
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- CARD 1: FORMULÁRIO PRINCIPAL ---
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
                    const Text(
                      'CADASTRAR TREINO',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo NOME
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'NOME',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _nomeController,
                            decoration: InputDecoration(
                              hintText: 'Ex: Treino A',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Campo CATEGORIA
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'CATEGORIA',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _categoriaSelecionada,
                                isExpanded: true,
                                items: ['Força', 'Cardio', 'Flexibilidade']
                                    .map((cat) => DropdownMenuItem(
                                          value: cat,
                                          child: Text(cat),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _categoriaSelecionada = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // AGENDAR - DIA DA SEMANA
                    const Text(
                      'AGENDAR - DIA DA SEMANA',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(7, (index) {
                        final isSelected = _diasSelecionados[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _diasSelecionados[index] = !_diasSelecionados[index];
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF00E600) : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.transparent : Colors.grey.shade600,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _diasSemana[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // ALARME?
                    Row(
                      children: [
                        const Text(
                          'ALARME?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Switch(
                          value: _temAlarme,
                          activeColor: const Color(0xFF00E600),
                          onChanged: (value) {
                            setState(() {
                              _temAlarme = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- CARD 2: ETAPAS DO TREINO ---
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
                    const Text(
                      'ETAPAS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Lista de Etapas
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _etapas.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Campo Descrição do Exercício
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: _etapas[index]['nome'],
                                  decoration: InputDecoration(
                                    hintText: 'Exercício',
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Campo Detalhes (Reps/Peso)
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: _etapas[index]['detalhe'],
                                  decoration: InputDecoration(
                                    hintText: 'Qtd/Tempo',
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              if (_etapas.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () => _removerEtapa(index),
                                ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // Botão Adicionar Etapa (+)
                    Center(
                      child: IconButton(
                        onPressed: _adicionarEtapa,
                        iconSize: 36,
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- BOTÃO DE CADASTRAR ---
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _salvarTreino,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Salvar Treino',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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