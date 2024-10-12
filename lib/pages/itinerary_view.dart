import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ItineraryView extends StatefulWidget {
  const ItineraryView({super.key});

  @override
  State<ItineraryView> createState() => _ItineraryViewState();
}

class _ItineraryViewState extends State<ItineraryView> {
  String _markdownString = "";

  Future<void> _loadMarkdownFile() async {
    final header = await rootBundle.loadString('assets/sample.md');

    var itinbox = Hive.box('generated_itinerary');
    String? itinerary = itinbox.get('itinerary');

    if (itinerary != null) {
      setState(() {
        _markdownString = "$header\n$itinerary";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadMarkdownFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Itinerary'),
        // add actions to regenerate and go back to the last page
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _loadMarkdownFile();
            },
          ),
          // download as pdf button
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // download the itinerary as pdf
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     // go to Budget page
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const Budget(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: _markdownString.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: MarkdownWidget(
                data: _markdownString,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
