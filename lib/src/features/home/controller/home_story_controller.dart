import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:video_player/video_player.dart';
import '../model/story_model.dart';
import '../repository/home_story_repository.dart';

class HomeStoryController extends ChangeNotifier {
  final HomeStoryRepository _repository = HomeStoryRepository();
  List<StoryItem> _postList = [];
  List<StoryItem> get postList => _postList;

  Future<void> fetchOwnStory() async {
    try {
      final response = await _repository.fetchOwnStory();
      if (response.isNotEmpty) {
        _postList = response.map((story) {
          final StoryController controller = StoryController();

          if (story.mediaType == 'video') {
            return StoryItem.pageVideo(
              story.mediaUrl,
              controller: controller,
            );
          }
          return StoryItem.pageImage(
            url: story.mediaUrl,
            controller: controller,
          );
        }).toList();
        // postList
      } else {
        log('Failed to fetch Posts data');
      }
    } catch (e) {
      log('Error fetching user data: $e');
    } finally {
      notifyListeners();
    }
  }

  List<StoryItemss> storiess = [
    StoryItemss(
      url:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isVideo: false,
    ),
    StoryItemss(
      url:
          'https://media.istockphoto.com/id/1999341160/video/close-up-of-young-australian-fur-seals-playing-in-clear-blue-open-ocean-water.mp4?s=mp4-640x640-is&k=20&c=XTMiDRR7mH4E4dm1twOkCDdrmviZOZfPsgZIY0aYmkE=',
      isVideo: true,
    ),
  ];

  int _currentIndex = 0;
  Timer? _timer;
  double _progress = 0.0;
  VideoPlayerController? _videoController;
  List<double> _progressList = [];
  bool _isLoading = true;
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;
  double get progress => _progress;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  List<double> get progressList => _progressList;
  VideoPlayerController? get videoController => _videoController;

  HomeStoryController() {
    resetStories(); // Call reset on initialization to start fresh
  }

  @override
  void dispose() {
    _timer?.cancel();
    _videoController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Reset the progress, currentIndex, and progressList to start fresh
  void resetStories() {
    _progressList = List.generate(storiess.length, (index) => 0.0);
    _currentIndex = 0; // Reset the story index
    _startTimer(storiess[_currentIndex]); // Start the first story
  }

  void _startTimer(StoryItemss currentItem) {
    _timer?.cancel();
    _progress = 0.0;
    _progressList[_currentIndex] = 0.0;
    notifyListeners();

    if (currentItem.isVideo) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.network(currentItem.url)
        ..initialize().then((_) {
          _videoController!.play();
          _isLoading = false;
          notifyListeners();

          _timer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
            if (_videoController!.value.isInitialized) {
              final maxTicks =
                  _videoController!.value.duration.inMilliseconds / 100;
              _progress = timer.tick / maxTicks;
              _progressList[_currentIndex] = _progress;

              if (_progress >= 1.0 || !_videoController!.value.isPlaying) {
                nextStory(); // Move to the next story after completion
              }
              notifyListeners();
            }
          });
        }).catchError((error) {
          nextStory();
        });
    } else {
      _isLoading = false;
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _progress = timer.tick / 100; // 10 seconds
        _progressList[_currentIndex] = _progress;
        if (_progress >= 1.0) {
          nextStory();
        }
        notifyListeners();
      });
    }
  }

  void nextStory() {
    if (_currentIndex < storiess.length - 1) {
      _timer?.cancel();
      _progressList[_currentIndex] = 1.0;
      _currentIndex++;
      _progress = 0.0;
      _progressList[_currentIndex] = 0.0;
      _isLoading = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        _startTimer(storiess[_currentIndex]);
      });
    } else {
      // All stories are finished; return to home screen.
      _navigateToHome();
    }
  }

  void previousStory() {
    if (_currentIndex > 0) {
      _timer?.cancel();
      _progressList[_currentIndex] = 0.0;
      _currentIndex--;
      _progress = 0.0;
      _isLoading = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.previousPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        _startTimer(storiess[_currentIndex]);
      });
    }
  }

  /// Navigates back to the home screen after finishing all stories.
  void _navigateToHome() {
    _timer?.cancel();
    _videoController?.dispose();
    _pageController.jumpToPage(0); // Reset the page controller.
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      // Replace this with your actual navigation code to go back to home screen
      log('Navigating to Home');
      // Example navigation: Navigator.of(context).pop();
    });
  }
}
