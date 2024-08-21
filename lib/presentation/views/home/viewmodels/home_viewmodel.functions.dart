part of 'home_viewmodel.dart';

extension Functions on HomeViewModel {
  clearCache() {
    isDeletingCache = true;
    notifyListeners();

    // Duration and step interval
    const totalDuration = Duration(milliseconds: 4000); // 4 seconds
    const stepInterval = Duration(milliseconds: 15); // Update every 100ms

    int elapsed = 0;

    // Timer to update progress bar
    Timer.periodic(stepInterval, (timer) {
      elapsed += stepInterval.inMilliseconds;

      // Calculate the progress
      double progressValue = 1 - (elapsed / totalDuration.inMilliseconds);
      updateProgress(progressValue);

      if (elapsed >= totalDuration.inMilliseconds) {
        timer.cancel();
        isDeletingCache = false;
        notifyListeners();
      }
    });
  }
}
