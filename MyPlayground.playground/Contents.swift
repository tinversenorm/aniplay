//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground";
var arr = ["hello", "test", "thus", "anime"];
println(arr[1]);
sort(&arr);
println(arr);

struct AnimeEntry {
    var weight: Int;
    var value: String;
    
    //init() {}
    
    init(var weight: Int, value: String) {
        self.weight = weight;
        self.value = value;
    }
}

var aearr:[AnimeEntry] = Array<AnimeEntry>();
// search algorithm
var query = "h";
query = query.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
var results = Dictionary<Int, String>();
// weights:
// match = 0
// contains = 1 + length
// contains ind. words = just add to end of list
for item in arr {
    if item == query {
        aearr.append(AnimeEntry(weight: 0, value: item));
    } else if item.lowercaseString.rangeOfString(query.lowercaseString) != nil {
        aearr.append(AnimeEntry(weight: 1 + count(item), value: item));
    }
}
var displaylist:[String] = []
for item in aearr {
    displaylist.append(item.value);
}
println(displaylist);

