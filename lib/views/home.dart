import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../view_models/image_result_grid.view_model.dart';
import '../widgets/image_grid.widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  final ImageResultGridViewModel _imgGridViewModel = ImageResultGridViewModel();
  final TextEditingController _keywordTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    reverseDuration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 5.0),
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.linear,
  ));

  final Rx<bool> _isLoading = false.obs;

  @override
  void initState() {
    super.initState();

    _imgGridViewModel.images.listen((event) {
      _isLoading.value = false;
    });

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter <= MediaQuery.of(context).size.height * 1.25 && !_isLoading.value) {
        triggerFetchImages();
      }
      if (!_animationController.isAnimating) {
        if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
          _animationController.reverse();
        } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse && MediaQuery.of(context).viewInsets.bottom == 0) {
          _animationController.forward();
        }
      }
    });
  }

  void triggerFetchImages() {
    if (_keywordTextController.text.isNotEmpty && !_isLoading.value) {
      _isLoading.value = true;
      _imgGridViewModel.fetchImages(_keywordTextController.text);
    }
  }

  @override
  void dispose() {
    _keywordTextController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ImageGrid(imgGridViewModel: _imgGridViewModel, isLoading: _isLoading, scrollController: _scrollController),
            Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: _offsetAnimation,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.only(left: 20, right: 0),
                  margin: const EdgeInsets.only(bottom: 25),
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).orientation == Orientation.portrait && MediaQuery.of(context).viewInsets.bottom == 0 
                    ? 250 
                    : 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[700]!.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _keywordTextController,
                    onSubmitted: (value) {
                      triggerFetchImages();
                    },
                    decoration: const InputDecoration(
                      isDense: false,
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search, color: Colors.white,)
                    ),
                    style: const TextStyle(color: Colors.white),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
