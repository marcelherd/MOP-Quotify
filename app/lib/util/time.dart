String formatDuration(Duration duration) {
  var milliseconds = duration.inMilliseconds % 1000;
  var milliStr = milliseconds < 10 ? '00' : milliseconds < 100 ? '0${milliseconds.toString()[0]}' : milliseconds.toString().substring(0, 2);
  var seconds = duration.inSeconds % 60;
  var secondsFiller = seconds < 10 ? '0' : '';
  var minutes = duration.inMinutes;
  var minutesFiller = minutes < 10 ? '0' : '';
  return '$minutesFiller$minutes:$secondsFiller$seconds.$milliStr';
}