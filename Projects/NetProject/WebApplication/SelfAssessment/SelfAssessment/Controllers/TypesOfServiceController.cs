﻿using SelfAssessment.Business;
using SelfAssessment.DataAccess;
using SelfAssessment.Models.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfAssessment.Controllers
{
    public class TypesOfServiceController : Controller
    {
        // GET: TypesOfService
        public ActionResult Index()
        {
            var lmodel = new List<ServiceType>();

            using (var repository = new Repository<ServiceType>())
            {
                lmodel = repository.All().ToList();
            }
            return View(lmodel);
        }

        // POST: TypesOfService/Create
        [HttpPost]
        public JsonResult Create(ServiceType serviceType)
        {
            try
            {
                using (var repository = new Repository<ServiceType>())
                {
                    if (serviceType.Id != 0)
                    {
                        var updateServiceType = repository.Filter(q => q.Id == serviceType.Id).FirstOrDefault();
                        if (updateServiceType != null && !string.IsNullOrEmpty(updateServiceType.Name))
                        {
                            updateServiceType.Name = serviceType.Name;
                            updateServiceType.UpdateDate = DateTime.Now;
                            repository.Update(updateServiceType);
                        }
                    }
                    else
                    {
                        repository.Create(new ServiceType() { Name = serviceType.Name, CreateDate = DateTime.Now });
                    }
                    repository.SaveChanges();
                }

                // TODO: Add insert logic here

                // return RedirectToAction("Index");
            }
            catch
            {
                return Json(Utilities.Failiure, JsonRequestBehavior.AllowGet);
            }
            return Json(Utilities.Success, JsonRequestBehavior.AllowGet);
        }
        // GET: TypesOfService/Delete/5
        public JsonResult Delete(int id)
        {
            using (var repository = new Repository<ServiceType>())
            {
                var deleteServiceType = repository.Filter(q => q.Id == id).FirstOrDefault();
                if (deleteServiceType != null && !string.IsNullOrEmpty(deleteServiceType.Name))
                {
                    repository.Delete(deleteServiceType);
                }
                repository.SaveChanges();
            }
            return Json(Utilities.Success, JsonRequestBehavior.AllowGet);
        }
    }
}
