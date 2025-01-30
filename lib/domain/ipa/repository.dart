import 'package:quatrows/domain/ipa/model.dart';

abstract class IpaRepository {
  Future<List<Ipa>> getIpaRepository();
}
