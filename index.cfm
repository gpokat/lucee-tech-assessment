<!-- -->

<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js" > </script>
 <script type = "text/javascript">

//lock active element
    function disable(id) {
        document.getElementById(id).setAttribute('disabled', 'disabled');
    }

//unlock active element
function enable(id) {
    document.getElementById(id).removeAttribute('disabled');
}

//reverse string object
function reverse(s) {
    return s.split('').reverse().join('');
}

//declare global variables
var guserID = 1000;
var picked_EID=-1;
var picked_TID=-1;

//catch exam choice
function handlePickExam(choice) {
    var choice_eid = choice.id;
    var choice_tid = choice.value;

    picked_EID=choice_eid.substr(1, choice_eid.length - 1);
   // console.log(choice_eid);
   // console.log(choice_tid);

    $.ajax({
        url: 'testing_centers.cfc?method=GetAvaliableTestingCenters',
        type: 'POST',
        data: {
            EID: picked_EID
        },
        success: function(data) {
            // alert(data);
        //    console.log("succ");
        },
        error: function(data) {
       //     console.log('err: ', data);
        alert("error DB access: GetAvaliableTestingCenters");
        }
    }).done(function(response) {
     //   console.log("DONE !");
     //   console.log(response.length);

        //render new page content
        $("html").empty();
        $("html").html(response);

        if (choice.checked) {
            document.getElementById(choice_eid).checked = true;
            disable(choice_eid);
        } else {
            document.getElementById(choice_eid).checked = false;
        }
    });
}

//catch testing centers choice
function handlePickTestingCenters(test_center) {
    var tcid = test_center.id;
    picked_TID=tcid.substr(1, tcid.length - 1);

    var elem = document.getElementsByTagName("*");

//lock multi-choice (it could  be added if required :P)
    if (test_center.checked) {
        document.getElementById(tcid).checked = true;

        for (var i = 0; i < elem.length; i++) {
            if (elem[i].type == 'checkbox' && elem[i].checked == false && elem[i].id.substr(0, 1) == "t") {
                disable(elem[i].id);
            }
        }
    } else {
        for (var i = 0; i < elem.length; i++) {
            if (elem[i].type == 'checkbox' && elem[i].checked == false && elem[i].id.substr(0, 1) == "t") {
                enable(elem[i].id);
            }
        }
        document.getElementById(tcid).checked = false;
    }
}
//catch button
function handleSubmit() {
    var validate = 0;
    var elem = document.getElementsByTagName("*");
    for (var i = 0; i < elem.length; i++) {
        if (elem[i].type == 'checkbox' && elem[i].checked == true) {
            validate++;
        }
    }

    if (validate < 2) {
        alert("You don't pick any exam-testing center pair !");
        return false;
    }
/*
console.log("DATA: ");
console.log(guserID);
console.log(picked_EID);
console.log(picked_TID);*/
  $.ajax({
        url: 'db_access.cfc?method=SetCandidateData',
        type: 'GET',
        data: {
            UID: guserID,
            EID: picked_EID,
            TID: picked_TID
        },
        success: function(data) {
            // alert(data);
           // console.log("succ11");
        },
        error: function(data) {
           // console.log('err11: ', data);
       alert("error DB access: SetCandidateData");
        }
    }).done(function(response) {
       // console.log("DONE11 !");
       //  console.log(response);

    $.ajax({
        url: 'db_access.cfc?method=GetCandidateData',
        type: 'POST',
        data: {
            UID: guserID
        },
        success: function(data) {
            // alert(data);
         //   console.log("succ11");
        },
        error: function(data) {
          //  console.log('err11: ', data);
        alert("error DB access: GetCandidateData");
        }
    }).done(function(response) {
      //  console.log("DONE11 !");
        // console.log(response);
        var out_line = "";
        document.getElementById('history').textContent = "";
        for (i = response.length; i >= 0; --i) {
            //manual parser :D
            if (response[i] == ']') {
                continue;
            } else if (response[i] == '[') {
                out_line = reverse(out_line);
                document.getElementById('history').textContent += out_line + "\\\n";
                console.log(out_line);
                out_line = "";
            } else if (response[i] == ">") {
                break;
            } else if (response[i]) {
                out_line += response[i];
                //console.log(response[i]);
            }
        }
    });
  });
}
//catch user-id input by enter key
function handleUser(key) {
    if (key.keyCode == 13) {
        var userID = document.getElementById('userID').value;
        if (userID < 0) document.getElementById('userID').value = userID * (-1);
        //simple validation ID
        if(userID>999 || userID<992){ alert("Candidate with this ID doesn't registered !")
            return false;
        }
        guserID = userID;
        enable("finish");
    }
}
</script>