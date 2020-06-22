component {

static{
 DBS; //declare DataBaseSource
}

private function init(){ //could be overload with parameters and dynamic databasesources
    DBS={ //default
	  class: 'com.mysql.cj.jdbc.Driver'
	, bundleName: 'com.mysql.cj'
	, bundleVersion: '8.0.19'
	, connectionString: 'jdbc:mysql://localhost:3306/testing_center_db?characterEncoding=UTF-8&serverTimezone=America/Los_Angeles&maxReconnects=3'
	, username: 'root'
	, password: "encrypted:7410c337895101a850fa530a785015cbf6d8bd70c060878b"
	
	, clob:true
	, connectionLimit:100 
	, alwaysSetTimeout:true 
	, validate:false 
};
}

   //make a singleton to guarantee one-global DB access
  public static function GetInstance(){
        if(isNull(static.instance)){
            static.instance=new db_access();
        }
        return static.instance;
    }

//setter for DB source
 public function SetDBSource(datasources){
   DBS=datasources;
 }

//getter for DB source
 public function GetDBSource(){
     return DBS;
 }

//query with parameters 
  public function doPQuery(string sql_pattern, struct par){
try{
     return qry=queryExecute( sql=sql_pattern, options={ datasource : db_access::GetInstance().GetDBSource() }, params=par );
}
catch(any e){
    dump(e);
}
 }

//query based on string pattern
   public function doQuery(string sql_pattern){
try{
     return qry=queryExecute( sql=sql_pattern, options={ datasource : db_access::GetInstance().GetDBSource() });
}
catch(any e){
    dump(e);
}
 }

remote function GetCandidateData(any UID)  returntype="string" returnformat="text" {
   
 var sql_pattern="SELECT e.title, e.notice, ea.status, c.fname, c.lname, tc.location
 FROM exams e
 LEFT JOIN exams_associated ea ON e.eid = ea.exid
 LEFT JOIN testing_centers_associated tca ON e.eid = tca.tcaid
 LEFT JOIN testing_centers tc ON ea.taid = tc.tid
 LEFT JOIN candidates c ON c.cid = ea.cid
 WHERE c.uniqID= :userID";
var p={userID:{type:'string',value: arguments.UID}};

var qry=doPQuery( sql_pattern, p );
//dump(qry);
//JSON=serializeJSON(qry);
//dump(deserializeJson(json));
for(row in qry) {
writeoutput("[ Exam: " & row.title & " at " & row.location & " status: " & row.status & " ]" );
}

var ff="";
return ff;

}

remote function SetCandidateData(any UID, any TID, any EID) output="false" returntype="string" returnformat="text" {


//apply for new exam
var sql_pattern="SELECT cid FROM candidates WHERE uniqID= :userID;";
var p={userID:{type:'string',value: arguments.UID}};
var qry=doPQuery( sql_pattern, p );
var CID;
for(row in qry){
CID=row.cid;
}

sql_pattern="INSERT INTO exams_associated(exid,cid,taid)
SELECT * FROM (SELECT :examID, :CID, :testcenterID) AS tmp
WHERE NOT EXISTS (
SELECT *
 FROM exams_associated ea
 LEFT JOIN candidates c ON c.cid = ea.cid
 WHERE (c.uniqID= :userID AND ea.exid= :examID AND ea.taid= :testcenterID)
)"; 
 p={userID:{type:'string',value: arguments.UID},examID:{type:'string',value: arguments.EID},
 testcenterID:{type:'string',value: arguments.TID}, CID:{type:'string',value: CID}};
 qry=doPQuery( sql_pattern, p );
//dump(qry);

}
 
return "";


}