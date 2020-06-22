component extends="db_access" {


private function init(){

}


 public static function GetInstance(){
        if(isNull(static.instance)){
            static.instance=new testing_centers();
        }
        return static.instance;
    }


remote function GetAvaliableTestingCenters(any EID)  returntype="string" returnformat="text"   {

 var sql_pattern="SELECT tc.tid, tc.title, tc.location, tc.notice
 FROM testing_centers tc
 LEFT JOIN testing_centers_associated tca ON
 (tc.tid = tca.tid1) OR (tc.tid = tca.tid2) OR
 (tc.tid = tca.tid3) OR (tc.tid = tca.tid4) OR
 (tc.tid = tca.tid5) OR (tc.tid = tca.tid6) OR
 (tc.tid = tca.tid7)
 WHERE tca.tcaid = :EXID"

var p={ EXID: { type:'string', value: arguments.EID}};

var qry=doPQuery( sql_pattern, p);

//define list of avaliable testing centers
writeoutput (' <div id="c2" style="width:50%; float: left; display: inline-block;">');
writeoutput ("<strong> Avaliable centers: </strong>"  &"<span style='padding-left:100px;'> </span>" & "<strong> Address: </strong>" & "<span style='padding-left:100px;'> </span>" & "<strong> Notice: </strong> <br />");

for(row in qry) {
  writeoutput (row.title &"<span style='padding-left:200px;'> </span>" & row.location &"<span style='padding-left:120px;'> </span>"  & row.notice 
  &'<input type="checkbox" onchange="handlePickTestingCenters(this)" id=t'&row.tid &'>');
writeoutput (' <br />');
}

var ff="";

return ff;//GetPageContext().getOut().getString();
}

}
