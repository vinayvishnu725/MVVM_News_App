import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:search_news/Models/news_model.dart';
import 'package:search_news/utils/config.dart';

class BreakingNewsScreen extends StatefulWidget {
  const BreakingNewsScreen({Key? key}) : super(key: key);

  @override
  State<BreakingNewsScreen> createState() => _BreakingNewsScreenState();
}

class _BreakingNewsScreenState extends State<BreakingNewsScreen> {
  NewsModel? _newsModel;
  @override
  Widget build(BuildContext context) {
    _newsModel = Provider.of<NewsModel>(context);
    return SingleChildScrollView(
      child: listViewOfNews(),
    );
  }

  Widget listViewOfNews() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _newsModel!.articles!.length,
        itemBuilder: (context, index) {
          final newsData = _newsModel!.articles![index];
          return SizedBox(
            height: SizeConfig.heightMultiplier! * 16,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image(newsData),
                      autherText(newsData),
                      publishedAtText(newsData)
                    ],
                  ),
                  Column(
                    children: [titleText(newsData), descriptionText(newsData)],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget image(Articles newsData) {
    return SizedBox(
      height: SizeConfig.heightMultiplier! * 10,
      width: SizeConfig.widthMultiplier! * 35,
      child: newsData.urlToImage != null
          ? Image.network(
              newsData.urlToImage!,
              fit: BoxFit.cover,
            )
          : const SizedBox(),
    );
  }

  Widget autherText(Articles newsData) {
    return SizedBox(
        width: SizeConfig.widthMultiplier! * 30,
        child: Text(
          '${newsData.author}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget publishedAtText(Articles newsData) {
    return Text('${newsData.publishedAt}');
  }

  Widget titleText(Articles newsData) {
    return SizedBox(
        width: SizeConfig.widthMultiplier! * 57,
        child: Text(
          '${newsData.title}',
          style: const TextStyle(fontWeight: FontWeight.w800),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget descriptionText(Articles newsData) {
    return SizedBox(
        width: SizeConfig.widthMultiplier! * 57,
        child: Text(
          '${newsData.description}',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
