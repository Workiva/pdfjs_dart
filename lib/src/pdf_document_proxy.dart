// Copyright 2018 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of pdfjs;

class PageReference {
  JsObject _jsInternal;

  PageReference._withJsInternal(this._jsInternal);

  int get gen => _jsInternal['gen'] as int;

  int get num => _jsInternal['num'] as int;
}

enum DestinationType { XYZ, Fit, FitH, FitV, FitR, FitB, FitBH, FitBV }

DestinationType _destinationTypeFromName(dynamic jsType) {
  String typeString;
  if (jsType is JsObject) {
    typeString = jsType['name'] as String;
  } else if (jsType is String) {
    typeString = jsType;
  }

  if (typeString == 'XYZ') {
    return DestinationType.XYZ;
  } else if (typeString == 'Fit') {
    return DestinationType.Fit;
  } else if (typeString == 'FitH') {
    return DestinationType.FitH;
  } else if (typeString == 'FitV') {
    return DestinationType.FitV;
  } else if (typeString == 'FitR') {
    return DestinationType.FitR;
  } else if (typeString == 'FitB') {
    return DestinationType.FitB;
  } else if (typeString == 'FitBH') {
    return DestinationType.FitBH;
  } else if (typeString == 'FitBV') {
    return DestinationType.FitBV;
  }

  return null;
}

dynamic _dartifyDestination(dynamic jsDest) {
  if (jsDest is List) {
    return _dartifyExplicitDestination(jsDest);
  } else {
    return jsDest;
  }
}

List<dynamic> _dartifyExplicitDestination(List<dynamic> jsDest) {
  List<dynamic> dartDest = List<dynamic>(jsDest.length);

  // The first item is always a page ref; create a strongly-typed dart object
  // for it
  dartDest[0] = PageReference._withJsInternal(jsDest[0] as JsObject);

  // The second item is either a string or name object specifying the action to
  // take on selecting the outline item
  dartDest[1] = _destinationTypeFromName(jsDest[1]);

  // Copy the remaining values, which should be numbers
  dartDest.setRange(2, jsDest.length, jsDest, 2);

  return dartDest;
}

List<OutlineItem> _dartifyOutlineItemList(List<JsObject> jsItems) {
  if (jsItems == null) {
    return null;
  }

  List<OutlineItem> items = List<OutlineItem>();
  for (JsObject jsItem in jsItems) {
    OutlineItem item = OutlineItem._withJsInternal(jsItem);

    items.add(item);
  }

  return items;
}

class OutlineItem {
  dynamic _dest;
  Iterable<OutlineItem> _items;
  JsObject _jsInternal;

  OutlineItem._withJsInternal(this._jsInternal) {
    _dest = _dartifyDestination(_jsInternal['dest']);
  }

  bool get bold => _jsInternal['bold'] as bool;

  Uint8List get color => _jsInternal['color'] as Uint8List;

  int get count => _jsInternal['count'] as int;

  dynamic get dest => _dest;

  bool get italic => _jsInternal['italic'] as bool;

  Iterable<OutlineItem> get items {
    if (_items == null) {
      List<OutlineItem> convertedItems = _dartifyOutlineItemList(_jsInternal['items'] as List<JsObject>);

      convertedItems ??= [];

      _items = UnmodifiableListView(convertedItems);
    }

    return _items;
  }

  String get title => _jsInternal['title'] as String;

  String get url => _jsInternal['url'] as String;
}

class PDFDocumentProxy {
  JsObject _jsInternal;

  PDFDocumentProxy() {
    _jsInternal = JsObject(context['pdfjsLib']['PDFDocumentProxy'] as JsFunction);
  }

  PDFDocumentProxy._withJsInternal(this._jsInternal);

  String get fingerprint => _jsInternal['fingerprint'] as String;

  int get numPages => _jsInternal['numPages'] as int;

  void cleanup() {
    _jsInternal.callMethod('cleanup', []);
  }

  void destroy() {
    _jsInternal.callMethod('destroy', []);
  }

  Future<TypedData> getData() {
    JsObject promise = _jsInternal.callMethod('getData', []) as JsObject;

    return _promiseToFuture<TypedData>(promise);
  }

  Future<List<dynamic>> getDestination(String id) {
    JsObject promise = _jsInternal.callMethod('getDestination', [id]) as JsObject;

    return _promiseToFuture<List<dynamic>>(promise, transform: (value) => _dartifyExplicitDestination(value as List));
  }

  Future<List<String>> getJavaScript() {
    JsObject promise = _jsInternal.callMethod('getJavaScript', []) as JsObject;

    return _promiseToFuture<List<String>>(promise);
  }

  Future<List<OutlineItem>> getOutline() {
    JsObject promise = _jsInternal.callMethod('getOutline', []) as JsObject;

    return _promiseToFuture<List<OutlineItem>>(promise,
        transform: (value) {
      if (value is List<JsObject>) {
        _dartifyOutlineItemList(value as List<JsObject>);
      }
    });
  }

  Future<PDFPageProxy> getPage(int pageNumber) {
    JsObject promise = _jsInternal.callMethod('getPage', [pageNumber]) as JsObject;

    return _promiseToFuture<PDFPageProxy>(promise,
        transform: (value) => PDFPageProxy._withJsInternal(value as JsObject));
  }

  Future<int> getPageIndex(PageReference ref) {
    JsObject promise = _jsInternal.callMethod('getPageIndex', [ref._jsInternal]) as JsObject;

    return _promiseToFuture<int>(promise);
  }

  Future<String> getPageMode() {
    JsObject promise = _jsInternal.callMethod('getPageMode', []) as JsObject;

    return _promiseToFuture<String>(promise);
  }
}
