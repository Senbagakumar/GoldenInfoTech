﻿using SelfAssessment.Business;
using SelfAssessment.DataAccess;
using SelfAssessment.Models;
using SelfAssessment.Models.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace SelfAssessment.Controllers
{
    public class UserController : Controller
    {
        private readonly IBusinessContract businessContract;


        public UserController(IBusinessContract businessContract)
        {
            this.businessContract = businessContract;
        }

        // GET: User
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string email, string password)
        {
            int UserId = 0;
            UserId = this.businessContract.LoginVerfication(email, password);
            if(UserId !=0)
            {
                Session["UserId"] = UserId;
                Session["UserName"] = email;
                return Redirect("/ManageUser/Index");
                //return RedirectToAction("Index", "ManageUser");               
            }
            else
                return View();
        }

        [HttpGet]
        public JsonResult GetSubSector(int id)
        {
            var subSector = new List<SelectListItem>();
            //var firstItem = new SelectListItem() { Text = "-- Select --", Value = "0", Selected = true };            
           
            using (var repository = new Repository<SubSector>())
            {
                subSector = repository.Filter(q=> q.SectorId == id).Select(q => new SelectListItem() { Value = q.Id.ToString(), Text = q.SubSectorName }).ToList();
            }
            //subSector.Insert(0, firstItem);
            return Json(subSector,JsonRequestBehavior.AllowGet);
        }
        public ActionResult Register()
        {
         
            var type = new List<SelectListItem>();         

            var firstItem = new SelectListItem() { Text = "-- Select --", Value = "0", Selected = true };
            type.Add(firstItem);

            type.Add(new SelectListItem() { Text = "Small", Value = "1" });
            type.Add(new SelectListItem() { Text = "Large", Value = "2" });
            type.Add(new SelectListItem() { Text = "Operating Unit", Value = "3" });

           
            var sector = new List<SelectListItem>();
            var states = new List<SelectListItem>();
            var cities = new List<SelectListItem>();
            var typeOfService = new List<SelectListItem>();
            var revenue = new List<SelectListItem>();

            using (var repository = new Repository<Sector>())
            {
                sector = repository.All().Select(q => new SelectListItem() { Value = q.Id.ToString(), Text = q.SectorName }).ToList();
            }

            using (var repository = new Repository<State>())
            {
                states = repository.All().Select(q => new SelectListItem() { Value = q.Id.ToString(), Text = q.StateName }).ToList();
            }

            using (var repository = new Repository<Revenue>())
            {
                revenue = repository.All().Select(q => new SelectListItem() { Value = q.Id.ToString(), Text = q.Name }).ToList();
            }

            using (var repository = new Repository<ServiceType>())
            {
                typeOfService = repository.All().Select(q=> new SelectListItem() { Value = q.Id.ToString(), Text = q.Name }).ToList();
            }

            using (var repository = new Repository<City>())
            {
                cities = repository.All().Select(q => new SelectListItem() { Value = q.Id.ToString(), Text = q.CityName }).ToList();
            }

            var lastItem = new SelectListItem() { Text = "OTHERS", Value = "1000" };

            sector.Insert(0, firstItem);           
            revenue.Insert(0, firstItem);
            typeOfService.Insert(0, firstItem);
            cities.Insert(0, firstItem);
            states.Insert(0, firstItem);

            sector.Add(lastItem);
            ViewBag.SubSectorList = new List<SelectListItem>();
            ViewBag.SectorList = sector;            
            ViewBag.City = cities;
            ViewBag.State = states;
            ViewBag.Revenue = revenue;
            ViewBag.TypeOfService = typeOfService;
            ViewBag.Type = type;
            return View();
        }

        public ActionResult ForGetPassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ForGetPassword(string email)
        {
            this.businessContract.ForGetPassword(email);
            return View();
        }

        public ActionResult Success()
        {
            return View();
        }

        // POST: User/Create
        [HttpPost]
        public JsonResult CreateOrganization(UIOrganization organization)
        {
            try
            {

                this.businessContract.UserCreation(organization);
                

                // TODO: Add insert logic here

                //return RedirectToAction("Success");
            }
            catch
            {
                //return View();
            }
           return Json("Success", JsonRequestBehavior.AllowGet);
        }
      
    }
}
