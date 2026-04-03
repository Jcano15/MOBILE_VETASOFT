import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_routes_historial_medico.dart';
import '../../utils/app_routes_pacientes.dart';

class PacientesView extends StatefulWidget {
  const PacientesView({super.key});

  @override
  State<PacientesView> createState() => _PacientesViewState();
}

class _PacientesViewState extends State<PacientesView> {
  final String baseUrl = 'http://127.0.0.1:4000/api';

  List<dynamic> pacientes = [];
  List<dynamic> filteredData = [];
  List<dynamic> especiesData = [];

  String selectedEspecie = 'Todas';
  String searchText = '';

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadEspecies();
    loadPacientes();
  }

 Future<void> loadPacientes() async {
  final res = await http.get(Uri.parse('$baseUrl/animales'));
  final decoded = jsonDecode(res.body);

  List data = decoded['data'] ?? [];

  final Set<String> uniqueEspecies = {};
  for (var paciente in data) {
    final especie = (paciente['nombre_especie'] ?? '').toString().trim();
    if (especie.isNotEmpty) {
      uniqueEspecies.add(especie);
    }
  }

  setState(() {
    pacientes = data;
    filteredData = data;
    especiesData = uniqueEspecies.toList();
    loading = false;
  });
}
  Future<void> loadEspecies() async {
    final res = await http.get(Uri.parse('$baseUrl/especies'));
    final decoded = jsonDecode(res.body);

    setState(() {
      especiesData = decoded['data'] ?? [];
    });
  }

  void filterData() {
    setState(() {
      filteredData = pacientes.where((item) {
        final nombre = (item['nombre'] ?? '').toString().toLowerCase();
        final propietario = (item['cliente_nombre'] ?? '').toString().toLowerCase();

        final matchTexto = nombre.contains(searchText) || propietario.contains(searchText);

        final especieItem = (item['nombre_especie'] ?? '').toString().toLowerCase();
        final matchEspecie = selectedEspecie == 'Todas'
            ? true
            : especieItem == selectedEspecie.toLowerCase();

        return matchTexto && matchEspecie;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),

      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5D9CC5), Color(0xFF664492)],
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, size: 18, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Volver',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pacientes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Mascotas registradas',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutesPacientes.registrarMascota,
                );
              },
              child: const Text('+ Registrar'),
            ),
          )
        ],
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Text(
                      'Buscar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Mascota o propietario',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    searchText = value.toLowerCase();
                    filterData();
                  },
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.filter_list),
                    SizedBox(width: 8),
                    Text(
                      'Filtrar por especie',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: selectedEspecie,
                    isExpanded: false,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: Colors.white,
                    items: [
                      const DropdownMenuItem(
                        value: 'Todas',
                        child: Text('Todas'),
                      ),
                      ...especiesData.map((e) {
           final nombre = e.toString();
          return DropdownMenuItem<String>(
                value: nombre,
             child: Text(nombre, overflow: TextOverflow.ellipsis),
             );
              }).toList(),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedEspecie = value;
                        filterData();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            const Center(child: CircularProgressIndicator())
          else
            ...filteredData.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFF6a4cc4),
                          child: Icon(Icons.pets, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['nombre'] ?? ''),
                              Text('${item['nombre_raza']} • ${item['edad']} años • ${item['sexo']}'),
                              Text('Dueño: ${item['cliente_nombre']}'),
                              Text('Doc: ${item['cliente_documento']}'),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutesPacientes.detallePaciente,
                                arguments: item,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF5D9CC5), Color(0xFF664492)],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Editar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                               AppRoutesHistorialMedico.historial,
                                arguments: item,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Ver historial',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList()
        ],
      ),
    );
  }
}