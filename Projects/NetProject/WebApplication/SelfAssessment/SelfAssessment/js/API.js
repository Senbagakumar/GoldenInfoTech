﻿var API = {
    baseUrl: 'http://localhost:26578/',

    GetSubSectors: function () {
        return this.baseUrl + "User/GetSubSector/";
    },

    CreateUser: function () {
        return this.baseUrl + "User/CreateOrganization";
    },

    LoginSuccess: function () {
        return this.baseUrl + "User/Success";
    },

    TypesOfServiceCreation: function () {
        return this.baseUrl + "TypesOfService/Create";
    },

    TypesOfServiceHome: function () {
        return this.baseUrl + "TypesOfService/Index";
    },

    TypesOfServiceDelete: function () {
        return this.baseUrl + "TypesOfService/Delete/";
    },

    CreateSubSector: function () {
        return this.baseUrl + "SubSector/Create";
    },

    SubSectorHome: function () {
        return this.baseUrl + "SubSector/Index";
    },
    SubSectorDelete: function () {
        return this.baseUrl + "SubSector/Delete/";
    },
    StateHome: function () {
        return this.baseUrl + "State/Index";
    },
    StateDelete: function () {
        return this.baseUrl + "State/Delete/";
    },
    StateCreate: function () {
        return this.baseUrl + "State/Create";
    },
    SectorHome: function () {
        return this.baseUrl + "Sector/Index";
    },
    SectorDelete: function () {
        return this.baseUrl + "Sector/Delete";
    },
    SectorCreate: function () {
        return this.baseUrl + "Sector/Create";
    },
    RevenueHome: function () {
        return this.baseUrl + "Revenue/Index";
    },
    RevenueDelete: function () {
        return this.baseUrl + "Revenue/Delete";
    },
    RevenueCreate: function () {
        return this.baseUrl + "Revenue/Create";
    },
    SaveQuestionByUserByOne: function () {
        return this.baseUrl + "ManageUser/QuizOne";
    },
    GetQuestionByOne: function () {
        return this.baseUrl + "ManageUser/GetFirstQuestion/";
    },
    UserChangePassword: function () {
        return this.baseUrl + "ManageUser/ChangePassword";
    },
    GetAssessmentDetails: function () {
        return this.baseUrl + "ManageAssessment/GetAssessMentDetails/";
    },
    GetSubSectorForAssessment: function () {
        return this.baseUrl + "ManageAssessment/GetSubSector/";
    },
    AssessmentSave: function () {
        return this.baseUrl + "ManageAssessment/SaveAssessment";
    },
    AssessmentHome: function () {
        return this.baseUrl + "ManageAssessment/Index";
    },
    AssessmentDelete: function () {
        return this.baseUrl + "ManageAssessment/DeleteAssessMentById/";
    },
    AssignQuestionHome: function () {
        return this.baseUrl + "ManageAssessment/AssignQuestion";
    },
    AssignQuestionSave: function () {
        return this.baseUrl + "ManageAssessment/SaveQuestion";
    },
    AssignQuestionGet: function () {
        return this.baseUrl + "ManageAssessment/GetQuestionByAssignmentId/";
    },
    AssignOrganizationGet: function () {
        return this.baseUrl + "ManageAssessment/AssignOrganizationByFilter";
    },
    AssignOrganizationMoveNextLevel: function () {
        return this.baseUrl + "ManageAssessment/MoveToNextLevel/";
    },
    AssignOrganizationHome: function () {
        return this.baseUrl + "ManageAssessment/AssignOrganization/";
    },
    GroupGetQuestions: function () {
        return this.baseUrl + "Group/GetAllQByGroupId/";
    },
    GroupDelete: function () {
        return this.baseUrl + "Group/DeleteGroupById/";
    },
    GroupSave: function () {
        return this.baseUrl + "Group/SaveGroup";
    },
    GroupHome: function () {
        return this.baseUrl + "Group/Index";
    },
    QuestionGet: function () {
        return this.baseUrl + "Group/GetQuestionById/";
    },
    QuestionDelete: function () {
        return this.baseUrl + "Group/DeleteQuestionById/";
    },
    QuestionSave: function () {
        return this.baseUrl + "Group/CreateQuestion";
    },
    CityHome: function () {
        return this.baseUrl + "City/Index";
    },
    CitySave: function () {
        return this.baseUrl + "City/Create";
    },
    CityDelete: function () {
        return this.baseUrl + "City/Delete/";
    },
    OrganizationGet: function () {
        return this.baseUrl + "ManageOrg/AssignOrganizationByFilter";
    },
    OrganizationDelete: function () {
        return this.baseUrl + "ManageOrg/DeleteOrganization/";
    },
    OrganizationView: function () {
        return this.baseUrl + "ManageOrg/ViewOrganization";
    },
    OrganizationUpdate: function () {
        return this.baseUrl + "ManageOrg/UpdateOrganization";
    },
    CustomerAssessmentReadOnly: function () {
        return this.baseUrl + "ManageUser/CustomerAssessment";
    },
    CustomerDetailReport: function () {
        return this.baseUrl + "/Admin/CustomerAssessmentReport";
    },
    AdminGetGroupDetailsByFilter: function () {
        return this.baseUrl + "/Admin/GetFirstGroup/";
    },
    CustomerReport: function () {
        return this.baseUrl + "/ManageUser/CustomerAssessment";
    },
    UserGetGroupDetails: function () {
        return this.baseUrl + "/ManageUser/GetFirstGroup/";
    },
    OrganizationLevel1Report: function () {
        return this.baseUrl + "/Report/GetOrganizationalScoreLevel1";
    },
    OrganizationLevel1FinalReport: function () {
        return this.baseUrl + "/Report/GetFinalScoreLevel1";
    },
    SectorLevel1Report: function () {
        return this.baseUrl + "/Report/GetSectorOrganizationalScoreLevel1";
    },
    SectorLevel1FinalReport: function () {
        return this.baseUrl + "/Report/GetSectorFinalScoreLevel1";
    },
    OrganizationLevel2Report: function () {
        return this.baseUrl + "/Report/GetOrganizationalScoreLevel2";
    },
    OrganizationLevel2FinalReport: function () {
        return this.baseUrl + "/Report/GetFinalScoreLevel2";
    },
    SectorLevel2Report: function () {
        return this.baseUrl + "/Report/GetSectorOrganizationalScoreLevel2";
    },
    SectorLevel2FinalReport: function () {
        return this.baseUrl + "/Report/GetSectorFinalScoreLevel2";
    },
    OrganizationLevel3Report: function () {
        return this.baseUrl + "/Report/GetOrganizationalScoreLevel3";
    },
    OrganizationLevel3FinalReport: function () {
        return this.baseUrl + "/Report/GetFinalScoreLevel3";
    },
    SectorLevel3Report: function () {
        return this.baseUrl + "/Report/GetSectorOrganizationalScoreLevel3";
    },
    SectorLevel3FinalReport: function () {
        return this.baseUrl + "/Report/GetSectorFinalScoreLevel3";
    }
};