class TipoPago{

  final int idtipopago;
  final String tipopago_nombre;

  TipoPago({this.idtipopago, this.tipopago_nombre});


  factory TipoPago.fromJson(Map<String, dynamic> json){
    return TipoPago(
      idtipopago: json['idtipopago'] as int,
      tipopago_nombre: json['tipopago_nombre'] as String,
    );
  }

}