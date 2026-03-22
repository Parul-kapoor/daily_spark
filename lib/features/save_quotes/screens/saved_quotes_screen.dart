import 'package:flutter/material.dart';

class SavedQuotesScreen extends StatefulWidget {
  final List<String> savedQuotes;
  final Function(String) onDelete;

  const SavedQuotesScreen({
    super.key,
    required this.savedQuotes,
    required this.onDelete,
  });

  @override
  State<SavedQuotesScreen> createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {

  late List<String> localQuotes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localQuotes = List.from(widget.savedQuotes);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Quotes')),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: widget.savedQuotes.isEmpty
          ? const Center(child: Text('No saved quotes yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.savedQuotes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.savedQuotes[index],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              localQuotes.removeAt(index);
                            });
                            widget.onDelete(widget.savedQuotes[index]);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
