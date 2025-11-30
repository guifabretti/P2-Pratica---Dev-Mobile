import 'package:flutter/material.dart';
import '../database/db_202310286.dart';
import '../models/tarefa.dart';

class TarefaFormPage extends StatefulWidget {
  final Tarefa? tarefa; // se vier preenchido = edição

  const TarefaFormPage({super.key, this.tarefa});

  @override
  State<TarefaFormPage> createState() => _TarefaFormPageState();
}

class _TarefaFormPageState extends State<TarefaFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _prioridadeController = TextEditingController();
  final _indiceRelevanciaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.tarefa != null) {
      _tituloController.text = widget.tarefa!.titulo;
      _descricaoController.text = widget.tarefa!.descricao;
      _prioridadeController.text = widget.tarefa!.prioridade.toString();
      _indiceRelevanciaController.text =
          widget.tarefa!.indiceRelevancia.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa == null
            ? 'Cadastrar Tarefa'
            : 'Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o título' : null,
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) =>
                      value!.isEmpty ? 'Informe a descrição' : null,
                ),
                TextFormField(
                  controller: _prioridadeController,
                  decoration: const InputDecoration(labelText: 'Prioridade (1 a 5)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Informe a prioridade' : null,
                ),
                TextFormField(
                  controller: _indiceRelevanciaController,
                  decoration:
                      const InputDecoration(labelText: 'Índice de Relevância'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o índice' : null,
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _salvar,
                  child: Text(widget.tarefa == null ? 'Salvar' : 'Atualizar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final db = DatabaseHelper.instance;

      final novaTarefa = Tarefa(
        id: widget.tarefa?.id,
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        prioridade: int.parse(_prioridadeController.text),
        criadoEm: widget.tarefa?.criadoEm ?? DateTime.now().toString(),
        indiceRelevancia: double.parse(_indiceRelevanciaController.text),
      );

      if (widget.tarefa == null) {
        await db.inserirTarefa(novaTarefa);
      } else {
        await db.atualizarTarefa(novaTarefa);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }
}
