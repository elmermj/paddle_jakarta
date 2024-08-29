import 'package:hive/hive.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final userDataBox = locator<Box<UserModel>>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    if(userDataBox.isNotEmpty) {
      _navigationService.replaceWithHomeView();
    } else {
      _navigationService.replaceWithAuthView();
    }
  }
}
