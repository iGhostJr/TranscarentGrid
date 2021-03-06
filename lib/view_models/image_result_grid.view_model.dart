import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../services/web.service.dart';
import '../view_models/image_result.view_modal.dart';

class ImageResultGridViewModel {
  int _pageNum = 0;
  String _lastKeyword = "";
  final BehaviorSubject<List<ImageResultViewModel>> _imageSubject = BehaviorSubject();

  Stream<List<ImageResultViewModel>> get images =>  _imageSubject;

  Future<void> fetchImages(String keyword) async {
    if (keyword != _lastKeyword) { // If it is a different keyword, clear the old results and show the new search results
      _lastKeyword = keyword;
      _pageNum = 0;

      _imageSubject.add(await WebService.fetchImages(keyword, _pageNum));
    } else { // If it is the same keyword, add the next page to the existing list
      List<ImageResultViewModel> images = _imageSubject.hasValue ? _imageSubject.value : [];
      _pageNum += 1;
      images.addAll(await WebService.fetchImages(keyword, _pageNum));
      
      _imageSubject.add(images);
    }
  }
}
