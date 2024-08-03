import 'package:flutter/material.dart';
import 'package:mapbox_demo/model/search_model.dart';
import 'package:mapbox_demo/repo/search.dart';

class SearchWithSuggestions extends StatefulWidget {
  final List<String> suggestions;
  final String hintText;
  const SearchWithSuggestions(
      {Key? key, required this.suggestions, required this.hintText})
      : super(key: key);

  @override
  _SearchWithSuggestionsState createState() => _SearchWithSuggestionsState();
}

class _SearchWithSuggestionsState extends State<SearchWithSuggestions> {
  final TextEditingController _controller = TextEditingController();
  List<Feature> _filteredSuggestions = [];
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  bool _isOverlayVisible = false;
  late OverlayEntry _overlayEntry;
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() async {
    final searchText = _controller.text.toLowerCase();

    final searchResults = await Search().getPlaces(searchText);

    setState(() {
      _filteredSuggestions = searchResults;
    });
    _updateOverlay();
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry);
    setState(() {
      _isOverlayVisible = true;
    });
  }

  void _hideOverlay() {
    _overlayEntry.remove();
    setState(() {
      _isOverlayVisible = false;
    });
  }

  void _updateOverlay() {
    if (_isOverlayVisible) {
      _overlayEntry.markNeedsBuild();
    }
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _filteredSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredSuggestions[index].placeName ?? ""),
                  onTap: () {
                    setState(() {
                      _controller.text =
                          _filteredSuggestions[index].placeName ?? "";
                    });
                    _hideOverlay();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
