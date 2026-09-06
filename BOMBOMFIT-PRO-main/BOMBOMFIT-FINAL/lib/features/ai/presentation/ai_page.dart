import 'package:flutter/material.dart';
import '../../../services/ai_service.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final input = TextEditingController();
  final messages = <Map<String, String>>[];
  bool loading = false;

  Future<void> send() async {
    final text = input.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({'role': 'user', 'text': text});
      input.clear();
      loading = true;
    });
    final answer = await AiService().ask(text);
    if (!mounted) return;
    setState(() {
      messages.add({'role': 'assistant', 'text': answer});
      loading = false;
    });
  }

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Coach IA')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (_, i) {
                  final m = messages[i];
                  return Align(
                    alignment: m['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                    child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Text(m['text']!))),
                  );
                },
              ),
            ),
            if (loading) const LinearProgressIndicator(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(child: TextField(controller: input, decoration: const InputDecoration(hintText: 'Pergunte ao Coach IA…'))),
                    IconButton(onPressed: loading ? null : send, icon: const Icon(Icons.send)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
