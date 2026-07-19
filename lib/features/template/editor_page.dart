import 'package:flexwala/features/template/static_template_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../editor/domain/entities/template.dart';
import '../editor/presentation/bloc/editor_bloc.dart';
import '../editor/presentation/bloc/editor_event.dart';
import '../editor/presentation/screens/editor_screen.dart';


class EditorPage extends StatelessWidget {
  final EditorTemplate template;
  const EditorPage({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditorBloc(templateRepository: StaticTemplateRepository())
        ..add(TemplateSelected(template)),
      child: const EditorScreen(),
    );
  }
}