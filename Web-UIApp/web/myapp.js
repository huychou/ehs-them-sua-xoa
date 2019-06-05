/**
 * Created by wangyanyan on 14-3-3.
 */

define(['angularAMD', 'app', 'services/main', 'directive/main'], function (angularAMD, app) {
    app.config(['$routeProvider', '$httpProvider', '$translateProvider', '$translatePartialLoaderProvider', function ($routeProvider, $httpProvider, $translateProvider, $translatePartialLoaderProvider) {

        ////拦截器
        $httpProvider.responseInterceptors.push('interceptor');
        var spinnerFunction = function (data, headersGetter) {
            // todo start the spinner here
            $('#spinner_wait').show();
            return data;
        };
        $httpProvider.defaults.transformRequest.push(spinnerFunction);
        var lang = window.localStorage.lang || 'EN';
        /*    $translateProvider.useStaticFilesLoader({
         prefix: 'i18n/Basic/',
         suffix: '.json'
         });*/

        $translatePartialLoaderProvider.addPart('Basic');

        $translateProvider.useLoader('$translatePartialLoader', {
            urlTemplate: '/i18n/{part}/{lang}.json'
        });

        $translateProvider.preferredLanguage(lang);
        $translateProvider.fallbackLanguage(lang);


        $routeProvider
		
            .when('/', {
                redirectTo: '/taskForm/main'
            })
            
            .when('/taskForm/startList', angularAMD.route({
                templateUrl: "views/startList.html",
                controller: 'startListController',
                controllerUrl: 'controllers/startListController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/main', angularAMD.route({
                templateUrl: "views/main.html",
                controller: 'mainController',
                controllerUrl: 'controllers/mainController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/start/:id', angularAMD.route({
                templateUrl: "views/load.html",
                controller: 'startController',
                controllerUrl: 'controllers/startController',
                caseInsensitiveMatch: true,
                resolve: {

                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/processlog/:id/:cId?', angularAMD.route({
                templateUrl: "views/processLog.html",
                controller: 'processlogController',
                controllerUrl: 'controllers/processlogController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/:processDefinitionId/complete/:pid', angularAMD.route({
                templateUrl: 'views/taskCompleted.html',
                controller: 'startFinishedController',
                controllerUrl: 'controllers/startFinishedController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/todo', angularAMD.route({
                templateUrl: "views/todo.html",
                controller: 'todoController',
                controllerUrl: 'controllers/todoController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/task/:taskid/:pid', angularAMD.route({
                templateUrl: "views/load.html",
                controller: 'doTaskController',
                controllerUrl: 'controllers/doTaskController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/:taskid/complete/:pid', angularAMD.route({
                templateUrl: 'views/taskCompleted.html',
                controller: 'taskFinishedController',
                controllerUrl: 'controllers/taskFinishedController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/TaskManage', angularAMD.route({
                templateUrl: 'views/TaskManage.html',
                controller: 'TaskManageController',
                controllerUrl: 'controllers/TaskManageController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/RepositoryManage', angularAMD.route({
                templateUrl: 'views/RepositoryManage.html', 
                controller: 'RepositoryController', 
                controllerUrl: 'controllers/RepositoryController', 
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/DictionaryManage', angularAMD.route({
                templateUrl: 'views/DictionaryManage.html',
                controller: 'DictionaryController',
                controllerUrl: 'controllers/DictionaryController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/taskForm/ProxyUser', angularAMD.route({
                templateUrl: 'views/ProxyUser.html',
                controller: 'ProxyUserController',
                controllerUrl: 'controllers/ProxyUserController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))

            .when('/main/userInfo', angularAMD.route({
                templateUrl: "views/pages/userInfo.html",
                controller: 'UserInfoController',
                controllerUrl: 'controllers/mainController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))

            .when('/png/:processDefinitionId/:pid', angularAMD.route({
                templateUrl: 'views/pages/png.html',
                controller: 'PngController',
                controllerUrl: 'controllers/historyController',
                caseInsensitiveMatch: true
            }))
            .when('/login', angularAMD.route({
                templateUrl: 'views/login.html',
                controller: 'loginController',
                controllerUrl: 'controllers/loginController'

            }))
            .when('/logout', angularAMD.route({
                templateUrl: 'views/login.html',
                controller: 'logoutController',
                controllerUrl: 'controllers/loginController'
            }))
            .when('/FormSetting/formmain', angularAMD.route({
                templateUrl: "views/formMaintain.html",
                controller: 'formMaintainController',
                controllerUrl: 'controllers/formMaintainControl',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
             /**
             * Creat Route by Isaac 08/11/2018
             */
            .when('/waste/Main', angularAMD.route({
                templateUrl: "forms/EHS/main.html",
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/waste/Company', angularAMD.route({
                templateUrl: "forms/EHS/Company/searchCompany.html",
                controller: 'CompanyController',
                controllerUrl: 'controllers/EHS/Waste/CompanyController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/waste/Method', angularAMD.route({
                templateUrl: "forms/EHS/Method/searchMethod.html",
                controller: 'MethodProcessController',
                controllerUrl: 'controllers/EHS/Waste/MethodProcessController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/waste/Voucher/print/:code', angularAMD.route({
                templateUrl: "forms/EHS/Voucher/detail.html",
                controller: 'VoucherDetailController',
                controllerUrl: 'controllers/EHS/Waste/VoucherDetailController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/waste/WasteItem', angularAMD.route({
                templateUrl: "forms/EHS/WasteItem/searchWasteItem.html",
                controller: 'WasteItemController',
                controllerUrl: 'controllers/EHS/Waste/WasteItemController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/waste/Voucher', angularAMD.route({ //route
                templateUrl: "forms/EHS/Voucher/searchVoucher.html", //view
                controller: 'VoucherController', //controller
                controllerUrl: 'controllers/EHS/Waste/VoucherController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))
            .when('/newhse/mypage', angularAMD.route({ //route
                
                templateUrl: "forms/EHS/Department/searchDepartment.html",
                controller: 'DepartmentController',
                controllerUrl: 'controllers/EHS/DepartmentController',
                caseInsensitiveMatch: true,
                resolve: {
                    User: function (AuthenticationLoader) {
                        return AuthenticationLoader();
                    }
                }
            }))

    }]);
    return angularAMD.bootstrap(app);
});