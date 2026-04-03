class HistorialMedico {
  final int historialId;
  final String diagnostico;
  final String? observaciones;
  final String? proximaCita;
  final String fecha;
  final String animalNombre;

  HistorialMedico({
    required this.historialId,
    required this.diagnostico,
    this.observaciones,
    this.proximaCita,
    required this.fecha,
    required this.animalNombre,

  });

  factory HistorialMedico.fromJson(Map<String, dynamic> json) {
    return HistorialMedico(
      historialId: json['historial_id'],
      diagnostico: json['diagnostico'] ?? '',
      observaciones: json['observaciones'],
      proximaCita: json['proxima_cita'],
      fecha: json['fecha_creacion'],
      animalNombre: json['animal_nombre'] ?? '',
    
    );
  }
}