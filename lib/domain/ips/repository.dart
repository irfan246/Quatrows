import 'package:quatrows/domain/ips/model.dart';

abstract class IpsRepository {
  Future<List<Ips>> getIpsRepository();
}
