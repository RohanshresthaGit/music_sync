import '../model/track.dart';

abstract class MusicRepository {
  Future<List<Track>> fetchTracks();
}

/// A temporary mock implementation so the UI works without a backend.
class MockMusicRepository implements MusicRepository {
  @override
  Future<List<Track>> fetchTracks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.generate(
      8,
      (i) => Track(
        id: '${i + 1}',
        title: 'Track ${i + 1}',
        artist: 'Artist ${i + 1}',
        artUrl: null,
      ),
    );
  }
}
