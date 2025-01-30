import 'package:quatrows/domain/mtk/model.dart';
import 'package:quatrows/domain/mtk/repository.dart';

class GetRandomMatematikaUseCase {
  final MatematikaRepository repository;

  GetRandomMatematikaUseCase(this.repository);

  Future<Matematika> call() async {
    final Matematika = await repository.getMatematikaRepository();
    Matematika.shuffle();
    return Matematika.first;
  }
}
