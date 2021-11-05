import 'package:flutter/material.dart';

import 'golden_runner_scenario.dart';

class GoldenRunnerScenarioListWidget extends StatelessWidget {
  const GoldenRunnerScenarioListWidget({
    required this.scenarios,
    Key? key,
  }) : super(key: key);

  final Iterable<GoldenRunnerScenario> scenarios;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: scenarios.map((scenario) {
            return _ScenarioWidget(scenario: scenario);
          }).toList(),
        ),
      ),
    );
  }
}

class _ScenarioWidget extends StatelessWidget {
  const _ScenarioWidget({required this.scenario});

  final GoldenRunnerScenario scenario;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (scenario.name.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              scenario.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ColoredBox(
            color: Colors.white,
            child: scenario.child,
          ),
        ),
      ],
    );
  }
}
