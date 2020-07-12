class HorarioModel{
  final int idhorario;
  final String horario_nombre;

  HorarioModel({
    this.idhorario,
    this.horario_nombre,
  });



  factory HorarioModel.fromJson(Map<String, dynamic> json){
    return HorarioModel(
      idhorario: json['idHorario'] as int,
      horario_nombre: json['horario_nombre'] as  String,

    );
  }

}


class HorarioModelCompleto{
  final int idhorario;
  final String horario_nombre;
  final DateTime fecha;

  HorarioModelCompleto({
    this.idhorario,
    this.horario_nombre,
    this.fecha
  });
}