$(document).ready(function () {

    GetAllRole()

    $("#btnSubmit").click(function () {

        SubmitData()

    })
})


function GetAllRole() {
    $.ajax({
        "url": base_url + "RoleManage/getAllrole",
        "method": "GET",
        contentType: JSON,
        headers: {
            "Authorization": "Bearer " + localStorage.getItem("token")
        },
        "success": function (response) {
            if (response.ok) {

                var options = "<option value='-1'>Select</option>"
                response.data.forEach(function (item, i) {
                    options += "<option data='" + item.role + "' value=" + item.id + ">" + item.name + "</option>"
                })
                $("#ddlRoleName").html(options)
            }
        }
    })
}
$("#ddlRoleName").change(function () {
    var role = $("#ddlRoleName option:selected").attr("data")
    /*$("#errRoleName")*//*.html("Existing Role : " + role)*/
    GetAllRigthsbyrole($("#ddlRoleName").val())
})

function SubmitData() {


    isValid = requiredSelectFiled("RoleName", "user name")
    if (!isValid) { return false }

    var programs = []
    $.each($("#tblUserRights .checkRights"), function (e, ee) {
        var id = $(ee).val()
        var ischecked = 0;
        if ($(ee).is(':checked')) {
            ischecked = 1
        }
        var obj = { id, ischecked }
        programs.push(obj)
    })
    console.log(JSON.stringify(programs))
    var data = new FormData()
    data.append("roleId", $("#ddlRoleName").val())
    data.append("lstPrograms", JSON.stringify(programs))

    $.ajax({
        "url": base_url + "RoleManage/AssignRightsByRole",
        "method": "POST",
        cache: false,
        contentType: false,
        processData: false,
        headers: {
            "Authorization": "Bearer " + localStorage.getItem("token")
        },
        "data": data,
        "success": function (response) {
            if (response.ok) {
                $("#msg").html(response.message).css("color", "green")
                setTimeout(function () {
                    location.reload()
                }, 3000)
            }
            else {
                $("#msg").html(response.message).css("color", "red")
            }
        },
        "error": function (err) {
            console.log(err)
        }
    })


}

function GetAllRigthsbyrole(userid) {
    $.ajax({
        "url": base_url + "RoleManage/GetAllprogrambyrole",
        "method": "GET",
        contentType: JSON,
        headers: {
            "Authorization": "Bearer " + localStorage.getItem("token")
        },
        "data": { "RoleId": userid },
        "success": function (response) {
            if (response.ok) {
                // console.log(response)
                $("#tblUserRights").DataTable().destroy()
                $("#tblUserRights").DataTable({
                    data: response.data,
                    columns: [
                        {
                            "data": "id", "width": "150px", render: function (id, data, row) {
                                var checkbox = ""
                                if (row.ischecked == 1) {
                                    checkbox = "<input type='checkbox' class='checkRights' checked value='" + id + "' />"
                                    return checkbox
                                }
                                else {
                                    checkbox = "<input type='checkbox' class='checkRights' value='" + id + "' />"
                                    return checkbox
                                }

                            }
                        },
                        { "data": "title", "width": "150px" },
                        { "data": "descr", "width": "400px" }

                    ]
                })
            }
            else {
                $("#msg").html(response.message).css("color", "red")
            }
        },
        "error": function (err) {
            console.log(err)
        }
    })
}
