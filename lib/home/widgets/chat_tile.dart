import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chatId,
    this.onTap,
    this.onDelete,
    required this.name,
    required this.lastMessage,
  });

  final String chatId;
  final GestureTapCallback? onTap;
  final SlidableActionCallback? onDelete;
  final String name;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text(lastMessage),
      ),
    );
  }
}
