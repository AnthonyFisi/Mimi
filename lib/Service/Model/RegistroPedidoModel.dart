class RegistroPedidoModel{


  final int idproducto;
  final int idpedido;
  final int registropedido_cantidad;
  final double registropedido_preciototal;
  final String registropedido_detalles;
  final String registropedido_idoferta;

  RegistroPedidoModel({
    this.idproducto,
    this.idpedido,
    this.registropedido_cantidad,
    this.registropedido_preciototal,
    this.registropedido_detalles,
    this.registropedido_idoferta
  });

  factory RegistroPedidoModel.fromJson(Map<String, dynamic> json){
    return RegistroPedidoModel(
      idproducto: json['idproducto'] as int,
      idpedido: json['idpedido'] as int,
      registropedido_cantidad: json['registropedido_cantidad'] as int,
      registropedido_preciototal: json['registropedido_preciototal'] as double,
      registropedido_detalles: json['registropedido_detalles'] as String,
      registropedido_idoferta: json['registropedido_idoferta'] as String,
    );
  }





}