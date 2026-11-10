import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Folder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: SvgPicture.asset(
                  'assets/icons/trash.svg',
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
