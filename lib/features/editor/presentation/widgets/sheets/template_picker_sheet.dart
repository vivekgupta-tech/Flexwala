import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import '../../bloc/editor_state.dart';

class TemplatePickerSheet extends StatelessWidget {
  const TemplatePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EditorBloc>().add(const LoadTemplates());

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Templates',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                child: BlocBuilder<EditorBloc, EditorState>(
                  builder: (context, state) {
                    if (state.templatesStatus == TemplatesStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.templatesStatus == TemplatesStatus.error) {
                      return const Center(
                          child: Text('Templates load nahi hue, dobara try karo'));
                    }
                    if (state.templates.isEmpty) {
                      return const Center(child: Text('Koi template nahi mila'));
                    }
                    return GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: state.templates.length,
                      itemBuilder: (context, index) {
                        final template = state.templates[index];
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<EditorBloc>()
                                .add(TemplateSelected(template));
                            Navigator.of(context).pop();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              template.backgroundUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
