﻿using SelfAssessment.DataAccess;
using SelfAssessment.Models;
using SelfAssessment.Models.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SelfAssessment.Business
{
    public class ScoreReport
    {
        public static ScoreCalc CalculateScore(int userId, bool isFinalScore, string level, int assessmentId=0)
        {
            var scoreCalc = new ScoreCalc();
            var listOfGroupQuestions = new List<GroupQuiz>();
            var uInfo = new Repository<Organization>();
            int sectorValue = int.Parse(Utilities.SectorValue);

            var questionIds = new List<int>();
            if (assessmentId == 0)
            {
                var userSectorId = uInfo.Filter(q => q.Id == userId).FirstOrDefault();

                var assessmentDetails = uInfo.AssessmentContext.assessments.Where(q => q.Sector == userSectorId.SectorId).FirstOrDefault();
                if (assessmentDetails == null || assessmentDetails.Sector == 0)
                    assessmentDetails = uInfo.AssessmentContext.assessments.Where(q => q.Sector == sectorValue).FirstOrDefault();

                //var details = uInfo.AssessmentContext.UserInfo.Join(uInfo.AssessmentContext.assessments, u => u.SectorId, a => a.Sector, (u, a) => new { u, a }).Where(q => q.u.Id == userId).FirstOrDefault();
                questionIds = uInfo.AssessmentContext.assessmentLevelMappings.Where(q => q.AssessmentId == assessmentDetails.Id && q.Level == level).Select(q => q.QuestionId).ToList();
            }
            else
                questionIds = uInfo.AssessmentContext.assessmentLevelMappings.Where(q => q.AssessmentId == assessmentId && q.Level == level).Select(q => q.QuestionId).ToList();

            var lQuestions = uInfo.AssessmentContext.questions.Where(q => questionIds.Contains(q.Id)).GroupBy(q => q.GroupId).Select(q => new { Questions = q.ToList(), Type = q.Key }).OrderBy(t => t.Type).ToList();

            scoreCalc.UserId = userId;
            scoreCalc.Scores = new List<GraphDynam>();

            
            lQuestions.ForEach(t =>
            {
                var dynamicScore = new GraphDynam();
                var group = uInfo.AssessmentContext.groups.Where(q => q.Id == t.Type).FirstOrDefault();
                dynamicScore.GroupName = group.Name;
                double weight = group.Weight > 0 ? Convert.ToDouble(group.Weight) : 1;
                double score = 0;

                t.Questions.ForEach(v => 
                {
                    var isAnswer = uInfo.AssessmentContext.answers.Where(a => a.QuestionId == v.Id && a.GroupId == v.GroupId && a.UserId == userId).FirstOrDefault();
                    if (isAnswer != null)
                    {
                        score += Utilities.CalculateScoreByAns(isAnswer.UserOptionId);
                        if (isFinalScore)
                            score = score * weight;
                    }

                });
                dynamicScore.MyScore =Convert.ToInt16((score /t.Questions.Count()));
                scoreCalc.Scores.Add(dynamicScore);
            });
            return scoreCalc;
        }    
        
        public static Graph OrganizationScore(int currentUserId,string level)
        {
            ScoreCalc myScore = CalculateScore(currentUserId,false, level);
            var uInfo = new Repository<Organization>();
            var lorgs = uInfo.Filter(t => t.Id != currentUserId).Select(q => q.Id).ToList();

            var otherOrg = new List<ScoreCalc>();
            foreach (var id in lorgs)
            {
                var scores = CalculateScore(id,false, level);
                otherOrg.Add(scores);
            }

            var graph = new Graph();
            graph.OtherOrg = new int[myScore.Scores.Count];
            graph.Org = new int[myScore.Scores.Count];
            graph.Groups = new string[myScore.Scores.Count];
            int i = 0;
            foreach (var grp in myScore.Scores)
            {                
                var other = otherOrg.Select(t => t.Scores.Where(v => v.GroupName == grp.GroupName)).ToList();
                var avg = other.Select(q => q.Average(t => t.MyScore)).FirstOrDefault();
                graph.OtherOrg[i] = Convert.ToInt16(avg);
                graph.Org[i]= Convert.ToInt16(grp.MyScore);
                graph.Groups[i] = grp.GroupName;
                i = i + 1;
            }
            return graph;

        }

        public static Graph OrganizationFinalScore(int currentUserId,string level)
        {
            ScoreCalc myScore = CalculateScore(currentUserId, true, level);
            var uInfo = new Repository<Organization>();
            var lorgs = uInfo.Filter(t => t.Id != currentUserId).Select(q => q.Id).ToList();

            var otherOrg = new List<ScoreCalc>();
            foreach (var id in lorgs)
            {
                var scores = CalculateScore(id, true, level);
                otherOrg.Add(scores);
            }

            var graph = new Graph();
            graph.OtherOrg = new int[1];
            graph.Org = new int[1];

            graph.Org[0] = myScore.Scores.Sum(q => q.MyScore);
            graph.OtherOrg[0] = otherOrg.Select(t => t.Scores.Sum(v => v.MyScore)).FirstOrDefault();

            return graph;

        }

        public static Graph OrganizationManufacturingScore(int currentUserId,string level)
        {
            ScoreCalc myScore = CalculateScore(currentUserId, false, level);
            var uInfo = new Repository<Organization>();
            var lorgs = uInfo.AssessmentContext.UserInfo.Join(uInfo.AssessmentContext.assessments, u => u.SectorId, a => a.Sector, (u, a) => new { u, a }).Where(q=> q.u.Id != currentUserId).Select(q=> q.u.Id).ToList();
            if (lorgs.Count == 0)
                lorgs = uInfo.AssessmentContext.UserInfo.Where(q => q.Id != currentUserId).Select(q => q.Id).ToList();
            var otherOrg = new List<ScoreCalc>();
            foreach (var id in lorgs)
            {
                var scores = CalculateScore(id, false, level);
                otherOrg.Add(scores);
            }

            var graph = new Graph();
            graph.OtherOrg = new int[myScore.Scores.Count];
            graph.Org = new int[myScore.Scores.Count];
            graph.Groups = new string[myScore.Scores.Count];
            int i = 0;
            foreach (var grp in myScore.Scores)
            {
                var other = otherOrg.Select(t => t.Scores.Where(v => v.GroupName == grp.GroupName)).ToList();
                var avg = other.Select(q => q.Average(t => t.MyScore)).FirstOrDefault();
                graph.OtherOrg[i] = Convert.ToInt16(avg);
                graph.Org[i] = Convert.ToInt16(grp.MyScore);
                graph.Groups[i] = grp.GroupName;
                i = i + 1;
            }
            return graph;

        }

        public static Graph OrganizationManufacturingFinalScore(int currentUserId,string level)
        {
            ScoreCalc myScore = CalculateScore(currentUserId, true, level);
            var uInfo = new Repository<Organization>();
            var lorgs = uInfo.AssessmentContext.UserInfo.Join(uInfo.AssessmentContext.assessments, u => u.SectorId, a => a.Sector, (u, a) => new { u, a }).Where(q => q.u.Id != currentUserId).Select(q => q.u.Id).ToList();
            if (lorgs.Count == 0)
                lorgs = uInfo.AssessmentContext.UserInfo.Where(q => q.Id != currentUserId).Select(q => q.Id).ToList();
            var otherOrg = new List<ScoreCalc>();
            foreach (var id in lorgs)
            {
                var scores = CalculateScore(id, true,level);
                otherOrg.Add(scores);
            }

            var graph = new Graph();
            graph.OtherOrg = new int[1];
            graph.Org = new int[1];
            graph.Org[0] = myScore.Scores.Sum(q => q.MyScore);
            graph.OtherOrg[0] = otherOrg.Select(t => t.Scores.Sum(v => v.MyScore)).FirstOrDefault();
            return graph;

        }

        
        public static Graph SectorOrganizationScore(int sectorId,int subSectorId, string level, int assementId)
        {            
            var uids = new List<int>();

            var uInfo = new Repository<Organization>();
            var lorgs = uInfo.AssessmentContext.UserInfo.Join(uInfo.AssessmentContext.assessments, u => u.SectorId, a => a.Sector, (u, a) => new { u, a }).ToList();
            if (lorgs.Count == 0)
            {
                uids = uInfo.AssessmentContext.UserInfo.Select(q => q.Id).ToList();
            }
            else
            {
                if (sectorId > 0 && sectorId != 1001)
                    lorgs = lorgs.Where(q => q.u.SectorId == sectorId).ToList();
                if (subSectorId > 0 && subSectorId != 1001)
                    lorgs = lorgs.Where(q => q.u.SubSectorId == subSectorId).ToList();

                uids = lorgs.Select(q => q.u.Id).ToList();
            }

            var otherOrg = new List<ScoreCalc>();
            var scores = new ScoreCalc();
            foreach (var id in uids)
            {
                scores = CalculateScore(id, false, level, assementId);
                otherOrg.Add(scores);
            }

            var groups = new List<string>();
            otherOrg[0].Scores.ForEach(t => 
            {
                groups.Add(t.GroupName);
            });

            var graph = new Graph();
            graph.OtherOrg = new int[scores.Scores.Count];
            graph.Org = new int[scores.Scores.Count];
            graph.Groups = new string[scores.Scores.Count];
            int i = 0;
            foreach (var grp in groups)
            {
                try
                {
                    var other = otherOrg.Select(t => t.Scores.Where(v => v.GroupName == grp)).ToList();
                    if (other != null && other.Count > 0)
                    {
                        var oth = other.FirstOrDefault().FirstOrDefault();
                        if (oth != null)
                        {
                            var avg = other.Select(q => q.Average(t => t.MyScore)).FirstOrDefault();
                            graph.OtherOrg[i] = Convert.ToInt16(avg);
                            graph.Groups[i] = grp;
                            i = i + 1;
                        }
                        
                    }
                }
                catch (Exception ex)
                {

                    throw;
                }
            }
            return graph;

        }

        public static Graph SectorOrganizationFinalScore(int sectorId, int subSectorId, string level, int assementId)
        {
            var uInfo = new Repository<Organization>();
            var uids = new List<int>();
            var lorgs = uInfo.AssessmentContext.UserInfo.Join(uInfo.AssessmentContext.assessments, u => u.SectorId, a => a.Sector, (u, a) => new { u, a }).ToList();
            if (lorgs.Count == 0)
            {
                uids = uInfo.AssessmentContext.UserInfo.Select(q => q.Id).ToList();
            }
            else
            {
                if (sectorId > 0 && sectorId != 1001)
                    lorgs = lorgs.Where(q => q.u.SectorId == sectorId).ToList();
                if (subSectorId > 0 && subSectorId != 1001)
                    lorgs = lorgs.Where(q => q.u.SubSectorId == subSectorId).ToList();

                uids = lorgs.Select(q => q.u.Id).ToList();
            }

            var otherOrg = new List<ScoreCalc>();
            foreach (var id in uids)
            {
                var scores = CalculateScore(id, true, level,assementId);
                otherOrg.Add(scores);
            }

            var graph = new Graph();
            graph.OtherOrg = new int[1];
            graph.Org = new int[1];
            graph.OtherOrg[0] = otherOrg.Select(t => t.Scores.Sum(v => v.MyScore)).FirstOrDefault();
            return graph;

        }

    }
}