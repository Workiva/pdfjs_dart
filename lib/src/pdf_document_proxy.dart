// Copyright 2017 Workiva Inc.
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

  int get gen => _jsInternal['gen'];

  int get num => _jsInternal['num'];
}

enum DestinationType { XYZ, Fit, FitH, FitV, FitR, FitB, FitBH, FitBV }

DestinationType _destinationTypeFromString(String typeString) {
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
  List<dynamic> dartDest = new List<dynamic>(jsDest.length);

  // The first item is always a page ref; create a strongly-typed dart object
  // for it
  dartDest[0] = new PageReference._withJsInternal(jsDest[0]);

  // The second item is always a string specifying the action to take on
  // selecting the outline item
  dartDest[1] = _destinationTypeFromString(jsDest[1]);

  // Copy the remaining values, which should be numbers
  dartDest.setRange(2, jsDest.length, jsDest, 2);

  return dartDest;
}

List<OutlineItem> _dartifyOutlineItemList(List<JsObject> jsItems) {
  if (jsItems == null) {
    return null;
  }

  List<OutlineItem> items = new List<OutlineItem>();
  for (JsObject jsItem in jsItems) {
    OutlineItem item = new OutlineItem._withJsInternal(jsItem);

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

  bool get bold => _jsInternal['bold'];

  Uint8List get color => _jsInternal['color'];

  int get count => _jsInternal['count'];

  dynamic get dest => _dest;

  bool get italic => _jsInternal['italic'];

  Iterable<OutlineItem> get items {
    if (_items == null) {
      List<OutlineItem> convertedItems =
          _dartifyOutlineItemList(_jsInternal['items']);

      convertedItems ??= [];

      _items = new UnmodifiableListView(convertedItems);
    }

    return _items;
  }

  String get title => _jsInternal['title'];

  String get url => _jsInternal['url'];
}

class PDFDocumentProxy {
  JsObject _jsInternal;

  PDFDocumentProxy() {
    _jsInternal = new JsObject(context['PDFJS']['PDFDocumentProxy']);
  }

  PDFDocumentProxy._withJsInternal(this._jsInternal);

  String get fingerprint => _jsInternal['fingerprint'];

  int get numPages => _jsInternal['numPages'];

  void cleanup() {
    _jsInternal.callMethod('cleanup', []);
  }

  void destroy() {
    _jsInternal.callMethod('destroy', []);
  }

  Future<TypedData> getData() {
    JsObject promise = _jsInternal.callMethod('getData', []);

    return _promiseToFuture<TypedData>(promise);
  }

  Future<List<dynamic>> getDestination(String id) {
    JsObject promise = _jsInternal.callMethod('getDestination', [id]);

    return _promiseToFuture<List<dynamic>>(promise,
        transform: (value) => _dartifyExplicitDestination(value));
  }

  Future<List<String>> getJavaScript() {
    JsObject promise = _jsInternal.callMethod('getJavaScript', []);

    return _promiseToFuture<List<String>>(promise);
  }

  Future<List<OutlineItem>> getOutline() {
    JsObject promise = _jsInternal.callMethod('getOutline', []);

    return _promiseToFuture<List<OutlineItem>>(promise,
        transform: (value) => _dartifyOutlineItemList(value));
  }

  Future<PDFPageProxy> getPage(int pageNumber) {
    JsObject promise = _jsInternal.callMethod('getPage', [pageNumber]);

    return _promiseToFuture<PDFPageProxy>(promise,
        transform: (value) => new PDFPageProxy._withJsInternal(value));
  }

  Future<int> getPageIndex(PageReference ref) {
    JsObject promise = _jsInternal.callMethod('getPageIndex', [ref._jsInternal]);

    return _promiseToFuture<int>(promise);
  }

  Future<String> getPageMode() {
    JsObject promise = _jsInternal.callMethod('getPageMode', []);

    return _promiseToFuture<String>(promise);
  }
}
