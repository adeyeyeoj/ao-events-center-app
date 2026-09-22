import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const navy = Color(0xFF071A33);
const gold = Color(0xFFD4AF37);
const bg = Color(0xFFF7F8FA);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AOEventsApp());
}

class AOEventsApp extends StatelessWidget {
  const AOEventsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AO Events Center',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: bg,
          colorScheme: ColorScheme.fromSeed(seedColor: gold),
          appBarTheme: const AppBarTheme(
            backgroundColor: navy,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        home: const AppShell(),
      );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  final pages = const [
    HomePage(),
    ExplorePage(),
    BookingWizard(),
    BookingsPage(),
    MorePage()
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() => index = i),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore),
                label: 'Explore'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'Book'),
            NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: 'Bookings'),
            NavigationDestination(
                icon: Icon(Icons.more_horiz), label: 'More'),
          ],
        ),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(children: [
              Image.asset(
  'AO_Events_Center_icon_preview.png',
  width: 52,
  height: 52,
  fit: BoxFit.contain,
),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AO EVENTS CENTER',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: .8)),
                      Text('Abijo • Lagos',
                          style: TextStyle(color: Colors.black54)),
                    ]),
              ),
              IconButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                            title: Text('Notifications'),
                            content: Text('No new notifications yet.')),
                      ),
                  icon: const Icon(Icons.notifications_none)),
            ]),
            const SizedBox(height: 20),
            Container(
              height: 310,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: navy, borderRadius: BorderRadius.circular(28)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('YOUR EVENT. OUR SPACE.',
                      style: TextStyle(
                          color: gold,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.4)),
                  const SizedBox(height: 6),
                  const Text('Make it unforgettable.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  const Text(
                      'A premium event destination for celebrations, gatherings and memorable moments.',
                      style: TextStyle(color: Colors.white70, height: 1.4)),
                  const SizedBox(height: 18),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: gold, foregroundColor: navy),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BookingWizard())),
                    child: const Text('Book Your Event'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('At a Glance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Row(children: const [
              StatCard('1,200', 'Guests', Icons.groups),
              SizedBox(width: 8),
              StatCard('500', 'Parking', Icons.local_parking),
              SizedBox(width: 8),
              StatCard('24/7', 'Power', Icons.bolt),
            ]),
            const SizedBox(height: 24),
            const Text('Popular Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: const [
              Chip(label: Text('Weddings')),
              Chip(label: Text('Birthdays')),
              Chip(label: Text('Engagements')),
              Chip(label: Text('Corporate')),
              Chip(label: Text('Conferences')),
            ]),
          ],
        ),
      );
}

class StatCard extends StatelessWidget {
  final String value, label;
  final IconData icon;
  const StatCard(this.value, this.label, this.icon, {super.key});
  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Column(children: [
            Icon(icon, color: gold, size: 22),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w900, fontSize: 19, color: navy)),
            Text(label,
                style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ]),
        ),
      );
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Explore')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Text('Discover AO Events Center',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          SizedBox(height: 20),
          ExploreCard(
  Icons.apartment,
  'The Venue',
  'A spacious event environment for up to 1,200 guests.',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VenuePage(),
      ),
    );
  },
),
    
          ExploreCard(
  Icons.auto_awesome,
  'Facilities',
  'Stage, sound, lighting, seating, changing rooms and more.',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FacilitiesPage(),
      ),
    );
  },
),
          ExploreCard(
  Icons.celebration,
  'Event Types',
  'Weddings, birthdays, engagements, corporate events and more.',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EventTypesPage(),
      ),
    );
  },
),
          ExploreCard(
  Icons.photo_library_outlined,
  'Gallery',
  'View venue spaces and approved event imagery.',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GalleryPage(),
      ),
    );
  },
),
          ExploreCard(
  Icons.location_on_outlined,
  'Contact & Location',
  'Find and contact the venue.',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LocationPage(),
      ),
    );
  },
),
        ]),
      );
}
class EventTypesPage extends StatelessWidget {
  const EventTypesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Event Types'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Celebrate Every Occasion',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'From intimate celebrations to large-scale events, '
              'AO Events Center provides a spacious and flexible setting '
              'for your special occasion.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            _eventTypeCard(
              context,
              Icons.favorite,
              'Weddings',
              'Create a beautiful and memorable wedding celebration '
                  'in a spacious event environment.',
            ),

            _eventTypeCard(
              context,
              Icons.cake,
              'Birthday Parties',
              'Celebrate birthdays with family and friends in a '
                  'comfortable and event-ready venue.',
            ),

            _eventTypeCard(
              context,
              Icons.favorite_border,
              'Engagement Parties',
              'Mark your special milestone with an elegant engagement '
                  'celebration.',
            ),

            _eventTypeCard(
              context,
              Icons.local_florist,
              'Burial Receptions',
              'A respectful and spacious setting for family gatherings '
                  'and burial receptions.',
            ),

            _eventTypeCard(
              context,
              Icons.business,
              'Corporate Events',
              'Host corporate gatherings, meetings, launches and '
                  'professional events.',
            ),

            _eventTypeCard(
              context,
              Icons.mic,
              'Conferences, Seminars & Launches',
              'A versatile venue for conferences, seminars, product '
                  'launches and other large gatherings.',
            ),
          ],
        ),
      );

  Widget _eventTypeCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: gold.withOpacity(.18),
          child: Icon(
            icon,
            color: navy,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            description,
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  Future<void> _openMaps() async {
    final uri = Uri.parse(
      'https://maps.app.goo.gl/w6XjS1X8vmZHuY55A',
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _callVenue() async {
    final uri = Uri.parse('tel:08101314792');

    await launchUrl(uri);
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse(
      'https://wa.me/2348101314792',
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _sendEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'info@aoeventcenter.com',
    );

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & Location'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Find AO Events Center',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Plan your visit, contact our team, or get directions to the venue.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: navy,
                    size: 34,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'AO Events Center',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ayodeji Oyebobola Street, Abijo G.R.A., '
                    'Logistics Pham Bus Stop, '
                    'Lekki–Epe Expressway, Lagos.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _openMaps,
                      icon: const Icon(Icons.directions),
                      label: const Text('Get Directions'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: gold.withOpacity(.18),
                    child: const Icon(
                      Icons.phone,
                      color: navy,
                    ),
                  ),
                  title: const Text(
                    'Call Us',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: const Text('08101314792'),
                  onTap: _callVenue,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: gold.withOpacity(.18),
                    child: const Icon(
                      Icons.chat,
                      color: navy,
                    ),
                  ),
                  title: const Text(
                    'WhatsApp',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: const Text('Chat with AO Events Center'),
                  onTap: _openWhatsApp,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: gold.withOpacity(.18),
                    child: const Icon(
                      Icons.email,
                      color: navy,
                    ),
                  ),
                  title: const Text(
                    'Email Us',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: const Text('info@aoeventcenter.com'),
                  onTap: _sendEmail,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gold.withOpacity(.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: navy,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap Get Directions to open the AO Events Center '
                    'location in Google Maps and navigate from your '
                    'current location.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class FacilitiesPage extends StatelessWidget {
  const FacilitiesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Facilities'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Text(
              'Everything Your Event Needs',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: navy,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'AO Events Center provides event-ready facilities designed '
              'to help create a comfortable, organized and memorable experience.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),

            _FacilityItem(
              icon: Icons.celebration_outlined,
              title: 'Stage',
              description:
                  'A dedicated stage area suitable for ceremonies, performances and presentations.',
            ),
            _FacilityItem(
              icon: Icons.graphic_eq_outlined,
              title: 'Sound System',
              description:
                  'Event-ready sound equipment to support speeches, music and entertainment.',
            ),
            _FacilityItem(
              icon: Icons.lightbulb_outline,
              title: 'Lighting',
              description:
                  'Professional event lighting to enhance the atmosphere and presentation of your occasion.',
            ),
            _FacilityItem(
              icon: Icons.chair_outlined,
              title: 'Chairs & Tables',
              description:
                  'Seating and tables available to help organize your event space.',
            ),
            _FacilityItem(
              icon: Icons.meeting_room_outlined,
              title: 'Changing Rooms',
              description:
                  'Dedicated changing areas for event hosts, celebrants and other guests.',
            ),
            _FacilityItem(
              icon: Icons.wc_outlined,
              title: 'Restrooms',
              description:
                  'Convenient restroom facilities for guests and event attendees.',
            ),
            _FacilityItem(
              icon: Icons.videocam_outlined,
              title: 'CCTV',
              description:
                  'CCTV coverage around the venue to support venue security.',
            ),
            _FacilityItem(
              icon: Icons.security_outlined,
              title: 'Security',
              description:
                  'Security arrangements to help provide a safe and comfortable event environment.',
            ),
            _FacilityItem(
              icon: Icons.bolt_outlined,
              title: '24-Hour Power',
              description:
                  'Reliable power supply to support your event throughout the day and night.',
            ),
          ],
        ),
      );
}

class _FacilityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FacilityItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: gold.withOpacity(.18),
            child: Icon(icon, color: navy),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              description,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ),
      );
}
class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final photos = [
      'assets/gallery/concept/venue-front.jpg',
      'assets/gallery/concept/venue-gate.jpg',
      'assets/gallery/concept/venue-side-1.jpg',
      'assets/gallery/concept/venue-side-2.jpg',
      'assets/gallery/concept/hall-setup-1.jpg',
      'assets/gallery/concept/hall-setup-2.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Explore AO Events Center',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Take a look at the venue concept, event spaces and visual possibilities available at AO Events Center.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: gold.withOpacity(.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: navy,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Concept / Future Visualization: Some images in this gallery are architectural renderings intended to illustrate the planned venue and event environment.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Venue & Event Spaces',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: photos.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: .85,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  photos[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
                    const SizedBox(height: 28),
          const Text(
            'Venue Videos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 14),
          GalleryVideo(
            assetPath: 'assets/gallery/videos/venue-video-1.mp4',
          ),
          const SizedBox(height: 16),
          GalleryVideo(
            assetPath: 'assets/gallery/videos/venue-video-2.mp4',
          ),
          const SizedBox(height: 16),
          GalleryVideo(
            assetPath: 'assets/gallery/videos/venue-video-3.mp4',
          ),
        ],
      ),
    );
  }
}
class GalleryVideo extends StatefulWidget {
  final String assetPath;

  const GalleryVideo({
    super.key,
    required this.assetPath,
  });

  @override
  State<GalleryVideo> createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideo> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container(
        height: 210,
        decoration: BoxDecoration(
          color: navy,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          IconButton(
            iconSize: 56,
            color: Colors.white,
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
            ),
          ),
        ],
      ),
    );
  }
}
class VenuePage extends StatelessWidget {
  const VenuePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('The Venue'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'A Venue Designed for Exceptional Events',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: navy,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'AO Events Center provides a spacious and elegant environment '
              'designed to accommodate memorable celebrations, weddings, '
              'corporate events and other special occasions.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            _VenueInfoCard(
              icon: Icons.people_outline,
              value: '1,200',
              label: 'Guest Capacity',
            ),
            _VenueInfoCard(
              icon: Icons.local_parking_outlined,
              value: '500',
              label: 'Vehicle Parking',
            ),
            _VenueInfoCard(
              icon: Icons.bolt_outlined,
              value: '24/7',
              label: 'Power Supply',
            ),

            const SizedBox(height: 12),

            const Text(
              'Why Choose AO Events Center?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: navy,
              ),
            ),
            const SizedBox(height: 12),

            const _VenueFeature(
              icon: Icons.celebration_outlined,
              title: 'Spacious Event Hall',
              text: 'A large event space suitable for intimate and large gatherings.',
            ),
            const _VenueFeature(
              icon: Icons.local_parking_outlined,
              title: 'Ample Parking',
              text: 'Convenient parking space for guests and event attendees.',
            ),
            const _VenueFeature(
              icon: Icons.bolt_outlined,
              title: '24-Hour Power',
              text: 'Reliable power supply to keep your event running smoothly.',
            ),
            const _VenueFeature(
              icon: Icons.security_outlined,
              title: 'Security & CCTV',
              text: 'Security arrangements and CCTV coverage for peace of mind.',
            ),
            const _VenueFeature(
              icon: Icons.meeting_room_outlined,
              title: 'Event-Ready Facilities',
              text: 'Stage, sound, lighting, seating, changing rooms and restrooms.',
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BookingWizard(),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text('Book Your Event'),
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                foregroundColor: navy,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
}

class _VenueInfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _VenueInfoCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: gold.withOpacity(.18),
            child: Icon(icon, color: navy),
          ),
          title: Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          subtitle: Text(label),
        ),
      );
}

class _VenueFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _VenueFeature({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: gold, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        subtitle: Text(text),
      );
}
  class ExploreCard extends StatelessWidget {
final IconData icon;
  final String title, text;
  final VoidCallback? onTap;

  const ExploreCard(
    this.icon,
    this.title,
    this.text, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: CircleAvatar(
            backgroundColor: gold.withOpacity(.18),
            child: Icon(icon, color: navy),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          subtitle: Text(text),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      );
}

class BookingData {
  String? event, date, start, end, name, email, phone, budget, notes;
  int guests = 0;
}

class BookingWizard extends StatefulWidget {
  const BookingWizard({super.key});
  @override State<BookingWizard> createState() => _BookingWizardState();
}

class _BookingWizardState extends State<BookingWizard> {
  final data = BookingData();
  int step = 0;

  bool valid() {
    if (step == 0) return data.event != null && data.guests > 0;
    if (step == 1) return data.date != null && data.start != null && data.end != null;
    if (step == 2) return
        data.name != null && data.name!.trim().isNotEmpty &&
        data.phone != null && data.phone!.trim().isNotEmpty;
    return true;
  }

  Future<void> next() async {
  if (!valid()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please complete the required fields.'),
      ),
    );
    return;
  }

  if (step < 3) {
    setState(() => step++);
    return;
  }

  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      final credential =
          await FirebaseAuth.instance.signInAnonymously();
      user = credential.user;
    }

    if (user == null) {
      throw Exception('Unable to create customer session.');
    }

    final bookingRef =
        FirebaseFirestore.instance.collection('bookings').doc();

    await bookingRef.set({
      'reference': bookingRef.id,
      'userId': user.uid,
      'eventType': data.event,
      'eventDate': data.date,
      'startTime': data.start,
      'endTime': data.end,
      'guests': data.guests,
      'budget': data.budget,
      'customerName': data.name,
      'phone': data.phone,
      'email': data.email,
      'notes': data.notes,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Request Received!'),
        content: Text(
          'Your booking request has been submitted successfully.\n\n'
          'Booking reference: ${bookingRef.id}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Unable to submit your booking. Please try again.',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Book Your Event')),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: Row(
                  children: List.generate(
                      4,
                      (i) => Expanded(
                              child: Container(
                            height: 5,
                            margin: EdgeInsets.only(right: i == 3 ? 0 : 5),
                            decoration: BoxDecoration(
                                color: i <= step ? gold : Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ))))),
          Expanded(
              child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                if (step == 0) _eventStep(),
                if (step == 1) _dateStep(),
                if (step == 2) _customerStep(),
                if (step == 3) _reviewStep(),
              ])),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                if (step > 0)
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () => setState(() => step--),
                          child: const Text('Back'))),
                if (step > 0) const SizedBox(width: 10),
                Expanded(
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: navy,
                            minimumSize: const Size.fromHeight(52)),
                        onPressed: next,
                        child: Text(step == 3 ? 'Submit Request' : 'Continue'))),
              ]))
        ]),
      );

  Widget heading(String a, String b) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(a,
              style:
                  const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
          const SizedBox(height: 7),
          Text(b),
          const SizedBox(height: 22)
        ],
      );

  Widget _eventStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Event details', 'Tell us what you are planning.'),
          DropdownButtonFormField<String>(
              value: data.event,
              decoration: const InputDecoration(labelText: 'Event type'),
              items: [
                'Wedding',
                'Birthday Party',
                'Engagement Party',
                'Burial Reception',
                'Corporate Event',
                'Conference / Seminar / Launch'
              ]
                  .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => data.event = v)),
          const SizedBox(height: 14),
          TextFormField(
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Estimated guests'),
              onChanged: (v) => data.guests = int.tryParse(v) ?? 0),
          const SizedBox(height: 14),
          TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Budget range (optional)'),
              onChanged: (v) => data.budget = v),
        ],
      );

  Widget _dateStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Date & time', 'Choose your preferred event schedule.'),
          TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'Event date',
                  suffixIcon: Icon(Icons.calendar_month)),
              controller: TextEditingController(text: data.date),
              onTap: () async {
                final d = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 730)),
                    initialDate:
                        DateTime.now().add(const Duration(days: 1)));
                if (d != null) {
                  setState(() => data.date = '${d.day}/${d.month}/${d.year}');
                }
              }),
          const SizedBox(height: 14),
          TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'Start time',
                  suffixIcon: Icon(Icons.access_time)),
              controller: TextEditingController(text: data.start),
              onTap: () async {
                final t = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 10, minute: 0));
                if (t != null) setState(() => data.start = t.format(context));
              }),
          const SizedBox(height: 14),
          TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'End time',
                  suffixIcon: Icon(Icons.access_time)),
              controller: TextEditingController(text: data.end),
              onTap: () async {
                final t = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 18, minute: 0));
                if (t != null) setState(() => data.end = t.format(context));
              }),
          const SizedBox(height: 14),
          Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: gold.withOpacity(.12),
                  borderRadius: BorderRadius.circular(14)),
              child: const Row(children: [
                Icon(Icons.info_outline, color: navy),
                SizedBox(width: 10),
                Expanded(
                    child: Text(
                        'Availability will be verified by the server before approval.'))
              ]))
        ],
      );

  Widget _customerStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Your details', 'How should AO Events Center contact you?'),
          TextFormField(
              decoration: const InputDecoration(labelText: 'Full name'),
              onChanged: (v) => data.name = v),
          const SizedBox(height: 14),
          TextFormField(
              keyboardType: TextInputType.phone,
              decoration:
                  const InputDecoration(labelText: 'Phone / WhatsApp'),
              onChanged: (v) => data.phone = v),
          const SizedBox(height: 14),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email (optional)'),
              onChanged: (v) => data.email = v),
          const SizedBox(height: 14),
          TextFormField(
              maxLines: 4,
              decoration:
                  const InputDecoration(labelText: 'Additional notes (optional)'),
              onChanged: (v) => data.notes = v),
        ],
      );

  Widget _reviewStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Review request', 'Please check your details before submitting.'),
          ReviewRow('Event', data.event ?? '-'),
          ReviewRow('Guests', data.guests.toString()),
          ReviewRow('Date', data.date ?? '-'),
          ReviewRow('Time', '${data.start ?? '-'} – ${data.end ?? '-'}'),
          ReviewRow('Name', data.name ?? '-'),
          ReviewRow('Phone', data.phone ?? '-'),
          ReviewRow('Email', (data.email == null || data.email!.isEmpty) ? '-' : data.email!),
          ReviewRow('Budget', (data.budget == null || data.budget!.isEmpty) ? '-' : data.budget!),
          const SizedBox(height: 16),
          const Text(
              'Submitting creates a booking request. The venue must confirm availability before the booking is approved.',
              style: TextStyle(color: Colors.black54)),
        ],
      );
}

class ReviewRow extends StatelessWidget {
  final String a, b;
  const ReviewRow(this.a, this.b, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0x11000000)))),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 90,
                  child: Text(a, style: const TextStyle(color: Colors.black54))),
              Expanded(child: Text(b,
                  style: const TextStyle(fontWeight: FontWeight.w700)))
            ]),
      );
}

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  Future<User?> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      final credential =
          await FirebaseAuth.instance.signInAnonymously();
      user = credential.user;
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: FutureBuilder<User?>(
        future: _getUser(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = userSnapshot.data;

          if (user == null) {
            return const Center(
              child: Text(
                'Unable to load your bookings.',
              ),
            );
          }

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('bookings')
                .where('userId', isEqualTo: user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Unable to load your bookings.',
                  ),
                );
              }

              final bookings = snapshot.data?.docs ?? [];

              if (bookings.isEmpty) {
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: const [
                    SizedBox(height: 70),
                    Icon(
                      Icons.event_note,
                      size: 72,
                      color: navy,
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Text(
                        'No bookings yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Your booking requests will appear here.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index].data();

                  final status =
                      booking['status']?.toString() ?? 'pending';

                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0x1FDFA437),
                                child: Icon(
                                  Icons.event,
                                  color: navy,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  booking['eventType']
                                          ?.toString() ??
                                      'Event',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: navy,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: gold.withOpacity(.18),
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: navy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Reference: ${booking['reference'] ?? bookings[index].id}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const Divider(height: 24),
                          _BookingInfoRow(
                            Icons.calendar_today_outlined,
                            'Date',
                            booking['eventDate']?.toString() ?? '-',
                          ),
                          _BookingInfoRow(
                            Icons.access_time,
                            'Time',
                            '${booking['startTime'] ?? '-'} - ${booking['endTime'] ?? '-'}',
                          ),
                          _BookingInfoRow(
                            Icons.groups_outlined,
                            'Guests',
                            '${booking['guests'] ?? '-'}',
                          ),
                          _BookingInfoRow(
                            Icons.payments_outlined,
                            'Budget',
                            booking['budget']?.toString() ?? '-',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _BookingInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _BookingInfoRow(
    this.icon,
    this.label,
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: navy,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('More'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'AO Events Center',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            const Text('Ayodeji Oyebobola Street, Abijo G.R.A., Lagos.'),
            const SizedBox(height: 22),

            ExploreCard(
              Icons.person_outline,
              'Profile',
              'Manage your customer details.',
            ),

            ExploreCard(
              Icons.notifications_none,
              'Notifications',
              'Booking updates and important messages.',
            ),

            ExploreCard(
              Icons.help_outline,
              'FAQs',
              'Common questions about booking and the venue.',
            ),

            ExploreCard(
              Icons.phone,
              'Contact Us',
              '08101314792 • 07046674205',
            ),

            ExploreCard(
              Icons.email_outlined,
              'Email',
              'info@aoeventcenter.com',
            ),

            ExploreCard(
              Icons.location_on_outlined,
              'Directions',
              'Find the venue.',
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0x1FDFA437),
                  child: Icon(
                    Icons.admin_panel_settings_outlined,
                    color: navy,
                  ),
                ),
                title: const Text(
                  'Staff / Admin Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: const Text(
                  'Authorized AO Events Center staff only.',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminLoginPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password.'),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('Unable to sign in.');
      }

      final adminDoc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .get();

      if (!adminDoc.exists ||
          adminDoc.data()?['role'] != 'admin') {
        await FirebaseAuth.instance.signOut();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'This account is not authorized as an admin.',
            ),
          ),
        );

        return;
      }

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Admin Login Successful'),
          content: const Text(
            'Welcome to the AO Events Center admin area.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const AdminDashboardPage(),
  ),
);
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Unable to sign in.';

      if (e.code == 'invalid-credential') {
        message = 'Incorrect email or password.';
      } else if (e.code == 'user-not-found') {
        message = 'No account was found with this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 30),

          const Icon(
            Icons.admin_panel_settings_outlined,
            size: 80,
            color: navy,
          ),

          const SizedBox(height: 20),

          const Text(
            'AO Events Center Admin',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Authorized staff only',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 35),

          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: passwordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(
                    () => obscurePassword = !obscurePassword,
                  );
                },
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: loading ? null : _login,
              child: loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
  }
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'AO Events Center Admin',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage bookings, availability, pricing and venue information.',
          ),
          const SizedBox(height: 24),
          _AdminDashboardCard(
            icon: Icons.pending_actions,
            title: 'Booking Requests',
            subtitle: 'Review and manage customer booking requests.',
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const BookingRequestsPage(),
    ),
  );
},
          ),

          _AdminDashboardCard(
            icon: Icons.calendar_month,
            title: 'Availability',
            subtitle: 'View upcoming events and available dates.',
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AvailabilityPage(),
    ),
  );
},
          ),

          _AdminDashboardCard(
            icon: Icons.payments_outlined,
            title: 'Pricing',
            subtitle: 'Adjust venue and event pricing.',
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const PricingPage(),
    ),
  );
},
          ),

          _AdminDashboardCard(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage customer notifications and updates.',
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const NotificationsPage(),
    ),
  );
},
          ),

          _AdminDashboardCard(
            icon: Icons.photo_library_outlined,
            title: 'Venue Content',
            subtitle: 'Manage gallery, facilities and event types.',
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const VenueContentPage(),
    ),
  );
},
          ),
        ],
      ),
    );
  }
}
class VenueContentPage extends StatelessWidget {
  const VenueContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Content'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Manage Venue Content',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Access and manage the content customers see in the app.',
          ),
          const SizedBox(height: 24),

          _AdminContentCard(
            icon: Icons.photo_library_outlined,
            title: 'Gallery',
            subtitle: 'Manage venue images and approved event media.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GalleryPage(),
                ),
              );
            },
          ),

          _AdminContentCard(
            icon: Icons.auto_awesome,
            title: 'Facilities',
            subtitle: 'Manage the facilities and amenities displayed to customers.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FacilitiesPage(),
                ),
              );
            },
          ),

          _AdminContentCard(
            icon: Icons.celebration_outlined,
            title: 'Event Types',
            subtitle: 'Manage the types of events supported by the venue.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EventTypesPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gold.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: navy,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'These sections control the venue information presented throughout the AO Events Center app.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminContentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AdminContentCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: gold.withOpacity(.18),
          child: Icon(
            icon,
            color: navy,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
      ),
    );
  }
}
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Unable to load notifications.',
              ),
            );
          }

          final notifications = snapshot.data?.docs ?? [];

          if (notifications.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                SizedBox(height: 70),
                Icon(
                  Icons.notifications_none,
                  size: 72,
                  color: navy,
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Customer notifications and updates will appear here.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index].data();

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: gold.withOpacity(.18),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: navy,
                    ),
                  ),
                  title: Text(
                    notification['title']?.toString() ??
                        'Notification',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      notification['message']?.toString() ?? '',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  static const pricingItems = [
    {
      'id': 'venue_hire',
      'title': 'Venue Hire',
      'subtitle': 'Set the standard venue hire price.',
      'icon': Icons.apartment_outlined,
    },
    {
      'id': 'weddings',
      'title': 'Weddings',
      'subtitle': 'Set pricing for wedding events.',
      'icon': Icons.favorite_outline,
    },
    {
      'id': 'birthday_parties',
      'title': 'Birthday Parties',
      'subtitle': 'Set pricing for birthday events.',
      'icon': Icons.cake_outlined,
    },
    {
      'id': 'corporate_events',
      'title': 'Corporate Events',
      'subtitle': 'Set pricing for corporate events.',
      'icon': Icons.business_outlined,
    },
    {
      'id': 'other_events',
      'title': 'Other Events',
      'subtitle': 'Set pricing for other event categories.',
      'icon': Icons.event_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Venue & Event Pricing',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage pricing information for different event types.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          ...pricingItems.map(
            (item) => _PricingCard(
              id: item['id']! as String,
              icon: item['icon']! as IconData,
              title: item['title']! as String,
              subtitle: item['subtitle']! as String,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gold.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: navy,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tap any pricing category to enter or update its current price. Changes are saved securely to Firebase.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String id;
  final IconData icon;
  final String title;
  final String subtitle;

  const _PricingCard({
    required this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  String _formatAmount(dynamic amount) {
    if (amount == null) return 'Price not set';

    final value = amount is num
        ? amount.toInt()
        : int.tryParse(amount.toString());

    if (value == null) return 'Price not set';

    final text = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(text[i]);
    }

    return '₦${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('pricing')
          .doc(id)
          .snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();
        final amount = data?['amount'];

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 14),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: gold.withOpacity(.18),
              child: Icon(
                icon,
                color: navy,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                amount == null
                    ? subtitle
                    : 'Current price: ${_formatAmount(amount)}',
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PricingEditorPage(
                    documentId: id,
                    title: title,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class PricingEditorPage extends StatefulWidget {
  final String documentId;
  final String title;

  const PricingEditorPage({
    super.key,
    required this.documentId,
    required this.title,
  });

  @override
  State<PricingEditorPage> createState() => _PricingEditorPageState();
}

class _PricingEditorPageState extends State<PricingEditorPage> {
  final controller = TextEditingController();
  bool loading = true;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    _loadPrice();
  }

  Future<void> _loadPrice() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('pricing')
          .doc(widget.documentId)
          .get();

      if (doc.exists) {
        final amount = doc.data()?['amount'];

        if (amount != null) {
          controller.text = amount.toString();
        }
      }
    } catch (_) {
      // The page remains usable if no price has been saved yet.
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  Future<void> _savePrice() async {
    final value = int.tryParse(
      controller.text.replaceAll(',', '').trim(),
    );

    if (value == null || value < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid price.'),
        ),
      );
      return;
    }

    setState(() => saving = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('Admin session not found.');
      }

      await FirebaseFirestore.instance
          .collection('pricing')
          .doc(widget.documentId)
          .set({
        'name': widget.title,
        'amount': value,
        'updatedBy': user.uid,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Price saved successfully.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to save price. Please try again.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => saving = false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter the current price for this category.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 28),

          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
              hintText: 'e.g. 450000',
              prefixText: '₦ ',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: loading || saving ? null : _savePrice,
              child: saving
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Save Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gold.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'This price is saved to the AO Events Center Firebase database and can be updated whenever necessary.',
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminDashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AdminDashboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: gold.withOpacity(.18),
          child: Icon(
            icon,
            color: navy,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
class AvailabilityPage extends StatelessWidget {
  const AvailabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('status', isEqualTo: 'approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Unable to load availability.',
              ),
            );
          }

          final bookings = snapshot.data?.docs ?? [];

          if (bookings.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                SizedBox(height: 70),
                Icon(
                  Icons.event_available,
                  size: 72,
                  color: navy,
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'No approved bookings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'No upcoming approved events are currently recorded.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data();

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0x1FDFA437),
                            child: Icon(
                              Icons.event_available,
                              color: navy,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              booking['eventType']?.toString() ??
                                  'Event',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: navy,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      Text(
                        'Date: ${booking['eventDate']?.toString() ?? '-'}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Time: ${booking['startTime']?.toString() ?? '-'} - ${booking['endTime']?.toString() ?? '-'}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Customer: ${booking['customerName']?.toString() ?? '-'}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Guests: ${booking['guests']?.toString() ?? '-'}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reference: ${booking['reference']?.toString() ?? bookings[index].id}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class BookingRequestsPage extends StatelessWidget {
  const BookingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Requests'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Unable to load booking requests.',
              ),
            );
          }

          final bookings = snapshot.data?.docs ?? [];

          if (bookings.isEmpty) {
            return const Center(
              child: Text(
                'No booking requests yet.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data();

              final status =
                  booking['status']?.toString() ?? 'pending';

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0x1FDFA437),
                            child: Icon(
                              Icons.event,
                              color: navy,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              booking['eventType']?.toString() ??
                                  'Event',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: navy,
                              ),
                            ),
                          ),
                          Text(
                            status.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: navy,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 28),

                      Text(
                        'Customer: ${booking['customerName'] ?? '-'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Date: ${booking['eventDate'] ?? '-'}',
                      ),

                      Text(
                        'Time: ${booking['startTime'] ?? '-'} - ${booking['endTime'] ?? '-'}',
                      ),

                      Text(
                        'Guests: ${booking['guests'] ?? '-'}',
                      ),

                      Text(
                        'Budget: ${booking['budget'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Phone: ${booking['phone'] ?? '-'}',
                      ),

                      Text(
                        'Email: ${booking['email'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Reference: ${booking['reference'] ?? bookings[index].id}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),

                      if (status == 'pending') ...[
                        const SizedBox(height: 18),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () async {
  try {
    await bookings[index].reference.update({
      'status': 'declined',
    });

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking declined successfully.'),
      ),
    );
  } catch (e) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to decline booking.'),
      ),
    );
  }
},
                                child: const Text('Decline'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
  try {
    await bookings[index].reference.update({
      'status': 'approved',
    });

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking approved successfully.'),
      ),
    );
  } catch (e) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to approve booking.'),
      ),
    );
  }
},
                                child: const Text('Approve'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
