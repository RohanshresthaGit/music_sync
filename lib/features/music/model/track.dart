class Track {
  final String id;
  final String title;
  final String artist;
  final String? artUrl;

  Track({
    required this.id,
    required this.title,
    required this.artist,
    this.artUrl,
  });

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      artist: map['artist']?.toString() ?? '',
      artUrl: map['artUrl']?.toString(),
    );
  }
}
