import 'package:quatrows/domain/indo/model.dart';
import 'package:quatrows/domain/indo/repository.dart';

class GetRandomIndonesiaUseCase {
  final IndonesiaRepository repository;

  GetRandomIndonesiaUseCase(this.repository);

  Future<Indonesia> call() async {
    final Indonesia = await repository.getIndonesiaRepository();
    Indonesia.shuffle();
    return Indonesia.first;
  }
}
