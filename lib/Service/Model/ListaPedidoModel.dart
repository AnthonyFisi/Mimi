class ListaPedidoModel{
/*
*
	private int idpedido;
    private String venta_estadopago;
	private String venta_fechaentrega;
	private String venta_costodelivery;
	private float venta_costototal;
	private String tipopago_nombre;
	private String ubicacion_nombre;
	private String horario_nombre;
*
* */
  final int idpedido;

  final String venta_estadopago;
  final String venta_fechaentrega;
  final String venta_costodelivery;
  final double venta_costototal;
  final String tipopago_nombre;
  final String ubicacion_nombre;
  final String horario_nombre;

  ListaPedidoModel({
      this.idpedido,
      this.venta_estadopago,
      this.venta_fechaentrega,
      this.venta_costodelivery,
      this.venta_costototal,
      this.tipopago_nombre,
    this.ubicacion_nombre,
    this.horario_nombre,
});

  factory ListaPedidoModel.fromJson(Map<String,dynamic> json){
    return ListaPedidoModel(
      idpedido: json['idpedido'] as int,
      venta_estadopago: json['venta_estadopago'] as String,
      venta_fechaentrega: json['venta_fechaentrega'] as String,
      venta_costodelivery: json['venta_costodelivery'] as String,
      venta_costototal: json['venta_costototal'] as double,
      tipopago_nombre: json['tipopago_nombre'] as String,
      ubicacion_nombre: json['ubicacion_nombre'] as String,
      horario_nombre: json['horario_nombre'] as String
    );
  }


}