/**
 * Created by LaNet on 1/12/17.
 */

window.document.onload = function () {
    console.log("document load");
}

window.onload = function () {
    console.log("window load");
}

//alert();
var obj = new XMLHttpRequest() || new ActiveXObject('MSXML2.XMLHTTP');
//readFile();

function readFile() {
//    var obj = new XMLHttpRequest();
    obj.open("GET","mydata.txt",false);
    obj.send(null);

    var data = obj.responseText;

    console.log(data);

    window.document.getElementById("data").innerHTML = data;

}