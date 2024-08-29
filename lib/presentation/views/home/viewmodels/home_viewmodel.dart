import 'dart:async';

import 'package:paddle_jakarta/app/app.bottomsheets.dart';
import 'package:paddle_jakarta/app/app.dialogs.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/common/app_strings.dart';
import 'package:paddle_jakarta/services/theme_service.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

part 'home_viewmodel_state.dart';
part 'home_viewmodel_functions.dart';

class HomeViewModel extends BaseViewModel {

  final UserRepository _userRepository;
  final TimelineRepository  _timelineRepository;

  HomeViewModel(this._userRepository, this._timelineRepository);

  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final themeService = locator<ThemeService>();

  int indexState = 0;
  int limitLoad = 10;

  bool isDeletingCache = false;
  bool isLastMatchCardMinimized = false;
  bool isAnimating = false;
  bool isNotificationUnseen = false;
  bool isEditingProfile = false;
  double progress = 1.0;

  Set<TimelineItemModel> timelineItems = {};

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  init() async {
    await getMyTimeline();
  }

}
