import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:search_news/Models/news_model.dart';
import 'package:search_news/utils/config.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  NewsModel? _newsModel;
  List<Articles> _articles = [];
  List<Articles> _results = [];
  final _searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    _newsModel = Provider.of<NewsModel>(context);
    _articles = _newsModel!.articles!;
    return SingleChildScrollView(
      child: Column(
        children: [
          searchBar(),
          listViewOfNews(),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: .6,
        )),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(hintText: ' Search News...'),
          onChanged: (v) {
            //searching delay for 0.5 seconds
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                query = v;
                setResults(query);
              });
            });
          },
        ),
      ),
    );
  }

  Widget listViewOfNews() {
    return query.isEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _articles.length,
            itemBuilder: (context, index) {
              final newsData = _articles[index];
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
                        children: [
                          titleText(newsData),
                          descriptionText(newsData)
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final newsData = _results[index];
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
                        children: [
                          titleText(newsData),
                          descriptionText(newsData)
                        ],
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

  void setResults(String query) {
    _results = _articles
        .where((elem) =>
            elem.title.toString().toLowerCase().contains(query.toLowerCase()) ||
            elem.author.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
