import 'package:tienda_mimi/Service/Model/base_model.dart';

class PedidoRealModel extends BaseModel{

   int idpedido;
   String pedido_estado;
   double pedido_montototal;
   int pedido_cantidadtotal;
   int ubicacion_idubicacion;
   int usuario_idusuario;
   String pedido_estadopago;
   int tipopago_idtipopago;
   int horario_idhorario;

  PedidoRealModel({
    this.idpedido,
  this.pedido_estado,
  this.pedido_montototal,
  this.pedido_cantidadtotal,
  this.ubicacion_idubicacion,
  this.usuario_idusuario,
  this.pedido_estadopago,
  this.tipopago_idtipopago,
  this.horario_idhorario
});


   PedidoRealModel.fromJson(Map<String,dynamic> json)
      :idpedido=json['idpedido'],
      pedido_estado=json['pedido_estado'],
      pedido_montototal=json['pedido_montototal'],
      pedido_cantidadtotal=json['pedido_cantidadtotal'],
      ubicacion_idubicacion=json['ubicacion_idubicacion'],
      usuario_idusuario=json['usuario_idusuario'] ,
      pedido_estadopago=json['pedido_estadopago'] ,
      tipopago_idtipopago=json['tipopago_idtipopago'],
      horario_idhorario=json['horario_idhorario'];



}