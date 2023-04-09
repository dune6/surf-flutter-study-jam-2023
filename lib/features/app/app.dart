import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/ticket_storage_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@dune6/surf_flutter_study_jam_2023',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TicketStoragePage(),
    );
  }
}
