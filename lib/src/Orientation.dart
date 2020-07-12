
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

class DraggableProof extends StatefulWidget {
  @override
  _DraggableProofState createState() => _DraggableProofState();
}

class _DraggableProofState extends State<DraggableProof> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      controller: controller,
      scrollbarAnimationDuration: const Duration(minutes: 1),
      //alwaysVisibleScrollThumb: true,
      child: ListView.builder(
        controller: controller,

        itemCount: 1000,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.cyan[index % 9 * 100],
              child: Center(
                child: Text(index.toString()),
              ),
            ),
          );
        },


      ),
      heightScrollThumb: 48.0,
      backgroundColor: Colors.blue,
      scrollThumbBuilder: (
          Color backgroundColor,
          Animation<double> thumbAnimation,
          Animation<double> labelAnimation,
          double height, {
            Text labelText,
            BoxConstraints labelConstraints,
          }) {
        return FadeTransition(
          opacity: thumbAnimation,
          child: Container(
            height: height,
            width: 20.0,
            color: backgroundColor,
          ),
        );
      },
    );
  }
}


/*
*                           child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.only(left: 10.0, right: 0.0),
                                child:
                                Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        //color:Colors.blue,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Image.network(
                                                snapshot
                                                    .data[index].producto_uri_imagen,
                                                height: 60.0,
                                                width: 60.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // color:Colors.amber,
                                        width: 150,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(
                                                  snapshot
                                                      .data[index].producto_nombre,
                                                  style: TextStyle(fontSize: 13.0),
                                                ),
                                              ),
                                              Text(snapshot
                                                  .data[index].producto_marca),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(snapshot
                                                    .data[index].producto_detalle),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(snapshot
                                                    .data[index].producto_envase +
                                                    " " +
                                                    snapshot.data[index]
                                                        .producto_cantidad),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text('precio:S./ ' +
                                                    (snapshot.data[index]
                                                        .registropedido_preciototal)
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          //color:Colors.lightGreenAccent,
                                          width: 100.0,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                //color:Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 5.0),
                                                  child: IconButton(
                                                      icon:Container(
                                                        decoration: new BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          border:Border.all(color:GREEN,width: 1.5),

                                                        ),
                                                        child: Icon(Icons.remove,color: GREEN,),
                                                      ),
                                                      onPressed:() async {
                                                        // print((snapshot.data[index].registropedido_cantidad).toString());

                                                        if (snapshot.data[index]
                                                            .registropedido_cantidad <
                                                            2) {
                                                          bool rpta =
                                                          await eliminarProducto(
                                                              1,
                                                              snapshot.data[index]
                                                                  .idProducto);
                                                          snapshot.data
                                                              .removeAt(index);
                                                        } else {
                                                          PedidoModel pedido =
                                                          new PedidoModel(
                                                              idProducto: snapshot
                                                                  .data[index]
                                                                  .idProducto,
                                                              cantidad: 1,
                                                              precio: (snapshot
                                                                  .data[index]
                                                                  .Producto_precio)
                                                                  .toDouble(),
                                                              idUsuario: idUsuario);

                                                          bool rpta =
                                                          await createPedidoDisminuir(
                                                              pedido);
                                                          //   print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());
                                                          print((snapshot.data[index]
                                                              .registropedido_cantidad)
                                                              .toString());
                                                        }

                                                        setState(() {
                                                          print('holi');
                                                        });
                                                      },

                                                  )

                                                 /* GestureDetector(
                                                      onTap: () async {
                                                        // print((snapshot.data[index].registropedido_cantidad).toString());

                                                        if (snapshot.data[index]
                                                            .registropedido_cantidad <
                                                            2) {
                                                          bool rpta =
                                                          await eliminarProducto(
                                                              1,
                                                              snapshot.data[index]
                                                                  .idProducto);
                                                          snapshot.data
                                                              .removeAt(index);
                                                        } else {
                                                          PedidoModel pedido =
                                                          new PedidoModel(
                                                              idProducto: snapshot
                                                                  .data[index]
                                                                  .idProducto,
                                                              cantidad: 1,
                                                              precio: (snapshot
                                                                  .data[index]
                                                                  .Producto_precio)
                                                                  .toDouble(),
                                                              idUsuario: idUsuario);

                                                          bool rpta =
                                                          await createPedidoDisminuir(
                                                              pedido);
                                                          //   print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());
                                                          print((snapshot.data[index]
                                                              .registropedido_cantidad)
                                                              .toString());
                                                        }

                                                        setState(() {
                                                          print('holi');
                                                        });
                                                      },
                                                      child: Icon(Icons.remove,
                                                          color: Colors.green)),*/


                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Text((snapshot.data[index]
                                                        .registropedido_cantidad)
                                                        .toString())),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10.0),
                                                  child:IconButton(
                                                    icon:Container(
                                                      decoration: new BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        border:Border.all(color:GREEN,width: 1.5),

                                                      ),
                                                      child: Icon(Icons.add,color: GREEN,),
                                                    ),
                                                    onPressed: () async {
                                                      print((snapshot.data[index]
                                                          .registropedido_cantidad)
                                                          .toString());
                                                      PedidoModel pedido =
                                                      new PedidoModel(
                                                          idProducto: snapshot
                                                              .data[index]
                                                              .idProducto,
                                                          cantidad: 1,
                                                          precio: (snapshot
                                                              .data[index]
                                                              .Producto_precio)
                                                              .toDouble(),
                                                          idUsuario: idUsuario);

                                                      bool rpta =
                                                      await createPedidoAumentar(
                                                          pedido);
                                                      print((rpta).toString() +
                                                          " - " +
                                                          (pedido.idUsuario)
                                                              .toString() +
                                                          " -  " +
                                                          (pedido.idProducto)
                                                              .toString());
                                                      print((snapshot.data[index]
                                                          .registropedido_cantidad)
                                                          .toString());

                                                      setState(() {
                                                        print('holi');
                                                      });
                                                    },

                                                  )

                                                  /*
                                                  GestureDetector(
                                                      onTap: () async {
                                                        print((snapshot.data[index]
                                                            .registropedido_cantidad)
                                                            .toString());
                                                        PedidoModel pedido =
                                                        new PedidoModel(
                                                            idProducto: snapshot
                                                                .data[index]
                                                                .idProducto,
                                                            cantidad: 1,
                                                            precio: (snapshot
                                                                .data[index]
                                                                .Producto_precio)
                                                                .toDouble(),
                                                            idUsuario: idUsuario);

                                                        bool rpta =
                                                        await createPedidoAumentar(
                                                            pedido);
                                                        print((rpta).toString() +
                                                            " - " +
                                                            (pedido.idUsuario)
                                                                .toString() +
                                                            " -  " +
                                                            (pedido.idProducto)
                                                                .toString());
                                                        print((snapshot.data[index]
                                                            .registropedido_cantidad)
                                                            .toString());

                                                        setState(() {
                                                          print('holi');
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                      )),
                                                */

                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 67.0),
                                        child: Container(
                                          //  color:Colors.purpleAccent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 1.0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                bool rpta = await eliminarProducto(UsuarioModel.idUsuario,
                                                    snapshot.data[index].idProducto);
                                                print((rpta).toString());
                                                setState(() {
                                                  snapshot.data.removeAt(index);
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete_outline,
                                                size: 20.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              );
                            },
                          ),

*
* */