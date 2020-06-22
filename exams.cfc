component extends="db_access" {


private function init(){

}

 public static function GetInstance(){
        if(isNull(static.instance)){
            static.instance=new exams();
        }
        return static.instance;
    }

public function GetExamList() {

var sql_pattern="SELECT e.eid, e.title, e.notice FROM exams e";
var qry=doQuery( sql_pattern );

//define dynamic checkboxes for exams
writeoutput ('<div id="c1" style="width:50%; float: left; display: inline-block;">');
 writeoutput ("<strong> Exam title: </strong>" & "<span style='padding-left:50px;'> </span>" & '<strong> Description: </strong>' &' <br />');
for(row in qry) {

  writeoutput ( row.title   &"<span style='padding-left:50px;'> </span>" &
    row.notice &  '<input type="checkbox" onchange="handlePickExam(this)" id=e'&row.eid &' value=t'&row.eid&'>'& ' <br />');
 
}
//define button to submit choice
writeoutput ('<button type="button" onclick="handleSubmit()" id="finish" disabled="disable">Apply choice</button><br/>');
//define text field to verify candidate
writeoutput ("<strong> Pass ID then press enter: </strong>"&'<input type="number" id="userID" onkeypress="handleUser(event)"><br/>');
writeoutput (' <br />');
writeoutput ('<textarea id="history" rows="10" cols="50"> </textarea>');
writeoutput ('</div>');

}



}

