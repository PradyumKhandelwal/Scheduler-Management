<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<html:html lang="true">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous">
        </script>   
        <script>
            $(document).ready(function () {
                console.log("ready!");

                getSchData();
            });


            function getSchData() {
                $.ajax({
                    url: "schAction.do",
                    data: {flag: "FetchData"},
                    type: "POST",
                    async: false,
                    success: function (result) {
                        //alert(result);
                        var jarr = JSON.parse(result);
                        DeleteRows();
                        for (let i = 0; i < jarr.length; i++)
                        {
                            var currJson = jarr[i];
                            var table = document.getElementById("myTable");
                            var row = table.insertRow();
                            var cell1 = row.insertCell(0);
                            var cell2 = row.insertCell(1);
                            var cell3 = row.insertCell(2);
                            var cell4 = row.insertCell(3);
                            var cell5 = row.insertCell(4);
                            cell1.innerHTML = currJson.name;
                            cell2.innerHTML = getSwitch(currJson.ID);
                            cell3.innerHTML = currJson.description;
                            cell4.innerHTML = currJson.timeFrame;
                            cell5.innerHTML = currJson.action;
                        }
                    }
                });
            }
            /*function update(id, status) {
             console.log(id);
             $.ajax({
             url: "schAction.do",
             data: {flag: "updateSchStatus", status: status, id: id},
             type: "POST",
             async: false,
             success: function (result) {
             
             }
             });
             }*/

            function update(element) {


                var currentId = element.id;
                var currentValue = $('#' + currentId).prop('checked');
                
                currentValue = (currentValue == true || currentValue =='true') ? "1" :"0";
                console.log("id--->  " + currentId);
                console.log("value--> " + currentValue);
                $.ajax({
                    url: "schAction.do",
                    data: {flag: "updateSchStatus", status: currentValue, id: currentId},
                    type: "POST",
                    async: false,
                    success: function (result) {

                    }
                });
            }



            function DeleteRows() {

                var mytb = document.getElementById("myTable");//$("#myTable");
                var rowCount = $('#myTable tr').length;
                //var rowCount = mytb.rows.length;
                for (var i = rowCount - 1; i > 0; i--) {
                    //console.log(mytb);
                    mytb.deleteRow(i);
                }
                ;
            }
            ;


        </script>
        <title>Application Titles</title>
        <!-- CSS  -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
        <style>
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white
                    ;
                -webkit-transition: .4s;
                transition: .4s;
            }

            input:checked + .slider {
                background-color: #2196F3;
            }

            input:focus + .slider {
                box-shadow: 0 0 1px #2196F3;
            }

            input:checked + .slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }

            /* Rounded sliders */
            .slider.round {
                border-radius: 34px;
            }

            .slider.round:before {
                border-radius: 50%;
            }
        </style>

        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
        <html:base/>
    </head>
    <body style="background-color: #fd7e1457">




        <logic:notPresent name="org.apache.struts.action.MESSAGE" scope="application">
            <div  style="color: red">
                ERROR:  Application resources not loaded -- check servlet container
                logs for error messages.
            </div>
        </logic:notPresent>

        <h3>Scheduler Application</h3>
        <p>This is a struts application. By: Pradyum Khandelwal </p>

        <form id="form">
            <p>Scheduler Name
                <input type="text" name="txtSchedulerName" id="txtSchedulerName" value='' placeholder="Enter Scheduler Name"/>
            </p> 
            <p>Scheduler Type
                <label 
                    for="Scheduler Type"> 
                </label>
                <select name="Scheduler Type" id="SchedulerType">
                    <option value="Daily">
                        Daily
                    </option>
                    <option value="Weekly">
                        Weekly
                    </option> 
                    <option value="Monthly">
                        Monthly
                    </option>
                    <option value="Yearly">
                        Yearly
                    </option>
                </select>
            </p> 
            <p>Set Day
                <input type="number" name="txtDay" id="txtDay" value='' placeholder="" min='01' max='31'/>
                Set Month
                <input type="number" name="txtMonth" id="txtMonth" value='' placeholder="" min='01' max='12'/>
            </p> 
            <p>Set Time
                <input type="number" name="txtHr" id="txtHr" value='' placeholder="" min='00' max='23'/> 
                <input type="number" name="txtMin" id="txtMin" value='' placeholder="" min='00' max='59'/>
            </p> 
            <button class="primary" type="button" id='submitBtn' onclick="myFunction()"> Submit </button>
            <button class="primary" type="button" id='resetBtn' onclick="clearTxt()"> Reset </button>

        </form>
        <style>
            table, th, td {
                border:1px solid black;
            }
        </style>
        <table id="myTable" style="width:100%">
            <tr>
                <th>Scheduler Name</th>
                <th>On/Off</th>
                <th>Scheduler Type</th>
                <th>Start Time</th>
                <th>Action</th>
            </tr>
        </table>

        <!--<label class="switch"> <input type="checkbox" checked=""> <span class="slider"></span></label>-->
        <script>
            function myFunction() {
                console.log("I am Called submit.....");
                var sName = document.getElementById("txtSchedulerName").value;
                var sType = document.getElementById("SchedulerType").value;
                var sTime = '';
                var sHr = document.getElementById("txtHr").value;
                var sMin = document.getElementById("txtMin").value;
                sTime = sHr + ':' + sMin;
                var sDay = document.getElementById("txtDay").value;
                var sMonth = document.getElementById("txtMonth").value;

                $.ajax({
                    url: "schAction.do",
                    data: {schName: sName, sType: sType, sHr: sHr, sMin: sMin, sMonth: sMonth, sDay: sDay, flag: "Postdata"},
                    type: "POST",
                    async: false,
                    success: function (result) {
                        alert("AJAX is working");
                    }

                });
                getSchData();
                clearTxt();
            }

            function getSwitch(schId) {
                return '<label class="switch"> <input type="checkbox" id="' + schId + '" onChange="update(this)" checked> <span class="slider"></span></label>';
            }


            function clearTxt() {
                console.log("I am Called clear.....");
                document.getElementById("txtSchedulerName").value = "";
                document.getElementById("SchedulerType").value = "";
                document.getElementById("txtHr").value = "";
                document.getElementById("txtMin").value = "";
                document.getElementById("txtDay").value = "";
                document.getElementById("txtMonth").value = "";
                console.log("I am Called/....." + document.getElementById("txtSchedulerName"));
                //document.getElementById("form").reset();
            }
            ;

        </script>
    </body>
</html:html>
