﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SelfAssessment.Controllers
{
    public class BaseController : Controller
    {
        private int userId;
        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            if (Session["UserId"] == null || string.IsNullOrEmpty(Session["UserId"].ToString()))
                Response.Redirect("~/User/Login");
            userId = Convert.ToInt16(Session["UserId"].ToString());
        }

        public int UserId => userId;

    }
}