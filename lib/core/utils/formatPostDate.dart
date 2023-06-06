import 'package:intl/intl.dart';

String formatPostDate(DateTime dateAdded) {
  final now = DateTime.now();
  final difference = now.difference(dateAdded);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} sec ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  }else if (difference.inDays < 30) {
    return '${difference.inDays} days ago';
  }  else {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateAdded);
  }
}
