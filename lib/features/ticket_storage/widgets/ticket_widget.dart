import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/ticket.dart';

class TicketWidget extends StatefulWidget {
  final Ticket ticket;

  const TicketWidget({Key? key, required this.ticket}) : super(key: key);

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Text(widget.ticket.name.substring(0, 5)),
          Text(widget.ticket.pdfFileName.substring(0, 5)),
          Text(widget.ticket.isLoaded.toString().substring(0, 5)),
        ],
      ),
    );
  }
}
