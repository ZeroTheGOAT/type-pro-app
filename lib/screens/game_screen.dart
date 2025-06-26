import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String prompt = '';
  String userInput = '';
  int errors = 0;
  int correctChars = 0;
  int totalChars = 0;
  int wpm = 0;
  int accuracy = 100;
  bool started = false;
  bool finished = false;
  Timer? timer;
  int seconds = 0;
  late AppState appState;
  late FocusNode focusNode;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPrompt());
  }

  @override
  void dispose() {
    timer?.cancel();
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  Future<void> _loadPrompt() async {
    appState = Provider.of<AppState>(context, listen: false);
    final data = await rootBundle.loadString('assets/sentences.json');
    final jsonData = json.decode(data);
    List<String> prompts = [];
    if (ModalRoute.of(context)?.settings.arguments is Map) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      if (args['mode'] == 'az') {
        prompt = 'abcdefghijklmnopqrstuvwxyz';
      } else {
        prompts = List<String>.from(jsonData[appState.difficulty] ?? []);
        prompt = (prompts..shuffle()).first;
      }
    } else {
      prompts = List<String>.from(jsonData[appState.difficulty] ?? []);
      prompt = (prompts..shuffle()).first;
    }
    setState(() {
      userInput = '';
      errors = 0;
      correctChars = 0;
      totalChars = prompt.length;
      wpm = 0;
      accuracy = 100;
      started = false;
      finished = false;
      seconds = 0;
    });
    textController.clear();
    focusNode.requestFocus();
  }

  void _onChanged(String value) {
    if (!started && value.isNotEmpty) {
      started = true;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          seconds++;
          _updateStats();
        });
      });
    }
    
    if (finished) return;
    
    // Handle challenge modes
    if (appState.noBackspace && value.length < userInput.length) {
      // No backspace allowed - restore previous input
      textController.text = userInput;
      textController.selection = TextSelection.fromPosition(
        TextPosition(offset: userInput.length),
      );
      return;
    }
    
    if (appState.oneShot && value.length > userInput.length) {
      // If mistake, end test immediately
      int idx = value.length - 1;
      if (idx < prompt.length && value[idx] != prompt[idx]) {
        setState(() {
          finished = true;
        });
        timer?.cancel();
        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.pushReplacementNamed(context, '/result', arguments: {
            'wpm': wpm,
            'accuracy': accuracy,
            'errors': errors,
          });
        });
        return;
      }
    }
    
    setState(() {
      userInput = value;
      _updateStats();
      
      // Check for completion - entire prompt typed correctly
      if (userInput == prompt) {
        finished = true;
        timer?.cancel();
        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.pushReplacementNamed(context, '/result', arguments: {
            'wpm': wpm,
            'accuracy': accuracy,
            'errors': errors,
          });
        });
      }
    });
  }

  void _updateStats() {
    correctChars = 0;
    errors = 0;
    for (int i = 0; i < userInput.length; i++) {
      if (i < prompt.length && userInput[i] == prompt[i]) {
        correctChars++;
      } else {
        errors++;
      }
    }
    accuracy = userInput.isEmpty ? 100 : ((correctChars / userInput.length) * 100).round();
    wpm = seconds == 0 ? 0 : ((userInput.split(' ').length / seconds) * 60).round();
  }

  void _retry() {
    timer?.cancel();
    _loadPrompt();
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Colors.white.withOpacity(0.7),
            child: Container(
              width: 500,
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PromptText(prompt: prompt, userInput: userInput),
                  const SizedBox(height: 32),
                  TextField(
                    controller: textController,
                    focusNode: focusNode,
                    enabled: !finished,
                    onChanged: _onChanged,
                    obscureText: appState.invisibleInput,
                    style: const TextStyle(fontSize: 20, letterSpacing: 1.2),
                    decoration: InputDecoration(
                      hintText: 'Start typing...',
                      errorText: finished && userInput != prompt ? 'Try again!' : null,
                    ),
                    autofocus: true,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                  ),
                  const SizedBox(height: 32),
                  LinearProgressIndicator(
                    value: userInput.isEmpty ? 0 : (userInput.length / prompt.length).clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: Colors.blueGrey.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatBox(label: 'WPM', value: wpm.toString()),
                      _StatBox(label: 'Accuracy', value: '$accuracy%'),
                      _StatBox(label: 'Errors', value: errors.toString()),
                      _StatBox(label: 'Time', value: '${seconds}s'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
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

class _PromptText extends StatelessWidget {
  final String prompt;
  final String userInput;
  const _PromptText({required this.prompt, required this.userInput});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    for (int i = 0; i < prompt.length; i++) {
      Color color;
      if (i < userInput.length) {
        color = userInput[i] == prompt[i]
            ? Colors.blueAccent
            : Colors.redAccent;
      } else {
        color = Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
      }
      spans.add(TextSpan(
        text: prompt[i],
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 22,
          shadows: color == Colors.blueAccent
              ? [const Shadow(blurRadius: 8, color: Colors.blueAccent)]
              : null,
        ),
      ));
    }
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: spans,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
        ),
      ],
    );
  }
} 