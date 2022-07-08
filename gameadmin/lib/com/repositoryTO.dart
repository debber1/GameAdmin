import 'package:gameadmin/com/networkServiceTO.dart';

import '../models/pitch.dart';

class RepositoryTO {
  final NetworkServiceTO networkServiceTO;
  RepositoryTO(this.networkServiceTO);
  Future<dynamic> fetchPitch() async {
    return networkServiceTO.fetchPitch();
  }
}
