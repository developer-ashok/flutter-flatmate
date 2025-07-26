import 'package:flutter/material.dart';
import '../models/message.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _getDemoConversations().length,
        itemBuilder: (context, index) {
          final conversation = _getDemoConversations()[index];
          return ConversationCard(conversation: conversation);
        },
      ),
    );
  }

  List<Conversation> _getDemoConversations() {
    return [
      Conversation(
        id: '1',
        participantName: 'Sarah Johnson',
        participantAvatar: '👩‍💼',
        lastMessage: 'Hi! I saw your post about looking for roommates. Is it still available?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 1,
        postTitle: 'Looking for roommates in Downtown',
      ),
      Conversation(
        id: '2',
        participantName: 'Mike Chen',
        participantAvatar: '👨‍🎓',
        lastMessage: 'Thanks for the quick response! When can we meet?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
        postTitle: 'Spacious room available in student area',
      ),
      Conversation(
        id: '3',
        participantName: 'Emma Davis',
        participantAvatar: '👩‍🎨',
        lastMessage: 'The apartment looks perfect! Can you send me more photos?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 2,
        postTitle: 'Cozy studio in West Side',
      ),
      Conversation(
        id: '4',
        participantName: 'Alex Thompson',
        participantAvatar: '👨‍💻',
        lastMessage: 'I\'m interested in teaming up for apartment hunting. Are you still looking?',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        postTitle: 'Looking for apartment hunting partner',
      ),
      Conversation(
        id: '5',
        participantName: 'Lisa Wang',
        participantAvatar: '👩‍🏫',
        lastMessage: 'Perfect! Let\'s meet tomorrow at 3 PM.',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 0,
        postTitle: 'Student looking for room in University District',
      ),
    ];
  }
}

class Conversation {
  final String id;
  final String participantName;
  final String participantAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String postTitle;

  Conversation({
    required this.id,
    required this.participantName,
    required this.participantAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.postTitle,
  });
}

class ConversationCard extends StatelessWidget {
  final Conversation conversation;

  const ConversationCard({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Text(
            conversation.participantAvatar,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                conversation.participantName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (conversation.unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  conversation.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conversation.postTitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              conversation.lastMessage,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: conversation.unreadCount > 0 ? Colors.black87 : Colors.grey[600],
                fontWeight: conversation.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
        trailing: Text(
          _getTimeAgo(conversation.lastMessageTime),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(conversation: conversation),
            ),
          );
        },
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}

class ChatScreen extends StatefulWidget {
  final Conversation conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(_getDemoMessages());
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          chatId: widget.conversation.id,
          senderUid: 'currentUser',
          text: _messageController.text.trim(),
          sentAt: DateTime.now(),
        ));
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.conversation.participantName),
            Text(
              widget.conversation.postTitle,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More options coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message.senderUid == 'currentUser';
                return MessageBubble(message: message, isMe: isMe);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Message> _getDemoMessages() {
    return [
      Message(
        id: '1',
        chatId: widget.conversation.id,
        senderUid: widget.conversation.id,
        text: 'Hi! I saw your post about looking for roommates. Is it still available?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Message(
        id: '2',
        chatId: widget.conversation.id,
        senderUid: 'currentUser',
        text: 'Yes, it\'s still available! Are you interested?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      Message(
        id: '3',
        chatId: widget.conversation.id,
        senderUid: widget.conversation.id,
        text: 'Definitely! Can you tell me more about the apartment and your current roommates?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Message(
        id: '4',
        chatId: widget.conversation.id,
        senderUid: 'currentUser',
        text: 'Of course! It\'s a 3-bedroom apartment in Downtown. Currently, there are 2 of us - both professionals in our late 20s. We\'re looking for someone who is clean and respectful.',
        sentAt: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Message(
        id: '5',
        chatId: widget.conversation.id,
        senderUid: widget.conversation.id,
        text: 'That sounds perfect! I\'m also a professional and very clean. When can we meet to discuss further?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
    ];
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe 
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[200],
          borderRadius: BorderRadius.circular(18),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _getTimeString(message.sentAt),
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeString(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
} 