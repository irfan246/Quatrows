import 'package:quatrows/domain/inggris/model.dart';
import 'package:quatrows/domain/inggris/repository.dart';

class GetRandomInggrisUseCase {
  final InggrisRepository repository;

  GetRandomInggrisUseCase(this.repository);

  Future<Inggris> call() async {
    final Inggris = await repository.getInggrisRepository();
    Inggris.shuffle();
    return Inggris.first;
  }
}
