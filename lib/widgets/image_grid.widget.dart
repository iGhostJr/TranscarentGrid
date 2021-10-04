import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../view_models/image_result.view_modal.dart';
import '../view_models/image_result_grid.view_model.dart';
import 'image_card.widget.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key? key,
    required ImageResultGridViewModel imgGridViewModel,
    required Rx<bool> isLoading,
    required ScrollController scrollController,
  }) : _imgGridViewModel = imgGridViewModel, _isLoading = isLoading, _scrollController = scrollController, super(key: key);

  final ImageResultGridViewModel _imgGridViewModel;
  final Rx<bool> _isLoading;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ImageResultViewModel>>(
      initialData: const [],
      stream: _imgGridViewModel.images,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: Text("An error occurred!", style: TextStyle(fontSize: 22),),
          );
        }

        if (snapshot.data!.isEmpty && _isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int idx) {
              ImageResultViewModel img = snapshot.data![idx];
              return ImageCard(img: img);
            },
          );
        } else {
          return const Center(
            child: Text("No images match your search", style: TextStyle(fontSize: 22)),
          );
        }
      }
    );
  }
}