import 'dart:convert';

class VentaModel{

  final int  idPedido  ;
  final int  idtipopago ;
  final int  idubicacion ;
  final int  idhorario  ;
  final String  venta_estadoPago;
  final double  venta_costodelivery ;
  final double  venta_costoTotal ;
  final String  venta_fechaEntrega ;
  final String  venta_fecha  ;
  final String comentario;


  VentaModel({
    this.idPedido,
    this.idtipopago,
    this.idubicacion,
    this.idhorario,
    this.venta_estadoPago,
    this.venta_costodelivery,
    this.venta_costoTotal,
    this.venta_fechaEntrega,
    this.venta_fecha,
    this.comentario
});


  Map<String,dynamic> toJson(){
    return{
      "idPedido": idPedido,
      "idtipopago": idtipopago,
      "idubicacion": idubicacion,
      "idhorario": idhorario,
      "venta_estadoPago": venta_estadoPago,
      "venta_costodelivery": venta_costodelivery,
      "venta_costoTotal": venta_costoTotal,
      "venta_fechaEntrega": venta_fechaEntrega,
      "venta_fecha":venta_fecha ,
      "comentario":comentario
    };
  }


}

String ventaToJson(VentaModel venta){
  final jsonData=venta.toJson();
  print(jsonData);
  return json.encode(jsonData);
}