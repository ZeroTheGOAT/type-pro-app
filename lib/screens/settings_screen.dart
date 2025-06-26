import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          color: Colors.white.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Consumer<AppState>(
              builder: (context, appState, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dark Mode', style: TextStyle(fontSize: 18)),
                      Switch(
                        value: appState.isDarkMode,
                        onChanged: appState.toggleDarkMode,
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Difficulty', style: TextStyle(fontSize: 18)),
                      DropdownButton<String>(
                        value: appState.difficulty,
                        items: const [
                          DropdownMenuItem(value: 'easy', child: Text('Easy')),
                          DropdownMenuItem(value: 'medium', child: Text('Medium')),
                          DropdownMenuItem(value: 'hard', child: Text('Hard')),
                        ],
                        onChanged: appState.setDifficulty,
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text('Challenge Modes', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 12),
                  _ChallengeToggle(
                    label: 'No Backspace',
                    value: appState.noBackspace,
                    onChanged: appState.setNoBackspace,
                  ),
                  _ChallengeToggle(
                    label: 'One Shot',
                    value: appState.oneShot,
                    onChanged: appState.setOneShot,
                  ),
                  _ChallengeToggle(
                    label: 'Invisible Input',
                    value: appState.invisibleInput,
                    onChanged: appState.setInvisibleInput,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengeToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ChallengeToggle({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
} 