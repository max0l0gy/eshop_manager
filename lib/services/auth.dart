
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';

import 'networking.dart';

const endpoint = EshopManagerProperties.API_ROOT_URL;
const checkAuthUrl = '$endpoint/rest/api/private/checkAuth';

class Authenticate {
  final EshopManager eshopManager;

  Authenticate(this.eshopManager);

  Future<List<String>> getAuthorities() async {
    dynamic authorities =
        await NetworkHelper(basicCridentials: eshopManager.getCridentials())
            .getPrivateData(checkAuthUrl);
    return _convertAuthorities(authorities);
  }

  List<String> _convertAuthorities(dynamic authCheckResponse) {
    if (authCheckResponse == null) return [];
    print("authCheckResponse ${authCheckResponse}");
    List<dynamic> auth = authCheckResponse['authorities'];
    return auth.map((e) => e['authority'].toString()).toList();
  }
}
