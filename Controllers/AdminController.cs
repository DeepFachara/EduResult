using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using StudentResultManagement.Models;

namespace StudentResultManagement.Controllers
{
    public class AdminController : Controller
    {
        public ActionResult Login()
        {
            if (Session["AdminID"] != null)
            {
                return RedirectToAction("Dashboard");
            }

            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // Admin login
            if (model.Username == "admin" &&
                model.Password == "admin123")
            {
                Session["AdminID"] = 1;
                Session["AdminUsername"] = "admin";

                return RedirectToAction("Dashboard");
            }

            ViewBag.Error = "Invalid username or password.";

            return View(model);
        }

        public ActionResult Dashboard()
        {
            if (Session["AdminID"] == null)
            {
                return RedirectToAction("Login");
            }

            var viewModel = new AdminDashboardViewModel();

            try
            {
                var students = DatabaseHelper.GetAllStudents() ?? new List<Student>();
                var subjects = DatabaseHelper.GetAllSubjects() ?? new List<Subject>();
                var results = DatabaseHelper.GetAllResults() ?? new List<Result>();

                viewModel.TotalStudents = students.Count;
                viewModel.TotalSubjects = subjects.Count;
                viewModel.TotalResults = results.Count;

                int passedCount = results.Count(r => r.Marks >= r.PassingMarks);
                int failedCount = results.Count - passedCount;

                viewModel.TotalPassed = passedCount;
                viewModel.TotalFailed = failedCount;
                viewModel.PassPercentage = results.Count > 0
                    ? Math.Round((double)passedCount / results.Count * 100, 1)
                    : 0;
                viewModel.AverageScore = results.Count > 0
                    ? Math.Round(results.Average(r => (double)r.Marks), 1)
                    : 0;

                // Result Publishing Status (default: published)
                viewModel.IsResultPublished = HttpContext.Application["ResultsPublished"] == null
                    || (bool)HttpContext.Application["ResultsPublished"];
            }
            catch (Exception ex)
            {
                ViewBag.DbWarning = "Database connection notice: " + ex.Message;
            }

            return View(viewModel);
        }

        [HttpPost]
        public ActionResult TogglePublishStatus()
        {
            if (Session["AdminID"] == null)
            {
                return RedirectToAction("Login");
            }

            bool current = HttpContext.Application["ResultsPublished"] == null
                || (bool)HttpContext.Application["ResultsPublished"];

            HttpContext.Application["ResultsPublished"] = !current;

            return RedirectToAction("Dashboard");
        }

        public ActionResult Logout()
        {
            Session.Clear();

            return RedirectToAction("Login");
        }
    }
}
