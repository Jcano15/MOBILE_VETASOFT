import 'package:flutter/material.dart';
import '../../services/api_service_historial_medico.dart';
import '../../models/historial_medico_model.dart';

class HistorialMedicoView extends StatefulWidget {
  const HistorialMedicoView({super.key});

  @override
  State<HistorialMedicoView> createState() =>
      _HistorialMedicoViewState();
}

class _HistorialMedicoViewState
    extends State<HistorialMedicoView> {

  List<HistorialMedico> historial = [];
  bool loading = true;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      loadHistorial();
    }
  }

  Future<void> loadHistorial() async {
    final data =
        await ApiServiceHistorialMedico.fetchHistorial();

    final paciente =
        ModalRoute.of(context)?.settings.arguments as Map?;

    final filtrado = data.where((h) {
      if (paciente == null) return true;
      return h.animalNombre.toLowerCase().trim() ==
          paciente['nombre'].toLowerCase().trim();
    }).toList();

    setState(() {
      historial = filtrado;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final paciente =
        ModalRoute.of(context)?.settings.arguments as Map?;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.of(context).padding.top + 8,
              16,
              10,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5D9CC5), Color(0xFF664492)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Volver',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                const Text(
                  'Historial medico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  'De ${paciente?['nombre'] ?? ''}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          /// BOTÓN AGREGAR
          Padding(
            padding: const EdgeInsets.all(14),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: const Text('Agregar')),
                        body: const Center(
                          child: Text('Aquí va el módulo AGREGAR HISTORIAL'),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5D9CC5), Color(0xFF664492)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Agregar registro +',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// CONTENIDO
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : historial.isEmpty
                    ? const Center(
                        child: Text(
                          'No tiene historial medico',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: historial.length,
                        itemBuilder: (context, i) {

                          final item = historial[i];

                          return Container(
                            margin:
                                const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [

                                  /// LINEA AZUL
                                  Container(
                                    width: 4,
                                    decoration:
                                        const BoxDecoration(
                                      color: Color(0xFF6081B5),
                                      borderRadius:
                                          BorderRadius.only(
                                        topLeft:
                                            Radius.circular(50),
                                        bottomLeft:
                                            Radius.circular(50),
                                      ),
                                    ),
                                  ),

                                  /// CONTENIDO
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.diagnostico,
                                                  style:
                                                      const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),

                                              /// 👁 OJITO (NO SE CAMBIA)
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) => Scaffold(
                                                        appBar: AppBar(title: const Text('Detalle')),
                                                        body: const Center(
                                                          child: Text('Aquí va el módulo VER HISTORIAL'),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.remove_red_eye,
                                                  size: 16,
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              /// EDITAR
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) => Scaffold(
                                                        appBar: AppBar(title: const Text('Editar')),
                                                        body: const Center(
                                                          child: Text('Aquí va el módulo EDITAR HISTORIAL'),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(6),
                                                    border: Border.all(color: Colors.grey),
                                                  ),
                                                  child: const Text(
                                                    'Editar',
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                          const SizedBox(height: 6),

                                          Text(
                                            item.fecha,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          _campo(
                                            'Observaciones:',
                                            item.observaciones ?? 'N/A',
                                          ),
                                          _campo(
                                            'Diagnostico:',
                                            item.diagnostico,
                                          ),
                                          _campo(
                                            'Próximo control:',
                                            item.proximaCita ?? 'DD/MM/AAAA',
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _campo(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEFF2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(valor,
                style: const TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}