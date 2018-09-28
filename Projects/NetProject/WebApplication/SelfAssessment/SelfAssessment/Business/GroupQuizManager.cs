﻿using SelfAssessment.DataAccess;
using SelfAssessment.Models;
using SelfAssessment.Models.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SelfAssessment.Business
{


    public class GroupQuiz
    {
        public string GroupText { get; set; }
        public List<QuestionAnswer> listOfQuestions { get; set; }
        public int UIGroupId { get; set; }
        public int GroupId { get; set; }
        public int NoOfQuestions { get; set; }
        public int NoOfGroups { get; set; }
        public int NoOfCompletedQuestions { get; set; }

    }

    interface IGroupSaveQuiz
    {
        void SaveAnswer(List<QuestionQuiz> answers);
        void CompleteQuiz();
        bool MoveToNextGroup(int groupId);
        int CalculateScore();
        //bool PreviosGroup(int groupId, int userid);
    }
    interface IGroupQuizManager : IGroupSaveQuiz
    {
        GroupQuiz LoadQuiz(int groupId);
        List<GroupQuiz> GetAllQuestions();

    }
    public class GroupQuizModel
    {
        public int QuizGroupId { get; set; }
        public virtual List<GroupQuiz> GroupQuestions { get; set; }
        public DateTime? StartTime { get; set; }
        public TimeSpan? Duration { get; set; }
        public DateTime? EndTime { get; set; }
        public int Score { get; set; }

    }
    public class GroupQuizManager : IGroupQuizManager
    {
        private readonly int UserId;
        public List<GroupQuiz> AllQuestions { get; set; }
        public GroupQuizManager(int userId)
        {
            UserId = userId;
        }

        public List<GroupQuiz> GetAllQuestions()
        {
            var listOfGroupQuestions = new List<GroupQuiz>();
            var uInfo = new Repository<Organization>();
            var details = uInfo.AssessmentContext.UserInfo.Join(uInfo.AssessmentContext.assessments, u => u.SectorId, a => a.Sector, (u, a) => new { u, a }).Where(q=> q.u.Id == UserId).FirstOrDefault();

            var questionIds = uInfo.AssessmentContext.assessmentLevelMappings.Where(q => q.AssessmentId == details.a.Id && q.Level == details.u.CurrentAssignmentType).Select(q => q.QuestionId).ToList();
            var lQuestions = uInfo.AssessmentContext.questions.Where(q => questionIds.Contains(q.Id)).GroupBy(q => q.GroupId).Select(q => new { Questions = q.ToList(), Type = q.Key }).OrderBy(t => t.Type).ToList();

            int i = 1;
            lQuestions.ForEach(t =>
            {
                var listOfGroupQuiz = new GroupQuiz();
                listOfGroupQuiz.UIGroupId = i;
                listOfGroupQuiz.GroupId = t.Type;
                listOfGroupQuiz.GroupText = uInfo.AssessmentContext.groups.Where(q => q.Id == t.Type).FirstOrDefault().Name;
                listOfGroupQuiz.listOfQuestions = new List<QuestionAnswer>();
                int k = 1;

                t.Questions.ForEach(v => {

                    var question = new QuestionAnswer();
                    question.Questions = new QuestionQuiz() { QuestionCode = "Q" + k, QuestionId = v.Id, QuestionText = v.QuestionText };

                    var answerChoice = new List<AnswerChoice>();

                    answerChoice.Add(new AnswerChoice() { AnswerChoiceId = 1, Choices = v.Option1 });
                    answerChoice.Add(new AnswerChoice() { AnswerChoiceId = 2, Choices = v.Option2 });
                    answerChoice.Add(new AnswerChoice() { AnswerChoiceId = 3, Choices = v.Option3 });
                    answerChoice.Add(new AnswerChoice() { AnswerChoiceId = 4, Choices = v.Option4 });
                    answerChoice.Add(new AnswerChoice() { AnswerChoiceId = 5, Choices = v.Option5 });

                    question.AnswerChoices = answerChoice;

                    listOfGroupQuiz.listOfQuestions.Add(question);
                    k++;
                });
                i++;
                listOfGroupQuestions.Add(listOfGroupQuiz);
            });
            return listOfGroupQuestions;
        }


        private List<GroupQuiz> AllGroupQuiz()
        {
            var uInfo = new Repository<Answer>();

            AllQuestions.ForEach(v =>
            {
                v.listOfQuestions.ForEach(q =>
                {
                    var isAnswer = uInfo.Filter(a => a.QuestionId ==q.Questions.QuestionId  && a.GroupId == v.GroupId && a.UserId == UserId).FirstOrDefault();
                    if (isAnswer != null)
                    {
                        var selectedChoice = q.AnswerChoices.Where(ans => ans.AnswerChoiceId == isAnswer.UserOptionId).FirstOrDefault();
                        selectedChoice.IsChecked = true;
                    }
                });
            });
            return AllQuestions;
          
        }

        public GroupQuiz LoadQuiz(int groupId)
        { 
            var allGroup = AllGroupQuiz();
            var currentGroup=allGroup.Where(q => q.UIGroupId == groupId).First();          
            return GetCountDetails(allGroup, currentGroup);
        }

        private GroupQuiz GetCountDetails(List<GroupQuiz> allGroupQuiz, GroupQuiz currentQuiz)
        {
            int answeredCount = 0;
            int noQuestions = 0;
            allGroupQuiz.ForEach(q => noQuestions+= q.listOfQuestions.Count());
            currentQuiz.NoOfQuestions = noQuestions;
            currentQuiz.NoOfGroups = allGroupQuiz.Count();
            allGroupQuiz.ForEach(v =>
            {
                v.listOfQuestions.ForEach(s =>
                {
                    if (s.AnswerChoices.Any(t => t.IsChecked))
                        answeredCount++;
                });

            });
            currentQuiz.NoOfCompletedQuestions = answeredCount;
            return currentQuiz;
        }

        public void SaveAnswer(List<QuestionQuiz> answers)//QueryWindowInMins
        {
            var ans = new Repository<Answer>();
            bool isSave = false;
            foreach(var questionQuiz in answers)
            {
                isSave = true;
                //SaveLogic

                var eAnswer = ans.Filter(q => q.UserId == UserId && q.QuestionId == questionQuiz.QuestionId && q.GroupId == questionQuiz.GroupId).FirstOrDefault();
                if (eAnswer == null)
                {
                    var aAnswer = new Answer() { GroupId = questionQuiz.GroupId, QuestionId = questionQuiz.QuestionId, UserId = UserId, UserOptionId = questionQuiz.UserOptionId };
                    ans.Create(aAnswer);
                }
                else
                {
                    eAnswer.UserOptionId = questionQuiz.UserOptionId;
                    ans.Update(eAnswer);
                }
                //quiz.Score += CalculateScore(questionQuiz.UserOptionId);
            }
            if(isSave)
                ans.SaveChanges();
        }

        public int CalculateScore()
        {
            int score = 0;
            var uInfo = new Repository<Organization>();
            AllQuestions.ForEach(v =>
            {
                v.listOfQuestions.ForEach(q =>
                {
                    var isAnswer = uInfo.AssessmentContext.answers.Where(a => a.QuestionId == q.Questions.QuestionId && a.GroupId == v.GroupId && a.UserId == UserId).FirstOrDefault();
                    if (isAnswer != null)
                    {
                        score += CalculateScoreByAns(isAnswer.UserOptionId);
                    }
                });
            });
            return score;
        }

        private int CalculateScoreByAns(int answerId)
        {
            int score = 0;
            switch (answerId)
            {
                case 1:
                    score = 5;
                    break;
                case 2:
                    score = 25;
                    break;
                case 3:
                    score = 50;
                    break;
                case 4:
                    score = 75;
                    break;
                case 5:
                    score = 95;
                    break;
                default:
                    score = 5;
                    break;

            }
            return score;
        }

        public bool MoveToNextGroup(int groupId)
        {
           return AllGroupQuiz().Count >= groupId ? true : false;  
        }

        public void CompleteQuiz()
        {
            var uInfo = new Repository<Organization>();
            var organization = uInfo.Filter(q => q.Id == UserId).FirstOrDefault();
            if (organization != null)
                organization.CurrentAssignmentStatus = "Completed";

            uInfo.Update(organization);
            uInfo.SaveChanges();
        }
    }
}