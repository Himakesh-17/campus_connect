class Checkpoint {
  final String label;
  final String title;
  final String instruction;
  final bool isStop;
  final double? latitude;
  final double? longitude;
  
  // Normalized canvas coordinates [-1, 1] for custom map painting
  final double dx;
  final double dy;

  const Checkpoint({
    required this.label,
    required this.title,
    required this.instruction,
    this.isStop = false,
    this.latitude,
    this.longitude,
    this.dx = 0.0,
    this.dy = 0.0,
  });
}
