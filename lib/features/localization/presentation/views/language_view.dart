import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_sync/core/common/constants/constants.dart';

import '../../../../config/theme/providers/theme_provider.dart';
import '../../domain/entities/language.dart';
import '../providers/language_view_model.dart';

class LanguageView extends ConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final languageState = ref.watch(languageViewModelProvider);
    final viewModel = ref.read(languageViewModelProvider.notifier);

    return
    //  languageState.when(
    //   data: (language) =>
    Scaffold(
      appBar: AppBar(title: const Text('Select Language')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Current locale: ${ref.watch(languageViewModelProvider).value?.code ?? 'en'}',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      ref.read(themeModeProvider.notifier).toggleTheme(),
                  child: const Text('Toggle Theme'),
                ),

                ElevatedButton(
                  onPressed: () =>
                      viewModel.changeLanguage(const Language(Constants.en)),
                  child: const Text('English'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      viewModel.changeLanguage(const Language(Constants.hi)),
                  child: const Text('Hindi'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      viewModel.changeLanguage(const Language(Constants.mr)),
                  child: const Text('Marathi'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    //   loading: () =>
    //       const Scaffold(body: Center(child: CircularProgressIndicator())),
    //   error: (error, stack) => Scaffold(
    //     body: Center(child: Text('Unable to load language: $error')),
    //   ),
    // );
  }
}
