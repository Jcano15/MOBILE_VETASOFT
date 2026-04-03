import 'package:flutter/material.dart';
import '../models/historial_medico_model.dart';
import '../utils/date_format_historial_medico.dart';

class HistorialCard extends StatelessWidget {
  final HistorialMedico item;
  final VoidCallback onView;
  final VoidCallback onEdit;

  const HistorialCard({
    super.key,
    required this.item,
    required this.onView,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: Text(
                  item.diagnostico,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: onView,
              ),

              const SizedBox(width: 6),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2a7dd7),
                  foregroundColor: Colors.white,
                ),
                onPressed: onEdit,
                child: const Text('Editar'),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(formatDate(item.fecha)),

          const SizedBox(height: 8),

          Text('Observaciones: ${item.observaciones ?? 'N/A'}'),

          const SizedBox(height: 8),

          Text('Diagnostico: ${item.diagnostico}'),

          const SizedBox(height: 8),

          Text(
            'Próximo control: ${formatDate(item.proximaCita)}',
          ),
        ],
      ),
    );
  }
}