import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golocal/src/event/domain/event.dart';
import 'package:golocal/src/event/domain/location.dart';
import 'package:golocal/src/event/shared/badge_widget.dart';
import 'package:golocal/src/shared/extensions.dart';
import 'package:golocal/src/user/domain/user.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(149, 255, 255, 255),
        elevation: 0,
        title: Text(
          event.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.info, color: Colors.white),
          //   onPressed: () {
          //     return; // TODO: Disabled for now
          //     context.push('/events/${event.id}/info');
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.report, color: Colors.red),
            onPressed: () {
              context.push('/events/${event.id}/report', extra: event);
            },
          ),
          IconButton(
              onPressed: () {
                context.push('/events/${event.id}/promote', extra: event);
              },
              icon: const Icon(Icons.arrow_circle_up, color: Colors.yellow)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imageWithOverlay(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  const SizedBox(height: 8),
                  _buildTags(),
                  _buildDetailCard("📝 Description", [event.description]),
                  const SizedBox(height: 12),
                  _buildDetailCard("📅 Starts at",
                      [event.startDate.formatReadableDate(includeTime: true)]),
                  if (event.endDate != null)
                    _buildDetailCard("⏳ Ends at",
                        [event.endDate!.formatReadableDate(includeTime: true)]),
                  _buildDetailCard(
                    "📍 Location",
                    event.location != null ? [_formatLocation(event)] : null,
                    onTap: () {
                      if (event.location != null) {
                        _launchMaps(event.location!);
                      }
                      return null;
                    },
                  ),
                  _buildDetailCard("👥 Organized by", null,
                      widgets: event.eventOrganizers
                          .map((user) => Row(
                                children: [
                                  _buildAvatars(user),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${user.firstName} ${user.lastName}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ))
                          .toList()),
                  const SizedBox(height: 12),
                  _buildVotesCard(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageWithOverlay() {
    return Stack(
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: event.hasImage
                  ? NetworkImage(event.imageUrl!) as ImageProvider
                  : const AssetImage("assets/images/image_not_found.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Row(
            children: [
              if (event.isAdultOnly)
                BadgeWidget(text: "18+", backgroundColor: Colors.redAccent),
              if (event.isPromoted)
                BadgeWidget(text: "Promoted", backgroundColor: Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      event.title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDetailCard(String label, List<String>? values,
      {Future<void>? Function()? onTap, List<Widget>? widgets}) {
    if ((values == null || values.isEmpty) && widgets == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 6),
              if (widgets != null) ...widgets,
              if (values != null && values.isNotEmpty)
                Text(
                  values.join(', '),
                  style: const TextStyle(fontSize: 14.0, color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatars(User user) {
    if (user.avatarUrl == null) {
      return const CircleAvatar(
        radius: 16,
        child: Icon(Icons.person),
      );
    }
    return CircleAvatar(
      radius: 16,
      backgroundImage: NetworkImage(user.avatarUrl!),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 6,
      children: event.tags
          .map(
            (tag) => Chip(
              label: Text(tag.name),
              backgroundColor: Colors.blueGrey.withValues(alpha: 0.2),
              labelStyle: const TextStyle(color: Colors.black87),
            ),
          )
          .toList(),
    );
  }

  Widget _buildVotesCard(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "🗳 Related Votes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                context.push('/events/${event.id}/votes', extra: event);
              },
              child: const Text("View Votes", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchMaps(Location location) async {
    String url;
    final String address;
    if (location.coords != null) {
      final latitude = location.coords!.latitude;
      final longitude = location.coords!.longitude;
      address = '$latitude,$longitude';
    } else if (location.address != null) {
      address =
          "${location.address!.streetNumber},${location.address!.street},${location.city},${location.country}";
    } else {
      return;
    }
    //TODO: fix the querry
    url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  String _formatLocation(Event event) {
    return "${event.location!.city}, ${event.location!.country}";
  }
}
