import 'package:flutter/material.dart';
import '../database/db_202310286.dart';
import '../models/tarefa.dart';
import 'tarefa_form_page.dart';

class TarefasListPage extends StatefulWidget {
  const TarefasListPage({super.key});

  @override
  State<TarefasListPage> createState() => _TarefasListPageState();
}

class _TarefasListPageState extends State<TarefasListPage> {
  List<Tarefa> tarefas = [];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final data = await DatabaseHelper.instance.listarTarefas();
    setState(() {
      tarefas = data;
    });
  }

  void excluirTarefa(int id) async {
    await DatabaseHelper.instance.deletarTarefa(id);
    carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          'Minhas Tarefas (RA: 202310286)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TarefaFormPage(),
            ),
          );
          carregarTarefas();
        },
      ),
      body: tarefas.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma tarefa cadastrada ainda.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (_, index) {
                final tarefa = tarefas[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      tarefa.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),

                        // --- DESCRIÇÃO AQUI ---
                        Text(
                          tarefa.descricao,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          'Prioridade: ${tarefa.prioridade}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Relevância: ${tarefa.indiceRelevancia}',
                          style: const TextStyle(color: Colors.grey),
                        ),

                        // Se quiser mostrar também a data de criação:
                        // Text(
                        //   'Criado em: ${tarefa.criadoEm}',
                        //   style: const TextStyle(color: Colors.grey),
                        // ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TarefaFormPage(tarefa: tarefa),
                              ),
                            );
                            carregarTarefas();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            excluirTarefa(tarefa.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
