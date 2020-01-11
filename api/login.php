<?php

header("Content-Type: application/json; charset=UTF-8");
require "config.php";
$data = json_decode(file_get_contents('php://input'), true);

function test() {
    $senddata = '';
    $sel_con = "SELECT * FROM user";
    $result = mysqli_query($conn, $sel_con);
    if($result -> num_rows > 0)
    {   
        $users = array();
        while($row = $result -> fetch_assoc()) {
            array_push($users, $row);
        }

        response(true, "xxxxx", $users);

    }
    else {
        response(false, "No users", NULL);
    }
}
/////////////

function response($status, $message, $data)
{ 
    $response['status'] = $status;
    $response['message'] = $message;
    $response['data'] = $data;

    $json_response = json_encode($response);
    echo $json_response;
}
/*
if(!is_null($_POST['name']))
{
    $name = $_POST['name'];
    $sel_con = "SELECT * FROM charities WHERE name = '{$name}'";
    $result = mysqli_query($conn, $sel_con);

    if($result -> num_rows > 0)
    {       
        response(false, "Already exist a charity with same name", NULL);

    }
    else
    {
        $sel_con1 = "INSERT INTO charities   (name) VALUES ('{$name}')";
        $result1 = mysqli_query($conn, $sel_con1);
        $message = "Success add new charity";

        $save_path = "";
        if(isset($_FILES['upload']))
        {
            $target_path = "upload/";
            $imageFileType = strtolower(pathinfo($_FILES["upload"]['name'],PATHINFO_EXTENSION));
            $target_path = $target_path.$user_id."charity".date('_YmdHis').".png";
            $save_path = $target_path;
            $uploadOk = 1;
            $check = getimagesize($_FILES["upload"]["tmp_name"]);
            if($check !== false) {
                $uploadOk = 1;
            } else {
                $uploadOk = 0;
            }

            if ($uploadOk == 0) {
            } else {
                if(move_uploaded_file($_FILES['upload']['tmp_name'], $target_path)) 
                {
                } else 
                {
                   
                }
            }

			
            $save_path = "charity/".$save_path;
            $sel_con1 = "UPDATE charities SET photo = '{$save_path}' WHERE name = '{$name}'";
            $result1 = mysqli_query($conn, $sel_con1);

        }


        $sel_con = "SELECT * FROM charities WHERE name = '{$name}'";
        $result = mysqli_query($conn, $sel_con);
        $charity_info = $result -> fetch_assoc();

        response(true, $message, $charity_info);


    }

}
else
{
    response(false, "Please fill all parameters.", NULL);
}

