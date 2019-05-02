﻿using SelfAssessment.ExceptionHandler;
using SelfAssessment.Models;
using SelfAssessment.Validation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace SelfAssessment.Business
{
    public class RegistrationSendMail
    {
        public static void SendMail(string body,string subject, string to)
        {
            try
            {
                var apiKey = "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";//System.Environment.GetEnvironmentVariable("SENDGRID_APIKEY");
                var client = new SendGridClient(apiKey);
                var msg = new SendGridMessage()
                {
                    From = new EmailAddress("lakshmikanth1187@gmail.com", "LakshmiKanth"),
                    Subject = subject,
                    PlainTextContent = body,
                };
                msg.AddTo(new EmailAddress(to, "User"));
                var response = client.SendEmailAsync(msg).Result;
                UserException.LogInformation(response.StatusCode.ToString());
            }
            catch (Exception ex)
            {
                UserException.LogException(ex);
            }
        }
        //public void Send(MailConfiguration mail)
        //{
        //    MailMessage objeto_mail = new MailMessage();
        //    SmtpClient client = new SmtpClient();
        //    client.Port = mail.Port;
        //    client.Host = mail.Host;
        //    client.Timeout = 10000;
        //    client.DeliveryMethod = SmtpDeliveryMethod.Network;
        //    client.UseDefaultCredentials = false;
        //    client.Credentials = new System.Net.NetworkCredential(mail.NetworkUserName, mail.NetworkPassword);
        //    objeto_mail.From = new MailAddress(mail.FromId);
        //    objeto_mail.To.Add(new MailAddress(mail.ToId));
        //    objeto_mail.Subject = "Password Recover";
        //    objeto_mail.Body = "Message";
        //    client.Send(objeto_mail);
        //}

        //public static void SendMail(string body,string subject, string to)
        //{
        //    string senderID = "shenbakumar24@gmail.com";
        //    string senderPassword = "w7v/cyTCJuIRs6H+RUsPO/zpLl8/ANm9mI1Z8R2MYLI=";
        //    string hostName = "smtp.gmail.com";

        //    try
        //    {
        //        MailMessage mail = new MailMessage();
        //        mail.To.Add(to);
        //        mail.From = new MailAddress(senderID);
        //        mail.Subject = subject;
        //        mail.Body = body;
        //        mail.IsBodyHtml = true;
        //        SmtpClient smtp = new SmtpClient();
        //        smtp.Host = hostName;
        //        smtp.Credentials = new System.Net.NetworkCredential(senderID, StringCipher.Decrypt(senderPassword));
        //        smtp.Port = 587;
        //        smtp.EnableSsl = true;
        //        smtp.Send(mail);
        //    }
        //    catch (Exception ex)
        //    {
        //        UserException.LogException(ex);
        //    }

        //}
    }
}