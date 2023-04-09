import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/assets/strings/ticket_storage_strings.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(TicketStorageStrings.appBarTitle),
        ),
        floatingActionButton: SizedBox(
          height: 60,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text(TicketStorageStrings.floatingActionButtonTitle),
          ),
        ),
        body: const SafeArea(
          child: Center(
              child: Text(
            TicketStorageStrings.emptyPageTitle,
            style: TextStyle(fontSize: 18),
          )),
        ));
  }
}
