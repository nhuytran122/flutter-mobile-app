import 'package:flutter/material.dart';

// void main() {
//   runApp(const NewsApp());
// }

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Flutter',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'News',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            // Category Tabs
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryTab('Business', true),
                  _buildCategoryTab('FlutterNews', false),
                  _buildCategoryTab('General', false),
                ],
              ),
            ),

            // News List
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildNewsItem(
                    'Nokia 8.2, Nokia 5.3, Nokia 1.3 Expected to Launch Today: How to Watch Live',
                    'The event was slated to be held in London, but HMD Global cancelled it and converted it into an online-only...',
                    'assets/nokia.jpg',
                    largeImage: true,
                  ),
                  _buildNewsItem(
                    'SC slams Centre and telcos for not complying with its order on AGR payment',
                    'India Business News: A bench of Justice Arun Mishra, Justice S A Nazeer and Justice M R Shah questioned the...',
                    'assets/court.jpg',
                  ),
                  _buildNewsItem(
                    'Visitors Relatives',
                    'Latest updates and news coverage',
                    'assets/visitors.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String text, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsItem(String title, String subtitle, String imageUrl,
      {bool largeImage = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: largeImage ? 200 : 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),

          // News Title
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),

          // News Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
