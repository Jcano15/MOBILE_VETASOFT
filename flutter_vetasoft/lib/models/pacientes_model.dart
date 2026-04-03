class Paciente {
  final int pacienteId;
  final String nombre;
  final int clienteId;
  final String clienteNombre;
  final String clienteTelefono;
  final int razaId;
  final String razaNombre;
  final String especieNombre;
  final int especieId;
  final int edad;
  final String fechaNacimiento;
  final double peso;
  final String sexo;
  final String descripcion;
  final String numeroChip;
  final String estado;
  final String fechaIngreso;

  Paciente({
    required this.pacienteId,
    required this.nombre,
    required this.clienteId,
    required this.clienteNombre,
    required this.clienteTelefono,
    required this.razaId,
    required this.razaNombre,
    required this.especieNombre,
    required this.especieId,
    required this.edad,
    required this.fechaNacimiento,
    required this.peso,
    required this.sexo,
    required this.descripcion,
    required this.numeroChip,
    required this.estado,
    required this.fechaIngreso,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    double _parsePeso(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
      return 0.0;
    }

    return Paciente(
      pacienteId: json['animal_id'] ?? json['id'] ?? 0,
      nombre: json['nombre'] ?? 'Sin nombre',
      clienteId: json['cliente_id'] ?? 0,
      clienteNombre: json['cliente_nombre'] ?? 'Sin propietario',
      clienteTelefono: json['cliente_telefono'] ?? 'N/A',
      razaId: json['raza_id'] ?? 0,
      razaNombre: json['nombre_raza'] ?? 'Sin raza',
      especieNombre: json['nombre_especie'] ?? 'Sin especie',
      especieId: json['especie_id'] ?? 0,
      edad: json['edad'] ?? 0,
      fechaNacimiento: json['fecha_nacimiento'] ?? '',
      peso: _parsePeso(json['peso']),
      sexo: json['sexo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      numeroChip: json['numero_chip'] ?? '',
      estado: json['estado'] ?? 'Activo',
      fechaIngreso: json['fecha_ingreso'] ?? json['created_at'] ?? '',
    );
  }
}
