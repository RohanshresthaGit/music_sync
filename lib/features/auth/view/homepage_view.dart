import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_sync/features/music/view_model/music_view_model.dart';

class HomepageView extends ConsumerStatefulWidget {
  const HomepageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageViewState();
}

class _HomepageViewState extends ConsumerState<HomepageView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final musicState = ref.watch(musicViewModelProvider);
    final musicVm = ref.read(musicViewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildContent(theme, musicState, musicVm)),
            _buildBottomPlayer(theme, musicState, musicVm),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your daily mix',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    ThemeData theme,
    MusicState musicState,
    MusicViewModel musicVm,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.85),
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildFeaturedCard(theme),
          const SizedBox(height: 16),
          Expanded(child: _buildTrackList(theme, musicState, musicVm)),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daily Mix',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Artists, tracks and more tailored for you',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Play All',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackList(
    ThemeData theme,
    MusicState musicState,
    MusicViewModel musicVm,
  ) {
    final tracks = musicState.tracks;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        itemCount: tracks.length,
        separatorBuilder: (_, _) => Divider(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final track = tracks[index];
          final isActive = index == musicState.currentIndex;
          return ListTile(
            leading: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              track.title,
              style: TextStyle(
                color: isActive
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            subtitle: Text(
              track.artist,
              style: TextStyle(
                color: isActive
                    ? theme.colorScheme.onSurfaceVariant
                    : theme.colorScheme.outline,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isActive && musicState.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
                color: theme.colorScheme.primary,
                size: 32,
              ),
              onPressed: () => musicVm.playAt(index),
            ),
            onTap: () => musicVm.playAt(index),
          );
        },
      ),
    );
  }

  Widget _buildBottomPlayer(
    ThemeData theme,
    MusicState musicState,
    MusicViewModel musicVm,
  ) {
    final tracks = musicState.tracks;
    final current = tracks.isNotEmpty ? tracks[musicState.currentIndex] : null;
    return Container(
      color: theme.colorScheme.surfaceContainerHigh,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&w=800&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current?.title ?? '',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      current?.artist ?? '',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => musicVm.togglePlay(),
                icon: Icon(
                  musicState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: 0.3,
              onChanged: (_) {},
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}
