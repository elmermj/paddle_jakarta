import 'package:paddle_jakarta/presentation/bottom_sheets/notice/notice_sheet.dart';
import 'package:paddle_jakarta/presentation/dialogs/info_alert/info_alert_dialog.dart';
import 'package:paddle_jakarta/presentation/views/home/home_view.dart';
import 'package:paddle_jakarta/presentation/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paddle_jakarta/presentation/views/auth/views/auth_view.dart';
import 'package:paddle_jakarta/presentation/views/profile/profile_view.dart';
import 'package:paddle_jakarta/presentation/views/match/match_view.dart';
import 'package:paddle_jakarta/services/theme_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: MatchView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ThemeService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
