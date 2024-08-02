import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatContentsPage extends StatefulWidget {
  const ChatContentsPage({super.key});

  @override
  State<ChatContentsPage> createState() => _ChatContentsPageState();
}

class _ChatContentsPageState extends State<ChatContentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, PreviewData> datas = {};
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

  List<String> get urls => const [
        'github.com/flyerhq',
        'https://u24.gov.ua',
        'https://twitter.com/SpaceX/status/1564975288655630338',
      ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("컨텐츠 보관함", style: Theme.of(context).textTheme.labelLarge,),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: '링크',
            ),
            Tab(
              text: '사진',
            ),
            Tab(text: '영상'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            controller: _refreshController,
            header: const ClassicHeader(
              refreshingText: '새로고침 중',
              completeText: '완료',
            ),
            footer: const ClassicFooter(
              loadingText: "불러오는 중",
              
            ),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              itemCount: urls.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemBuilder: (context, index) {
                return ExpansionTile(
                  leading: Checkbox(
                    onChanged: (v) {},
                    value: true,
                  ),
                  shape: InputBorder.none,
                  collapsedShape: InputBorder.none,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  title: Text(
                    urls[index],
                  ),
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: LinkPreview(
                        enableAnimation: true,
                        onPreviewDataFetched: (data) {
                          setState(() {
                            datas = {...datas, urls[index]: data};
                          });
                        },
                        previewData: datas[urls[index]],
                        text: urls[index],
                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          GridView.builder(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey,
                );
              }),
          GridView.builder(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 0.7),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey,
                );
              }),
        ],
      ),
    );
  }
}
