
import 'package:rxdart/rxdart.dart';
import 'package:tienda_mimi/Service/Bloc/Repository.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';

abstract class BaseBloc<T extends BaseModel> {
  final repository = Repository();
  final repositoryUsuario=RepositoryUsuario();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}