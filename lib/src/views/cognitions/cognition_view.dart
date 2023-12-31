import 'package:percepts/percepts.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/material.dart';
import 'package:abstractions/beliefs.dart';

import '../../beliefs/introspection_beliefs.dart';
import 'cognition_view_model.dart';
import '../../cognition/cognition_selected.dart';

class CognitionView extends StatelessWidget {
  const CognitionView({
    Key? key,
    required this.cognitionName,
    required this.cognitionType,
    required this.cognitionValues,
    required this.cognitionIndex,
  }) : super(key: key);

  final String cognitionName;
  final String cognitionType;
  final Map<String, dynamic> cognitionValues;
  final int cognitionIndex;

  @override
  Widget build(BuildContext context) {
    var isAsync = cognitionType == 'consider';

    return StreamOfConsciousness<IntrospectionBeliefs, CognitionViewModel>(
        infer: (state) => CognitionViewModel(
            cognitionIndex == state.selectedIndex,
            state.lineageForIndex[cognitionIndex]?.shapeWidgets),
        builder: (context, vm) {
          return Stack(
            children: [
              SizedBox(
                height: 55,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: isAsync ? 5 : 20,
                    top: 5,
                    right: isAsync ? 20 : 5,
                    bottom: 5,
                  ),
                  child: ListTile(
                    dense: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: isAsync ? Colors.green : Colors.blue,
                          width: vm.isSelected ? 3 : 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    title: Text(cognitionName),
                    onTap: () => locate<BeliefSystem<IntrospectionBeliefs>>()
                        .conclude(CognitionSelected(cognitionIndex)),
                    tileColor: isAsync ? Colors.green[50] : Colors.blue[50],
                  ),
                ),
              ),
              if (vm.lineageShapes != null) ...vm.lineageShapes!
            ],
          );
        });
  }
}
