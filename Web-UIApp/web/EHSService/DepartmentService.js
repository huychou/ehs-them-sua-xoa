
define([
    'app',
    'angular'
], function (app, angular) {
    app.service('DepartmentService', ['$resource', '$q', 'Auth', '$location', '$translate', function ($resource, $q, Auth, $location, $translate) {
        function DepartmentService() {
            var _WASTERAPI = '/Waste/';
            this.GetInfoBasic = $resource(_WASTERAPI + 'MyNewController/:operation', {}, {
                addCompany:
                {
                    method: 'POST',
                    params: {
                        operation: 'AddCompany'
                    },
                },
                getcompany:
                {
                    method: 'GET',
                    params: {
                        operation: 'GetCompany'
                    },
                    isArray: true
                },
                GetDataDepartment:
                {
                    method: 'GET',
                    params: {
                        operation: 'GetDataDepartment'
                    },
                    isArray: true
                },

                updateCompany:
                {
                    method: 'POST',
                    params: {
                        operation: 'UpdateCompany'
                    },
                    
                },

                DeleteCompany:
                {
                    method: 'DELETE',
                    params: {
                        operation: 'DeleteCompany'
                    },
                   
                }

            })
        }

        DepartmentService.prototype.AddCompany = function (query, callback) {
            this.GetInfoBasic.addCompany(query).$promise.then(function (data) {
                callback(data);
            }, function (ex) {
                console.log(ex);
                callback(null, ex);
            })
        }
        DepartmentService.prototype.GetDataCompany = function (callback) {
            this.GetInfoBasic.getcompany().$promise.then(function (data) {
                callback(data);
            }, function (ex) {
                console.log(ex);
                callback(null, ex);
            })
        }

        DepartmentService.prototype.GetDataDepartment_Function = function (query, callback) {
            this.GetInfoBasic.GetDataDepartment(query).$promise.then(function (data) {
                callback(data);
            }, function (ex) {
                console.log(ex);
                callback(null, ex);
            })
        }

        DepartmentService.prototype.UpdateCompany = function (query, callback) {
            this.GetInfoBasic.updateCompany(query).$promise.then(function (data) {
                callback(data);
            }, function (ex) {
                console.log(ex);
                callback(null, ex);
            })
        }

        DepartmentService.prototype.DeleteCompany_fc = function (query, callback) {
            this.GetInfoBasic.DeleteCompany(query).$promise.then(function (data) {
               
                callback(data);
            }, function (ex) {
                console.log(ex);
                callback(null, ex);
            })
        }


        return new DepartmentService();
    }]);

});