function checkAll(cb,cbid){
    var inputElem = $("input");
    for(var i=0; i<inputElem.length; i++){
        if(inputElem[i].id.indexOf(cbid)!=-1){
            inputElem[i].checked = cb.checked;
        }
    }
}

function addAll(){
    var inputElem = $("input");
    for(var i=0; i<inputElem.length; i++){
        if(inputElem[i].id.indexOf("selectAll")>0){
            inputElem[i].checked = false;
        }
    }
}
function removeAll(){
    var inputElem = $("input");
    for(var i=0; i<inputElem.length; i++){
        if(inputElem[i].id.indexOf("removeAll")>0){
            inputElem[i].checked = false;
        }
    }
}

function onFocus(){
	if ($("[id$=txtSearch]").val()=="Search..."){
		$("[id$=txtSearch]").val("");
	}
}

function onBlur(){
	if ($("[id$=txtSearch]").val()==""){
		$("[id$=txtSearch]").val("Search...");	   
	}
}

