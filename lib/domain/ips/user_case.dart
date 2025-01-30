import 'package:quatrows/domain/ips/model.dart';
import 'package:quatrows/domain/ips/repository.dart';

class GetRandomIpsUseCase {
  final IpsRepository repository;

  GetRandomIpsUseCase(this.repository);

  Future<Ips> call() async {
    final Ips = await repository.getIpsRepository();
    Ips.shuffle();
    return Ips.first;
  }
}
