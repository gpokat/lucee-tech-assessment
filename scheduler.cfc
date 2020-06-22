component {

    property exams_class;
    property testing_center_class;

private function init(){
      exams_class=new exams();
      testing_center_class=new testing_centers();
}

 public static function GetScheduler(){
        if(isNull(static.instance)){
            static.instance=new scheduler();
        }
        return static.instance;
    }

public function work(){
    exams_class.GetExamList();
}


}