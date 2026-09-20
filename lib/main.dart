import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const navy = Color(0xFF071A33);
const gold = Color(0xFFD4AF37);
const bg = Color(0xFFF7F8FA);

void main() => runApp(const AOEventsApp());

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
          ExploreCard(Icons.location_on_outlined, 'Contact & Location',
              'Find and contact the venue.'),
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

  void next() {
    if (!valid()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete the required fields.')));
      return;
    }
    if (step < 3) {
      setState(() => step++);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                title: const Text('Request Received!'),
                content: const Text(
                    'Your booking request has been prepared. A unique reference will be generated when the live backend is connected.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Done'))
                ],
              ));
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

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My Bookings')),
        body: ListView(padding: const EdgeInsets.all(20), children: const [
          SizedBox(height: 70),
          Icon(Icons.event_note, size: 72, color: navy),
          SizedBox(height: 15),
          Center(
              child: Text('No bookings yet',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800))),
          SizedBox(height: 8),
          Center(child: Text('Your booking requests will appear here.')),
        ]),
      );
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('More')),
        body: ListView(padding: const EdgeInsets.all(20), children: const [
          Text('AO Events Center',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          SizedBox(height: 6),
          Text('Ayodeji Oyebobola Street, Abijo G.R.A., Lagos.'),
          SizedBox(height: 22),
          ExploreCard(Icons.person_outline, 'Profile',
              'Manage your customer details.'),
          ExploreCard(Icons.notifications_none, 'Notifications',
              'Booking updates and important messages.'),
          ExploreCard(Icons.help_outline, 'FAQs', 'Common questions.'),
          ExploreCard(Icons.phone, 'Contact Us',
              '08101314792 • 07046674205'),
          ExploreCard(Icons.email_outlined, 'Email', 'info@aoeventcenter.com'),
          ExploreCard(Icons.location_on_outlined, 'Directions',
              'Find the venue.'),
        ]),
      );
}
