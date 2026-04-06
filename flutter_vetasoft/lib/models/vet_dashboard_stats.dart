class VetDashboardStats {
  final int citasHoy;
  final int pacientesRegistrados;
  final int solicitudesAdopcion;
  final double donacionesMes;

  VetDashboardStats({
    this.citasHoy = 0,
    this.pacientesRegistrados = 0,
    this.solicitudesAdopcion = 0,
    this.donacionesMes = 0.0,
  });

  // El método copyWith es muy útil para actualizar datos individuales
  VetDashboardStats copyWith({
    int? citasHoy,
    int? pacientesRegistrados,
    int? solicitudesAdopcion,
    double? donacionesMes,
  }) {
    return VetDashboardStats(
      citasHoy: citasHoy ?? this.citasHoy,
      pacientesRegistrados: pacientesRegistrados ?? this.pacientesRegistrados,
      solicitudesAdopcion: solicitudesAdopcion ?? this.solicitudesAdopcion,
      donacionesMes: donacionesMes ?? this.donacionesMes,
    );
  }
}
