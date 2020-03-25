<?php

header("Content-Type: application/json; charset=UTF-8");
require "config.php";
$data = json_decode(file_get_contents('php://input'), true);

function register() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['name']) || is_null($data['phone_number']) || is_null($data['password'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $name = $data['name'];
    $phone_number = $data['phone_number'];
    $password = $data['password'];
    $isOnLine = "1";
    
    $sel_con = "SELECT * FROM users WHERE main_phone = '$phone_number'";
    $result = mysqli_query($conn, $sel_con);
    if ($result -> num_rows > 0) {
        return response(false, "Duplicated phone number", NULL);
    }
    else {
        $sel_con1 = "INSERT INTO users (name, main_phone, password, isOnLine) VALUES ('$name', '$phone_number', '$password', '$isOnLine')";
        mysqli_query($conn, $sel_con1);
        $result1 = mysqli_query($conn, $sel_con);
        $senddata['profile'] = $result1 -> fetch_assoc();

        return response(true, "Successed to register", $senddata);
    }
}

function login() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['phone_number']) || is_null($data['password'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $phone_number = $data['phone_number'];
    $password = $data['password'];
    $isOnLine = "1";
    
    $sel_con = "SELECT * FROM users WHERE main_phone = '$phone_number'";
    $result = mysqli_query($conn, $sel_con);
    if ($result -> num_rows > 0) {
        $profile = $result -> fetch_assoc();
        if ($profile['password'] == $password) {
            $sel_con1 = "UPDATE users SET isOnLine = '$isOnLine' WHERE main_phone = '$phone_number'";
            mysqli_query($conn, $sel_con1);
            $senddata['profile'] = $profile;
            $phones = array();
            $main_phone = $profile['main_phone'];
            $other_phones = $profile['other_phones'];
            if ($other_phones != "") {
                $phones = explode(",", $other_phones);
            }
            array_push($phones, $main_phone);
            $groups = array();
            for ($i = 0; $i < count($phones); $i++) {
                $phone_number = $phones[$i];
                $sel_con2 = "SELECT * FROM members WHERE phone_number = '$phone_number'";
                $result2 = mysqli_query($conn, $sel_con2);
                if ($result2 -> num_rows > 0) {
                    while ($member = $result2 -> fetch_assoc()) {
                        $group_id = $member['group_id'];
                        $sel_con3 = "SELECT * FROM groups WHERE group_id = '$group_id'";
                        $result3 = mysqli_query($conn, $sel_con3);
                        if ($result3 -> num_rows > 0) {
                            array_push($groups, $result3 -> fetch_assoc());
                        }
                    }
                }
                
            }

            if (count($groups) > 0) {
                $senddata['groups'] = $groups;
            }
            return response(true, "Successed to login", $senddata);
        }
        else {
            return response(false, "Wrong password", NULL);
        }
        
    }
    else {
        return response(false, "Unregistered phone number", NULL);
    }
}

function createGroup() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['created_user_id']) || is_null($data['title']) || is_null($data['description']) || is_null($data['created_time'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $created_user_id = $data['created_user_id'];
    $title = $data['title'];
    $description = $data['description'];
    $created_time = $data['created_time'];

    $sel_con = "SELECT * FROM users WHERE id = '$created_user_id'";
    $created_phone = mysqli_query($conn, $sel_con) -> fetch_assoc()['main_phone'];
    
    $sel_con = "INSERT INTO groups (created_user_id, title, description, created_time) VALUES ('$created_user_id', '$title', '$description', '$created_time')";
    mysqli_query($conn, $sel_con);
    $group_id = mysqli_insert_id($conn);
    $owner_status = "1";
    $sel_con = "INSERT INTO members (group_id, phone_number, joined_time, owner_status) VALUES ('$group_id', '$created_phone', '$created_time', '$owner_status')";
    mysqli_query($conn, $sel_con);
    $sel_con = "SELECT * FROM groups WHERE group_id = '$group_id'";
    $senddata['group'] = mysqli_query($conn, $sel_con) -> fetch_assoc();

    return response(true, "Successed to create new group", $senddata);
}

function addMember() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['group_id']) || is_null($data['phone_numbers']) || is_null($data['joined_time'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $group_id = $data['group_id'];    
    $new_phone_numbers = explode(",", $data['phone_numbers']);
    $joined_time = $data['joined_time'];

    $all_phones = array();
    $new_members = array();
    $registered_phones = array();
    $unregistered_phones = array();

    $sel_con = "SELECT * FROM users";
    $result = mysqli_query($conn, $sel_con);
    while ($row = $result -> fetch_assoc()) {
        $phones = array();
        $main_phone = $row['main_phone'];
        $other_phones = $row['other_phones'];
        if ($other_phones != "") {
            $phones = explode(",", $other_phones);
            // array_push($phones, explode(",", $other_phones));
        }
        array_push($phones, $main_phone);

        for ($i = 0; $i < count($new_phone_numbers); $i++) {
            $new_phone_number = $new_phone_numbers[$i];
            for ($j = 0; $j < count($phones); $j++) {
                if ($new_phone_number == $phones[$j]) { 
                    $sel_con = "INSERT INTO members (group_id, phone_number,  joined_time) VALUES ('$group_id', '$new_phone_number', '$joined_time')";
                    mysqli_query($conn, $sel_con);
                    $member_id = mysqli_insert_id($conn);
                    $member = [];
                    $member['member_id'] = (string)$member_id;
                    $member['group_id'] = $group_id;
                    $member['name'] = $row['name'];                    
                    $member['phone_number'] = $new_phone_number;
                    $member['isOnLine'] = $row['isOnLine'];
                    array_push($new_members, $member);
                    array_push($registered_phones, $new_phone_number);
                }
            }
            
        }   
    }

    $senddata['members'] = $new_members;

    for ($i = 0; $i < count($new_phone_numbers); $i++) {   
        $new_phone_number = $new_phone_numbers[$i];
        if (in_array($new_phone_number, $registered_phones)) {}
        else {
            array_push($unregistered_phones, $new_phone_number);
        }
    }
    
    $added_msg = "Successed to add phone numbers: ";
    $failed_msg = "";
    if (count($registered_phones) != 0) {
        for ($i = 0; $i < count($registered_phones) - 1; $i++) {
            $added_msg = $added_msg.$registered_phones[$i].",";
        }   
        $added_msg = $added_msg.$registered_phones[count($registered_phones) - 1];
    }
    if (count($unregistered_phones) > 0) {
        $failed_msg = ", but unfortunately failed to add phone numbers: ";
        for ($i = 0; $i < count($unregistered_phones) - 1; $i++) {
            $failed_msg = $failed_msg.$unregistered_phones[$i].",";
        }   
        $failed_msg = $failed_msg.$unregistered_phones[count($unregistered_phones) - 1];
    }
    if (count($registered_phones) == 0) {
        return response(false, $failed_msg, NULL);
    }
    else {
        return response(true, $added_msg."  ".$failed_msg, $senddata);
    }
}

function createContribute() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['created_group_id']) || is_null($data['created_user_id']) || is_null($data['title']) || is_null($data['description']) || is_null($data['target_amount']) || is_null($data['title']) || is_null($data['created_time']) || is_null($data['end_time']) || is_null($data['beneficiary_name']) || is_null($data['beneficiary_phone'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $created_group_id = $data['created_group_id'];    
    $created_user_id = $data['created_user_id'];    
    $title = $data['title'];    
    $description = $data['description'];    
    $target_amount = $data['target_amount'];    
    $created_time = $data['created_time'];       
    $end_time = $data['end_time'];    
    $beneficiary_name = $data['beneficiary_name'];    
    $beneficiary_phone = $data['beneficiary_phone'];
    
    $sel_con = "INSERT INTO contributes (created_group_id, created_user_id, title, description, target_amount, created_time, end_time,  beneficiary_name, beneficiary_phone) VALUES ('$created_group_id', '$created_user_id', '$title', '$description', '$target_amount', '$created_time', '$end_time', '$beneficiary_name', '$beneficiary_phone')";
    mysqli_query($conn, $sel_con);
    $contribute_id = mysqli_insert_id($conn);
    $sel_con = "SELECT * FROM contributes WHERE contribute_id = '$contribute_id'";
    $senddata['contribute'] = mysqli_query($conn, $sel_con) -> fetch_assoc();

    return response(true, "Successed to create new contribute", $senddata);
}

function addPhone() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['user_id']) || is_null($data['phone_number'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $user_id = $data['user_id'];    
    $phone_number = $data['phone_number']; 

    $sel_con = "SELECT * FROM users WHERE id = '$user_id'";
    $other_phones = mysqli_query($conn, $sel_con) -> fetch_assoc()['other_phones'];
    if ($other_phones == "") {
        $other_phones = $phone_number;
    }
    else {
        $other_phones = $other_phones.",".$phone_number;
    }
    
    $sel_con = "UPDATE users SET other_phones = '$other_phones' WHERE id = '$user_id'";
    mysqli_query($conn, $sel_con);

    $sel_con = "SELECT * FROM users WHERE id = '$user_id'";
    $senddata['profile'] = mysqli_query($conn, $sel_con) -> fetch_assoc();

    return response(true, "Successed to add new phone number", $senddata);
}

function addDonate() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (is_null($data['contribute_id']) || is_null($data['donated_user_id']) || is_null($data['donated_member_name']) || is_null($data['donated_member_phone']) || is_null($data['donated_time']) || is_null($data['donated_amount'])) {
        return response(false, "Need more parameters", NULL);
    }    
    $contribute_id = $data['contribute_id'];    
    $donated_user_id = $data['donated_user_id'];    
    $donated_member_name = $data['donated_member_name'];    
    $donated_member_phone = $data['donated_member_phone'];    
    $donated_time = $data['donated_time']; 
    $donated_amount = $data['donated_amount']; 

    $sel_con = "SELECT * FROM contributes WHERE contribute_id = '$contribute_id'";
    $result = mysqli_query($conn, $sel_con);
    if ($result -> num_rows > 0) {
        $current_amount = $result -> fetch_assoc()['current_amount'] + $donated_amount;
        $sel_con1 = "UPDATE contributes SET current_amount = '$current_amount' WHERE contribute_id = '$contribute_id'";
        mysqli_query($conn, $sel_con1);
        $sel_con1 = "SELECT * FROM contributes WHERE contribute_id = '$contribute_id'";
        $senddata['contribute'] = mysqli_query($conn, $sel_con1) -> fetch_assoc();
        $sel_con1 = "SELECT * FROM contributes WHERE contribute_id = '$contribute_id'";
        $sel_con1 = "INSERT donates (contribute_id, donated_user_id, donated_member_name, donated_member_phone, donated_time, donated_amount) VALUES ('$contribute_id', '$donated_user_id', '$donated_member_name', '$donated_member_phone', '$donated_time', '$donated_amount')";
        mysqli_query($conn, $sel_con1);
        $donate_id = mysqli_insert_id($conn);
        $sel_con1 = "SELECT * FROM donates WHERE donate_id = '$donate_id'";
        $senddata['donate'] = mysqli_query($conn, $sel_con1) -> fetch_assoc();
        return response(true, "Success to donate $".$donated_amount, $senddata);

    }
    else {
        return response(false, "Not exist contribute", NULL);
    }
}

function getDetail() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (isset($data['group_id'])) {
        $group_id = $data['group_id'];
        $sel_con = "SELECT * FROM groups WHERE group_id = '$group_id'";
        $result = mysqli_query($conn, $sel_con);
        if ($result -> num_rows > 0) {
            $sel_con = "SELECT * FROM contributes WHERE created_group_id = '$group_id'";
            $result = mysqli_query($conn, $sel_con);
            if ($result -> num_rows > 0) {
                $contributes = array();
                while ($contribute = $result -> fetch_assoc()) {
                    array_push($contributes, $contribute);
                }
                $senddata['contributes'] = $contributes;
            }

            $sel_con = "SELECT * FROM members WHERE group_id = '$group_id'";
            $result = mysqli_query($conn, $sel_con);
            if ($result -> num_rows > 0) {
                $members = array();
                while ($row = $result -> fetch_assoc()) {
                    $phone_number = $row['phone_number'];
                    $sel_con1 = "SELECT * FROM users";
                    $result1 = mysqli_query($conn, $sel_con1);
                    while ($row1 = $result1 -> fetch_assoc()) {
                        $phones = array();
                        $main_phone = $row1['main_phone'];
                        $other_phones = $row1['other_phones'];
                        if ($other_phones != "") {
                            $phones = explode(",", $other_phones);
                        }
                        array_push($phones, $main_phone);
                        if (in_array($phone_number, $phones)) {
                            $member = $row;
                            $member['name'] = $row1['name'];
                            $member['isOnLine'] = $row1['isOnLine'];
                            array_push($members, $member);
                        }
                    }
                }
                $senddata['members'] = $members;
            }
            return response(true, "", $senddata);
        }
        else {
            return response(false, "Not exist group", NULL);
        }
        
    }
    else if (isset($data['contribute_id'])) {
        $contribute_id = $data['contribute_id'];
        $sel_con = "SELECT * FROM donates WHERE contribute_id = '$contribute_id'";
        $result = mysqli_query($conn, $sel_con);
        if ($result -> num_rows > 0) {
            $donates = array();
            while ($donate = $result -> fetch_assoc()) {
                array_push($donates, $donate);
            }
            $senddata['donates'] = $donates;
            return response(true, "", $senddata);
        }
        else {
            return response(false, "Not exist donates", NULL);
        }
        
    }
    else {
        return response(false, "Need more parameters", NULL);
    } 
}

function removeMember() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (isset($data['member_id'])) {
        $member_id = $data['member_id'];
        $sel_con = "SELECT * FROM members WHERE member_id = '$member_id'";
        $result = mysqli_query($conn, $sel_con);
        if ($result -> num_rows > 0) {
            $sel_con1 = "DELETE FROM members WHERE member_id = '$member_id'";
            mysqli_query($conn, $sel_con1);
            return response(true, "Success to remove a member", NULL);
        }
        else {
            return response(false, "Not exist member", NULL);
        }
        
    }
    else {
        return response(false, "Need more parameters", NULL);
    } 
}

function reloadData() {
    global $conn;
    global $data;
    $senddata = [];
    
    if (isset($data['user_id'])) {
        $user_id = $data['user_id'];
        $sel_con = "SELECT * FROM users WHERE id = '$user_id'";
        $result = mysqli_query($conn, $sel_con);
        if ($result -> num_rows > 0) {
            $profile = $result -> fetch_assoc();
            $phones = array();
            $main_phone = $profile['main_phone'];
            $other_phones = $profile['other_phones'];
            if ($other_phones != "") {
                $phones = explode(",", $other_phones);
            }
            array_push($phones, $main_phone);
            $groups = array();
            for ($i = 0; $i < count($phones); $i++) {
                $phone_number = $phones[$i];
                $sel_con2 = "SELECT * FROM members WHERE phone_number = '$phone_number'";
                $result2 = mysqli_query($conn, $sel_con2);
                if ($result2 -> num_rows > 0) {
                    while ($member = $result2 -> fetch_assoc()) {
                        $group_id = $member['group_id'];
                        $sel_con3 = "SELECT * FROM groups WHERE group_id = '$group_id'";
                        $result3 = mysqli_query($conn, $sel_con3);
                        if ($result3 -> num_rows > 0) {
                            array_push($groups, $result3 -> fetch_assoc());
                        }
                    }
                }
                
            }

            if (count($groups) > 0) {
                $senddata['groups'] = $groups;
                return response(true, "", $senddata);
            }
            else {
                return response(false, "", NULL);
            }
        }
        else {
            return response(false, "Unregistered user", NULL);
        }
    }  
    else if (isset($data['group_id'])) {
        $group_id = $data['group_id'];
        $sel_con = "SELECT * FROM groups WHERE group_id = '$group_id'";
        $result = mysqli_query($conn, $sel_con);
        if ($result -> num_rows > 0) {
            $sel_con = "SELECT * FROM contributes WHERE created_group_id = '$group_id'";
            $result = mysqli_query($conn, $sel_con);
            if ($result -> num_rows > 0) {
                $contributes = array();
                while ($contribute = $result -> fetch_assoc()) {
                    array_push($contributes, $contribute);
                }
                $senddata['contributes'] = $contributes;
            }

            $sel_con = "SELECT * FROM members WHERE group_id = '$group_id'";
            $result = mysqli_query($conn, $sel_con);
            if ($result -> num_rows > 0) {
                $members = array();
                while ($row = $result -> fetch_assoc()) {
                    $phone_number = $row['phone_number'];
                    $sel_con1 = "SELECT * FROM users";
                    $result1 = mysqli_query($conn, $sel_con1);
                    while ($row1 = $result1 -> fetch_assoc()) {
                        $phones = array();
                        $main_phone = $row1['main_phone'];
                        $other_phones = $row1['other_phones'];
                        if ($other_phones != "") {
                            $phones = explode(",", $other_phones);
                        }
                        array_push($phones, $main_phone);
                        if (in_array($phone_number, $phones)) {
                            $member = $row;
                            $member['name'] = $row1['name'];
                            $member['isOnLine'] = $row1['isOnLine'];
                            array_push($members, $member);
                        }
                    }
                }
                $senddata['members'] = $members;
            }
            return response(true, "", $senddata);
        }
        else {
            return response(false, "Not exist group", NULL);
        }
        
    }
    else if (isset($data['contribute_id'])) {
        $contribute_id = $data['contribute_id'];
        $sel_con = "SELECT * FROM donates WHERE contribute_id = '$contribute_id'";
        $result = mysqli_query($conn, $sel_con);
        if ($result -> num_rows > 0) {
            $donates = array();
            while ($donate = $result -> fetch_assoc()) {
                array_push($donates, $donate);
            }
            $senddata['donates'] = $donates;
            return response(true, "", $senddata);
        }
        else {
            return response(false, "Not exist donates", NULL);
        }
        
    }
    else {
        return response(false, "Need more parameters", NULL);
    }
}




switch ($_GET['action']) {
    case "register":
        register();
        break;
    case "login":
        login();
        break;
    case "creategroup":
        createGroup();
        break;
    case "addmember":
        addMember();
        break;
    case "createcontribute":
        createContribute();
        break;
    case "reloaddata":
        reloadData();
        break;    
        case "addphone":
            addPhone();
            break;
    case "getdetail":
        getDetail();        
        break;
    case "removemember":
        removeMember();
        break;
    case "adddonate":
        addDonate();
        break;
    default:
    response(false, "Undefined request", NULL);
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