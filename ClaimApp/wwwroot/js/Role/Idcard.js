$(document).ready(function () {
    GetAllIdcard()
    $("#btnAdd").click(function () {
        $("#modalIdcard").modal("show")
        if ($("#hdnRoleId").val() == "0") {
            $("#ddlStatus").val("1").attr("disabled", true)
        }
    })

    $("#btnSubmit").click(function () {
        // SubmitData()
        if ($("#hdnRoleId").val() == "0") {
            SubmitData()
        }
        else {
            SubmitDataUpdate()

        }
    })
})

function GetAllIdcard() {
    $.ajax({
        "url": base_url + "RoleManage/GetIdcard",
        "method": "GET",
        contentType: JSON,
        headers: {
            "Authorization": "Bearer " + localStorage.getItem("token")
        },
        "success": function (response) {
            if (response.ok) {
                // console.log(response)
                $("#tblIdcard").DataTable({
                    data: response.data,
                    columns: [
                        { "data": "id" },
                        { "data": "name" },
                        { "data": "email" },
                        { "data": "mobile" },
                        {
                            "data": "id", class: "text-center", render: function (id) {
                                var btn = '<a class="btn btn-sm btn-info"  onclick="getIdcardData(' + id + ')">IdCard</a>'
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

function idcard(id) {
    $("#idCardModal").modal("show")
}

function downloadPDF() {
    // Create an instance of jsPDF
    const pdf = new jsPDF();

    // Add the content of the current page to the PDF
    pdf.html(document.body, {
        callback: function () {
            // Save the PDF with a specified name
            pdf.save('document.pdf');
        }
    });
}

function getIdcardData(id) {

    $("#txtid").val(id)
    $("#idCardModal").modal("show")
    $.ajax({
        "url": base_url + "RoleManage/GetSingleIdcard",
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
                $("#firstName").val(data.name)
                $("#txtemail").val(data.email)
                $("#txtmobile").val(data.mobile)
                $("#txtaddress").val()
                $("#txtid").val(data.id)

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

/*
function SubmitData() {

    isValid = requiredTextFiled("RoleName", "role name")
    if (!isValid) { return false }

    isValid = requiredSelectFiled("Status", "status")
    if (!isValid) { return false }

    var data = new FormData()
    data.append("RoleName", $("#txtRoleName").val())
    data.append("Status", $("#ddlStatus").val())

    $.ajax({
        "url": base_url + "RoleManage/CreateRole",
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

function SubmitDataUpdate() {

    isValid = requiredTextFiled("RoleName", "role name")
    if (!isValid) { return false }

    isValid = requiredSelectFiled("Status", "status")
    if (!isValid) { return false }


    var data = new FormData()
    data.append("RoleName", $("#txtRoleName").val())
    data.append("Id", $("#hdnRoleId").val())
    data.append("Status", $("#ddlStatus").val())

    $.ajax({
        "url": base_url + "RoleManage/UpdateRole",
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
                $("#hdnRoleId").val("0")
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
*/