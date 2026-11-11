part of '../lists.dart';

class _ListsMobileView extends StatelessWidget {
  const _ListsMobileView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TestListButton(
            onPressed: () {
              context.read<ListsBloc>().add(const ListsTestListPressed());
            },
          ),
        ],
      ),
    );
  }
}
