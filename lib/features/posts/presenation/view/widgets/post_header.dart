import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/utils/formatPostDate.dart';

class PostHeader extends StatelessWidget {
  final DateTime dateAdded;
  const PostHeader({super.key, 
    required this.dateAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  UniconsLine.user,
                  size: 18,
                  color: Color.fromARGB(255, 35, 47, 103),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Username',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Row(
            children: [
              Text(formatPostDate(dateAdded)),
              IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PostSettingDialog();
                    },
                  );
                },
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                constraints: const BoxConstraints(maxHeight: 40),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  size: 18,
                  color: Color.fromARGB(255, 35, 47, 103),
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostSettingDialog extends StatelessWidget {
  const PostSettingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary
          ),
          child: Card(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Report'),
                  onTap: () {
                    // Handle 'Report' button tap
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.copy),
                  title: const Text('Copy link'),
                  onTap: () {
                    // Handle 'Copy link' button tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
