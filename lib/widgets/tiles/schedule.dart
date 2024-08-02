import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScheduleTile extends StatefulWidget {
  const ScheduleTile({
    super.key,
    required this.deleteOnPressed,
    required this.shareOnPressed,
    required this.chatOnPressed, required this.onTap,
  });

  final Function(BuildContext) deleteOnPressed;
  final Function(BuildContext) shareOnPressed;
  final Function(BuildContext) chatOnPressed;
  final VoidCallback onTap;

  @override
  State<ScheduleTile> createState() => _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile>
    with SingleTickerProviderStateMixin {
  late SlidableController controller;
  bool isOpen = false;

  @override
  void initState() {
    controller = SlidableController(this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: controller,
      endActionPane: ActionPane(
        dragDismissible: false,
        extentRatio: 1/2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.chat,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          if(isOpen){
            controller.close();
          }else{
            widget.onTap();
          }
        },
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        trailing: IconButton(
          onPressed: () {
            if (isOpen) {
              setState(() {
                controller.close();
                isOpen = false;
              });

            } else{
              controller.openEndActionPane();
              isOpen = true;
            }


          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text("아이템"),
        ),
      ),
    );
  }
}
