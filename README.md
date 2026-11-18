# EduResult - Student Result Management System

A streamlined, modern web-based **Student Result Management System** built with **ASP.NET MVC 5**, **C#**, **ADO.NET**, and **Microsoft SQL Server**.

EduResult enables academic institutions to manage student records, enter semester examination marks, track batch academic performance with visual analytics, and publish student result marksheets securely.

---

## 🌟 Key Features

### 👨‍💼 Administrator Portal
- **Secure Authentication:** Dedicated admin login session (`admin` / `admin123`).
- **Real-time Analytics Dashboard:**
  - Total enrolled students, subject count, and active marks records.
  - **Pass vs. Fail Performance Progress Bar** (pure HTML/CSS, lightweight, zero dependencies).
  - Subject-by-subject passing rate breakdown.
- **Student Record Management:** Full CRUD (Create, Read, Update, Delete) for student profiles and enrollment records.
- **Marks & Result Entry:** Add, edit, and review subject-wise marks with real-time validation.
- **Result Publishing Toggle:** Publish or unpublish semester results with a single click.

### 🎓 Student Portal
- **Enrollment Authentication:** Students login using their unique **Enrollment Number** and **Password**.
- **Student Dashboard:** Overview of academic standing, cumulative marks, percentage, and letter grade.
- **Marksheet & Result Slip:** Clean, formatted digital marksheet displaying subject names, marks obtained, maximum marks, passing status, and backlogs (if any).
- **Print / PDF Friendly:** Built-in clean print styles for instant marksheet generation.

---

## 📚 Curriculum Structure (Predefined Subjects)

To maintain a clean and reliable academic architecture, semester subjects are predefined in the core engine:
1. **.NET Technologies** (Max: 100, Passing: 40)
2. **Operating Systems & Technology (OST)** (Max: 100, Passing: 40)
3. **Data Science Engineering (DSE)** (Max: 100, Passing: 40)
4. **Database Management Systems (DBMS)** (Max: 100, Passing: 40)
5. **Data Structures** (Max: 100, Passing: 40)
6. **Artificial Intelligence** (Max: 100, Passing: 40)

---

## 🛠️ Technology Stack

- **Framework:** ASP.NET MVC 5 (.NET Framework 4.8)
- **Language:** C#
- **Database:** Microsoft SQL Server (LocalDB / Express)
- **Data Access:** ADO.NET (`SqlConnection`, `SqlCommand`, `SqlDataReader`)
- **Frontend / Styling:** Custom CSS3 Design System (`Site.css`), Responsive Flexbox/Grid, SVG Icons

---

## 🚀 Getting Started

### 1. Database Setup
1. Open **SQL Server Management Studio (SSMS)** or Visual Studio SQL Server Object Explorer.
2. Execute the setup script located at:
   ```sql
   Database/schema.sql
   ```
   This creates the `StudentResultDB` database, tables (`Students`, `Results`), and seeds initial sample records.

### 2. Configure Connection String
Verify `Web.config` connection string matches your local SQL Server instance:
```xml
<connectionStrings>
    <add name="StudentResultDB" 
         connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=StudentResultDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

### 3. Build & Run
1. Open `StudentResultManagement.sln` in **Visual Studio 2019 / 2022**.
2. Restore NuGet packages (`Update-Package` or right-click Solution > Restore NuGet Packages).
3. Press `F5` or `Ctrl + F5` to run the application in IIS Express.

---

## 👥 Project Team

- **Deep Fachara** ([@deepfachara](https://github.com/deepfachara))
- **Maharshi Vachhani** ([@maharshi1275](https://github.com/maharshi1275))
- **Mahipalsinh** ([@mahipal1411-arch!](https://github.com/mahipal1411-arch!))

---
*Developed for Academic Semester Project Evaluation.*
