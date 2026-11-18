# Faculty Evaluation & Project Viva Guide

This reference guide is designed for project defense, faculty presentations, and viva evaluation for the **Student Result Management System (EduResult)**.

---

## 1. Project Concept & Objectives

### What problem does this system solve?
Traditional manual result processing is error-prone, labor-intensive, and slow. **EduResult** automates mark recording, calculation of overall percentages and letter grades, detection of backlogs, and publication of student result slips with real-time access for students.

---

## 2. Architecture & Design Decisions

### Why ASP.NET MVC 5?
- **Separation of Concerns:**
  - **Models:** Encapsulate business logic and data structures (`Student`, `Result`, `Subject`, `AdminDashboardViewModel`).
  - **Views:** Render UI cleanly using Razor syntax (`.cshtml`) without mixing business queries.
  - **Controllers:** Handle HTTP requests, orchestrate validation, session management, and view redirection.

### Why Predefined (Static) Subjects?
- **Faculty Question:** *"Why are subjects not dynamic in the database?"*
  - **Clear Technical Justification:** In standard college semesters, curriculum subjects are fixed and regulated by the university syllabus per semester. By defining the 6 semester subjects as static models in C#, we:
    1. Eliminate unnecessary database joins and foreign key cascades for subject definitions.
    2. Prevent orphan mark records caused by accidental subject deletions.
    3. Dramatically simplify database indexing, query execution time, and maintenance.

### How does Pass vs. Fail calculation work?
- Passing criteria is fixed at **40 marks out of 100** per subject.
- An individual student is declared **PASSED** if and only if they score >= 40 marks across all registered subjects.
- If marks < 40 in one or more subjects, the student is marked as **FAILED** and their backlogs are calculated dynamically (`studentResults.Count(r => r.Marks < r.PassingMarks)`).

### Why use a pure HTML/CSS Progress Bar instead of third-party Chart.js?
- Eliminates external JavaScript library bloat and CDN dependencies.
- Zero client-side rendering latency and 100% reliable rendering across all browsers.
- Simple, transparent mathematical logic that is directly verifiable:
  $$\text{Pass Percentage} = \frac{\text{Passed Students}}{\text{Total Students Evaluated}} \times 100$$

---

## 3. Database Schema Overview

The database consists of 2 core relational tables:
1. **`Students`:** Stores student identification (`StudentID`, `EnrollmentNo`, `Name`, `Email`, `Department`, `Semester`, `Password`).
2. **`Results`:** Stores examination marks (`ResultID`, `StudentID`, `SubjectID`, `Marks`). Linked to `Students` with `ON DELETE CASCADE`.

---

## 4. Key Viva Questions & Answers

1. **How does authentication work?**
   - Admin authentication verifies credentials and stores `Session["AdminID"]`.
   - Student authentication verifies enrollment number and password via `DatabaseHelper.GetStudent()`, storing `Session["StudentID"]`.
   - Protected actions check session state before executing (`IsAdmin()` / `IsStudent()`).

2. **How does result publishing control work?**
   - Result publishing state is stored in `HttpContext.Application["ResultsPublished"]`.
   - Admin can toggle publishing on or off. When unpublished, students are notified that results are pending release, preventing premature grade exposure.

3. **What happens if a student is deleted?**
   - Cascading deletion (`ON DELETE CASCADE`) automatically removes associated marks in the `Results` table to maintain referential integrity.
