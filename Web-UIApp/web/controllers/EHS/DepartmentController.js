
define(['myapp', 'angular'], function (myapp, angular) {
    myapp.controller('DepartmentController', ['$filter', 'Notifications', 'Auth', '$translate', '$q', '$scope', 'DepartmentService',
        function ($filter, Notifications, Auth, $translate, $q, $scope, DepartmentService) {

            console.log("Test depart controller");

            $scope.headers = [];
            $scope.list = [];

            $scope.cost = '';
            $scope.spec = '';

            $scope.entity = {};

            DepartmentService.GetDataCompany(function (res) {
                console.log(res);
                ShowData(res);
            })




            $scope.SearchFunction = function () {

                var bienthongso = {
                    costcenter: $scope.cost,
                    spec: $scope.spec
                };
                DepartmentService.GetDataDepartment_Function(bienthongso, function (res) {
                    console.log(res);
                    ShowData(res);
                })
            }

            $scope.AddCompanyFunction = function () {
                DepartmentService.AddCompany($scope.entity, function (res) {
                    if (res.Success) {
                        Notifications.addMessage(
                            { 'status': 'information', 'message': $translate.instant('Thêm thành công') });

                    } else {
                        Notifications.addError({
                            'status': 'error',
                            'message': $translate.instant('saveError') + res.Message
                        });
                    }
                })
            }

            $scope.UpdateCompanyFunction = function (item) {
                
                // DepartmentService.UpdateCompany($scope.entity, function (res) {
                //     if (res.Success) {
                //         Notifications.addMessage(
                //             { 'status': 'information', 'message': $translate.instant('sửa thành công') });
                //     } 
                //     else {
                //         Notifications.addError({
                //             'status': 'error',
                //             'message': $translate.instant('saveError') + res.Message
                //         });
                //     }
                // })
            }

            $scope.DeleteCompanyFunction = function (item) {
               
              
                DepartmentService.DeleteCompany_fc(item, function (res) {
                 //   $scope.list.splice(item, 1);// chỉ xóa trên view, load lại trang thì lại ra
                    if (res.Success) {
                        Notifications.addMessage(
                            { 'status': 'information', 'message': $translate.instant('xóa thành công') });

                    } else {
                        Notifications.addError({
                            'status': 'error',
                            'message': $translate.instant('saveError') + res.Message
                        });
                    }
                   
                })
            }

            function ShowData(data) {
                $scope.list = data;
                $scope.headers = [];
                for (var key in data[0]) {

                    if (key.indexOf('$') < 0) {
                        $scope.headers.push({ name: key });
                    }
                }
            }


        }])
})