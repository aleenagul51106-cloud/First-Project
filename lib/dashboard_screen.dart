
import 'package:flutter/material.dart';

// LinkedIn's signature blue
const Color kLinkedInBlue = Color(0xFF0A66C2);
const Color kBackground = Color(0xFFF4F2EE);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            profileCard(),
            const SizedBox(height: 10),
            statsRow(),
            const SizedBox(height: 10),
            startPostCard(),
            const SizedBox(height: 10),
            quickActionsCard(),
            const SizedBox(height: 10),
            sectionHeader("Recent Activity"),
            const SizedBox(height: 8),
            feedPost(
              name: "Sarah Khan",
              headline: "Senior Recruiter at TechCorp • 1st",
              time: "2h",
              content:
              "Excited to share that our team is hiring Flutter Developers! "
                  "If you know great mobile talent, send them my way. #hiring #flutter",
              likes: 128,
              comments: 24,
            ),
            feedPost(
              name: "Aleena",
              headline: "Flutter Developer",
              time: "Yesterday",
              content:
              "Just shipped a new update to my app with a fresh dashboard UI. "
                  "Loving how Flutter makes custom design so smooth to build!",
              likes: 340,
              comments: 52,
            ),
            feedPost(
              name: "Ahmed Raza",
              headline: "Mobile App Engineer at Devsinc",
              time: "2d",
              content:
              "Shared a new article on state management patterns in Flutter. "
                  "Check it out and let me know your thoughts!",
              likes: 210,
              comments: 18,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ---------------- APP BAR ----------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      titleSpacing: 10,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: kLinkedInBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: const Text(
              "in",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.black54, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Search",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.mail_outline, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_filled, "label": "Home"},
      {"icon": Icons.people_alt_outlined, "label": "My Network"},
      {"icon": Icons.add_box_outlined, "label": "Post"},
      {"icon": Icons.notifications_none, "label": "Notifications"},
      {"icon": Icons.work_outline, "label": "Jobs"},
    ];

    return BottomAppBar(
      color: Colors.white,
      elevation: 4,
      child: SizedBox(
        height: 58,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final selected = index == _selectedTab;
            return InkWell(
              onTap: () => setState(() => _selectedTab = index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    items[index]["icon"] as IconData,
                    color: selected ? Colors.black : Colors.black54,
                    size: 24,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    items[index]["label"] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: selected ? Colors.black : Colors.black54,
                      fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // ---------------- PROFILE CARD ----------------
  Widget profileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover banner
          Container(
            height: 60,
            width: double.infinity,
            color: kLinkedInBlue.withOpacity(0.85),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const CircleAvatar(
                          radius: 34,
                          backgroundColor: Color(0xFFBFE0FF),
                          child: Text(
                            "A",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: kLinkedInBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Aleena",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Flutter Developer | Building clean mobile experiences",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Islamabad, Pakistan",
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile viewers",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    Text(
                      "3,450",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: kLinkedInBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Post impressions",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    Text(
                      "1,250",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: kLinkedInBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- STATS ROW ----------------
  Widget statsRow() {
    return Row(
      children: [
        Expanded(
          child: statCard(Icons.people, "Connections", "1,250", kLinkedInBlue),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: statCard(
              Icons.work_outline, "Jobs Applied", "32", Colors.orange),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: statCard(
              Icons.person_add_alt, "Followers", "890", Colors.green),
        ),
      ],
    );
  }

  Widget statCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // ---------------- START A POST ----------------
  Widget startPostCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFBFE0FF),
                child: Text(
                  "A",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kLinkedInBlue,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Start a post",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              postAction(Icons.image_outlined, "Photo", Colors.blue),
              postAction(Icons.videocam_outlined, "Video", Colors.green),
              postAction(Icons.article_outlined, "Article", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget postAction(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
      ],
    );
  }

  // ---------------- QUICK ACTIONS ----------------
  Widget quickActionsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          actionButton(Icons.edit_outlined, "Edit Profile"),
          actionButton(Icons.post_add, "New Post"),
          actionButton(Icons.work_outline, "Find Jobs"),
          actionButton(Icons.chat_bubble_outline, "Messages"),
        ],
      ),
    );
  }

  Widget actionButton(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: kLinkedInBlue.withOpacity(0.1),
          child: Icon(icon, color: kLinkedInBlue, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  // ---------------- SECTION HEADER ----------------
  Widget sectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ---------------- FEED POST (LinkedIn-style card) ----------------
  Widget feedPost({
    required String name,
    required String headline,
    required String time,
    required String content,
    required int likes,
    required int comments,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: kLinkedInBlue.withOpacity(0.15),
                child: Text(
                  name.substring(0, 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kLinkedInBlue,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      headline,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.thumb_up, size: 16, color: kLinkedInBlue),
              const SizedBox(width: 4),
              Text(
                "$likes",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const Spacer(),
              Text(
                "$comments comments",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              feedButton(Icons.thumb_up_outlined, "Like"),
              feedButton(Icons.comment_outlined, "Comment"),
              feedButton(Icons.repeat, "Repost"),
              feedButton(Icons.send_outlined, "Send"),
            ],
          ),
        ],
      ),
    );
  }

  Widget feedButton(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}