$(document).ready(function () {
    GetAllPrograms()
    $("#btnAddprm").click(function () {
    

        $("#modalAddprm").modal("show")
       if ($("#hdnprmId").val() == "0") {
            $("#ddlStatus").val("1").attr("disabled",true)
        }
        //FillDropDownList("UserManage/GetUserByRole", {"RoleId":2},"ddlManager")
    })

    $("#btnSubmit").click(function () {
        if ($("#hdnprmId").val() == "0") {
            SubmitData()
        }
        else {
            SubmitDataUpdate()
           
        }
    })
})

function GetAllPrograms() {
    $.ajax({
        "url": base_url +"ProgramAccess/getAllProgramName",
        "method": "GET",
        contentType: JSON,
        headers: {
            "Authorization": "Bearer" + localStorage.getItem("token")
        },
       
        "success": function (response) {
            if (response.ok) {
                 console.log(response)
                $("#tblprogram").DataTable({
                    data: response.data,
                    columns: [
                        { "data": "id" },
                        { "data": "p_title" },
                        { "data": "path" },
                        { "data": "descr" },
                        { "data": "display_Sequence" },
                        {
                            "data": "status", render: function (status) {
                                return status==1?"Active":"InActive"
                            }
                        },
                        
                        {
                            "data": "id", class: "text-center", render: function (id) {
                                var btn = '<a class="btn btn-sm btn-primary" onclick="Edit(' + id + ')">Edit</a>'
                                return btn
                            },
                        }

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

function Edit(id) {
    $("#modalAddprm .modal-title").html("Update Program")
   
    $("#hdnprmId").val(id)
    $("#modalAddprm").modal("show")
   // FillDropDownList("UserManage/GetUserByRole", { "RoleId": 2 }, "ddlManager", false)

    $.ajax({
        "url": base_url + "ProgramAccess/GetSingleProgram",
        "method": "GET",
        contentType: JSON,
        headers: {
            "Authorization": "Bearer " + localStorage.getItem("token")
        },
        "data": { "id": id },
        "success": function (response) {
            if (response.ok) {
                console.log(response)
                var data = response.data;
                $("#txtProgram").val(data.p_title)
                $("#txtPath").val(data.path)
                $("#txtDescription").val(data.descr)
                $("#txtDisplay_Sequence").val(data.display_Sequence)
                $("#ddlStatus").val(data.status).removeAttr("disabled")

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

function SubmitData() {

    isValid = requiredTextFiled("Program", "program name")
    if (!isValid) { return false }

    isValid = requiredTextFiled("Path", "Path")
    if (!isValid) { return false }

    isValid = requiredTextFiled("Description", "Description")
    if (!isValid) { return false }

    isValid = requiredTextFiled("Display_Sequence", "Display_Sequence")
    if (!isValid) { return false }
    

    var data = new FormData()
    data.append("P_title", $("#txtProgram").val())
    data.append("Path", $("#txtPath").val())
    data.append("Descr", $("#txtDescription").val())
    data.append("Display_Sequence", $("#txtDisplay_Sequence").val())
    data.append("Status", $("#ddlStatus").val())
   

    $.ajax({
        "url": base_url + "ProgramAccess/AddPrograms",
        "method": "POST",
        cache: false,
        contentType: false,
        processData: false,
        headers: {
            "Authorization": "Bearer" + localStorage.getItem("token")
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

function SubmitDataUpdate() {


    isValid = requiredTextFiled("Program", "program name")
    if (!isValid) { return false }

    isValid = requiredTextFiled("Path", "Path")
    if (!isValid) { return false }

    isValid = requiredTextFiled("Description", "Description")
    if (!isValid) { return false }

    isValid = requiredTextFiled("Display_Sequence", "Display_Sequence")
    if (!isValid) { return false }



var data = new FormData()
data.append("Id", $("#hdnprmId").val())
data.append("P_title", $("#txtProgram").val())
data.append("Path", $("#txtPath").val())
data.append("Descr", $("#txtDescription").val())
data.append("Display_Sequence", $("#txtDisplay_Sequence").val())
data.append("Status", $("#ddlStatus").val())

    $.ajax({
        "url": base_url + "ProgramAccess/UpdateProgram",
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
                $("#hdnprmId").val("0")
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