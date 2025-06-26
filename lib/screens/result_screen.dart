import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final wpm = args?['wpm'] ?? 0;
    final accuracy = args?['accuracy'] ?? 0;
    final errors = args?['errors'] ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          color: Colors.white.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your Results', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _AnimatedStat(label: 'WPM', value: wpm.toString()),
                    _AnimatedStat(label: 'Accuracy', value: '$accuracy%'),
                    _AnimatedStat(label: 'Errors', value: errors.toString()),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/game'),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 800.ms),
      ),
    );
  }
}

class _AnimatedStat extends StatelessWidget {
  final String label;
  final String value;
  const _AnimatedStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ).animate().fadeIn(duration: 600.ms),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
        ),
      ],
    );
  }
} 