import 'package:quatrows/domain/ipa/model.dart';
import 'package:quatrows/domain/ipa/repository.dart';

class GetRandomIpaUseCase {
  final IpaRepository repository;

  GetRandomIpaUseCase(this.repository);

  Future<Ipa> call() async {
    final Ipa = await repository.getIpaRepository();
    Ipa.shuffle();
    return Ipa.first;
  }
}
