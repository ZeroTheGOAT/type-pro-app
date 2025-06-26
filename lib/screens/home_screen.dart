import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TypePro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            _GlassCard(
              title: 'Sentence Practice',
              subtitle: 'Practice typing with random prompts',
              icon: Icons.text_snippet_rounded,
              onTap: () => Navigator.pushNamed(context, '/game', arguments: {'mode': 'sentence'}),
            ),
            const SizedBox(height: 24),
            _GlassCard(
              title: 'A–Z Challenge',
              subtitle: 'Type all letters as fast as possible',
              icon: Icons.keyboard_alt_rounded,
              onTap: () => Navigator.pushNamed(context, '/game', arguments: {'mode': 'az'}),
            ),
            const SizedBox(height: 24),
            _GlassCard(
              title: 'Challenge Modes',
              subtitle: 'Try No Backspace, One Shot, Invisible Input',
              icon: Icons.flash_on_rounded,
              onTap: () => Navigator.pushNamed(context, '/game', arguments: {'mode': 'challenge'}),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _GlassCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _GlassCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  State<_GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<_GlassCard> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(_pressed ? 0.7 : 0.5),
              Colors.blueAccent.withOpacity(_pressed ? 0.18 : 0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(_pressed ? 0.08 : 0.16),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon, size: 36, color: Colors.blueAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.blueGrey,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blueAccent, size: 20),
          ],
        ),
      ),
    );
  }
} 