//TODO Complete the implementation of this class

// ignore_for_file: unused_label

import 'package:exercise4/models/note.dart';
import 'package:flutter/material.dart';
import '../view.dart';
import 'main_viewmodel.dart';


/// `NoteTile` is a custom ListTile widget.
/// What it should do basically only to refactor the code
/// to make the `MainBody` much cleaner.
/// This widget will be used for normal building of
/// the list tile on the `MainBody' (i.e, without any editing)
///
class NoteTile extends StatelessWidget {
  const NoteTile(this._index);
  final int _index;

  @override
  Widget build(BuildContext context) {
    return SelectorView<MainViewmodel, Note>(
        selector: (_, vm) => vm.getNote(_index),
        builder: (_, vm,note, ___) {
          print('Build ListTile $_index');
          return ListTile(
            title: Text('${note.title}'),
            subtitle: Text('${note.content}'),
            onLongPress: () {
              vm.changeEdit(_index);
            },
            onTap: () {
              vm.changeEdit(null);
            },
          );
        },
      );
  }
}
