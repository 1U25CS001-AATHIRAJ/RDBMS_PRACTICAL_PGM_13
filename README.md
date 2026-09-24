# Student Table Normalization – 3NF

## Assignment Question

Consider a Student table with the following fields:

```text
StudentID
StudentName
CourseName
FacultyName
DepartmentName
```

Normalize the table up to **Third Normal Form (3NF)**.

## Objective

The student must:

1. Identify the attributes of the original table.
2. Convert the table to First Normal Form (1NF).
3. Convert the table to Second Normal Form (2NF).
4. Convert the table to Third Normal Form (3NF).
5. Remove partial and transitive dependencies.
6. Decompose the original table into appropriate relations.
7. Define primary keys and foreign keys.

## Expected 3NF Relations

A suitable decomposition is:

### STUDENT

```text
StudentID
StudentName
CourseID
DepartmentID
```

Primary Key:

```text
StudentID
```

Foreign Keys:

```text
CourseID → COURSE(CourseID)
DepartmentID → DEPARTMENT(DepartmentID)
```

### COURSE

```text
CourseID
CourseName
FacultyID
```

Primary Key:

```text
CourseID
```

Foreign Key:

```text
FacultyID → FACULTY(FacultyID)
```

### FACULTY

```text
FacultyID
FacultyName
```

Primary Key:

```text
FacultyID
```

### DEPARTMENT

```text
DepartmentID
DepartmentName
```

Primary Key:

```text
DepartmentID
```

## 3NF Dependency Structure

The normalized dependency structure is:

```text
StudentID → StudentName, CourseID, DepartmentID

CourseID → CourseName, FacultyID

FacultyID → FacultyName

DepartmentID → DepartmentName
```

## Requirements

The submitted `answers.sql` should contain SQL `CREATE TABLE` statements for the normalized relations.

The solution should include:

* Primary keys
* Foreign keys
* Appropriate data types
* Separate tables for Course, Faculty, and Department
* No unnecessary transitive dependencies

## Submission

Submit the completed solution in:

```text
answers.sql
```

GitHub Actions will automatically check the submitted solution.

## Important

Do not modify:

```text
test.sh
```

or:

```text
.github/workflows/normalization_3nf.yml
```
