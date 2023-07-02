import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:types_for_perception/core_types.dart';
import 'package:types_for_perception/state_types.dart';

import 'src/system-checks/send_mission_reports_to_inspector.dart';

void initializeAstroInspector<S extends AstroState>() {
  if (const bool.fromEnvironment('IN-APP-ASTRO-INSPECTOR')) {
    /// Create a SystemCheck that sends mission updates to the Inspector
    final sendMissionReports = SendMissionReportsToInspector<S>();

    /// Add the system check to Locator so the Inspector can access the stream of mission reports
    Locator.add<SendMissionReportsToInspector>(sendMissionReports);

    /// Add the system check to the preLaunch & postLand lists so all mission reports
    /// are created and sent at the appropriate point.
    locate<SystemChecks>().preLaunch.add(sendMissionReports);
    locate<SystemChecks>().postLand.add(sendMissionReports);
  }
}