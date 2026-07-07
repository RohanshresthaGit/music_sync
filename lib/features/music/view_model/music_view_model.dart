import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/track.dart';
import '../repository/music_repository.dart';

class MusicState {
  final List<Track> tracks;
  final int currentIndex;
  final bool isPlaying;

  const MusicState({
    this.tracks = const [],
    this.currentIndex = 0,
    this.isPlaying = false,
  });

  MusicState copyWith({
    List<Track>? tracks,
    int? currentIndex,
    bool? isPlaying,
  }) {
    return MusicState(
      tracks: tracks ?? this.tracks,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

final musicRepositoryProvider = Provider<MusicRepository>(
  (ref) => MockMusicRepository(),
);

final musicViewModelProvider = NotifierProvider<MusicViewModel, MusicState>(
  MusicViewModel.new,
);

class MusicViewModel extends Notifier<MusicState> {
  late final MusicRepository _repo;

  @override
  MusicState build() {
    _repo = ref.read(musicRepositoryProvider);
    // initial load
    loadTracks();
    return const MusicState();
  }

  Future<void> loadTracks() async {
    try {
      final list = await _repo.fetchTracks();
      state = state.copyWith(tracks: list);
    } catch (_) {}
  }

  void playAt(int index) {
    state = state.copyWith(currentIndex: index, isPlaying: true);
  }

  void togglePlay() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void next() {
    final nextIndex =
        (state.currentIndex + 1) %
        (state.tracks.isEmpty ? 1 : state.tracks.length);
    state = state.copyWith(currentIndex: nextIndex, isPlaying: true);
  }

  void previous() {
    final len = state.tracks.isEmpty ? 1 : state.tracks.length;
    final prev = (state.currentIndex - 1 + len) % len;
    state = state.copyWith(currentIndex: prev, isPlaying: true);
  }
}
