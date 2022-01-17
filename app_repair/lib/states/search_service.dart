import 'package:app_repair/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:app_repair/models/TechDataModel.dart';

class SearchService extends StatefulWidget {
  const SearchService({Key? key}) : super(key: key);

  @override
  _SearchServiceState createState() => _SearchServiceState();
}

class _SearchServiceState extends State<SearchService> {
  TextEditingController? _textEditingController = TextEditingController();

  static List<String> fixListOnSearch = [];

  static List<String> fixList = [
    'ช่างกุญแจ',
    'ช่างคอม',
    'ช่างงานโครงสร้าง',
    'ช่างซ่อมมือถือ',
    'ช่างซ่อมรถ',
    'ช่างทาสี',
    'ช่างประปา',
    'ช่างไฟฟ้า',
    'ช่างวอลเปเปอร์',
    'ช่างแอร์',
  ];

  final List<TechDataModel> Techdata = List.generate(
      fixList.length, (index) => TechDataModel('${fixList[index]}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  fixListOnSearch = fixList
                      .where((element) =>
                          element.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      fixListOnSearch.clear();
                      _textEditingController!.clear();
                      setState(() {
                        _textEditingController!.text = '';
                      });
                    },
                  ),
                  hintText: 'ค้นหาบริการช่างที่ต้องการ',
                  border: InputBorder.none),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: _textEditingController!.text.isNotEmpty && fixListOnSearch.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    color: Colors.black,
                    size: 100,
                  ),
                  Text('ไม่พบผลลัพธ์ที่ค้นหา',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _textEditingController!.text.isNotEmpty
                  ? fixListOnSearch.length
                  : fixList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.orange.shade200,
                  child: ListTile(
                    title: (Text(_textEditingController!.text.isNotEmpty
                        ? fixListOnSearch[index]
                        : Techdata[index].name)),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(MyConstant.fixlogo),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, MyConstant.routeSubmitService);
                    },
                  ),
                );
              },
            ),
    );
  }
}
