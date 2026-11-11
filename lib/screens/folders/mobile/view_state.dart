part of '../folders.dart';

class _FoldersMobileView extends StatelessWidget {
  const _FoldersMobileView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TestFolderButton(
            onPressed: () {
              context.read<FoldersBloc>().add(const FoldersTestFolderPressed());
            },
          ),
        ],
      ),
    );
  }
}
