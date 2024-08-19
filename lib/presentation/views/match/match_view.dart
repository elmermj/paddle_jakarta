import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'match_viewmodel.dart';

class MatchView extends StackedView<MatchViewModel> {
  const MatchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MatchViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  MatchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MatchViewModel();
}
