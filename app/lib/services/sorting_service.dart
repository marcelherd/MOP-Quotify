import 'dart:async';
import 'dart:developer';

import 'package:app/models/debate.dart';

import 'debate_service.dart';

class SortingService {

  static const _interval = const Duration(seconds: 1);

  static const _genderWeight = 10000;

  final String _debateCode;

  Timer _timer;

  SortingService(this._debateCode) {
    startSorting();
  }

  void _sort(Timer timer) async {
    var debate = await DebateService.getDebate(_debateCode);
    var archived = debate.contributions.where((c) => c.archived);
    var open = debate.contributions.where((c) => !c.archived);

    if (archived.isEmpty) return; // No sorting necessary

    var currGenderContribs = <Gender, int>{};
    archived.forEach((c) => currGenderContribs.update(c.author.gender, (v) => v - _genderWeight, ifAbsent: () =>  -_genderWeight));

    var currNameContribs = <String, int>{};
    archived.forEach((c) => currNameContribs.update(c.author.name, (v) => v - 1, ifAbsent: () => -1));

    open.forEach((c) {
      var priority = (currGenderContribs[c.author.gender] ?? 0) + (currNameContribs[c.author.name] ?? 0);
      DebateService.updatePriority(_debateCode, c.id, priority);
    });

    // hacky, it would be better to use a transaction
    archived.forEach((c) {
      if (c.priority != Contribution.ARCHIVED_PRIORITY) {
        DebateService.updatePriority(_debateCode, c.id, Contribution.ARCHIVED_PRIORITY);
      }
    });
  }

  void startSorting() {
    _timer = Timer.periodic(_interval, _sort);
  }

  void stopSorting() {
    _timer.cancel();
  }

}