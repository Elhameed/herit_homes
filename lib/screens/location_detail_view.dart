import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Location',
                ),
                controller: TextEditingController(text: 'Nigeria'),
                readOnly: true,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ImageTile(
                    imagePath: 'assets/nigeria_image1.png',
                    url: 'https://shorturl.at/qSMts',
                  ),
                  ImageTile(
                    imagePath: 'assets/nigeria_image2.png',
                    url: 'https://shorturl.at/Gff4p',
                  ),
                  ImageTile(
                    imagePath: 'assets/nigeria_image3.png',
                    url: 'https://shorturl.at/dP03j',
                  ),
                  ImageTile(
                    imagePath: 'assets/nigeria_image4.png',
                    url: 'https://shorturl.at/EYw95',
                  ),
                  ImageTile(
                    imagePath: 'assets/nigeria_image5.png',
                    url: 'https://shorturl.at/eo7QT',
                  ),
                  ImageTile(
                    imagePath: 'assets/nigeria_image6.png',
                    url: 'https://shorturl.at/epRXG',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Clear all'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: Icon(Icons.search),
                  label: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(150, 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageTile extends StatefulWidget {
  final String imagePath;
  final String url;

  ImageTile({required this.imagePath, required this.url});

  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            if (_isHovered)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Read more',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }
}
