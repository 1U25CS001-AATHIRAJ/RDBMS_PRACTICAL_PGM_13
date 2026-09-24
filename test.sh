#!/bin/bash

echo "=========================================="
echo "     STUDENT TABLE 3NF AUTOGRADING"
echo "=========================================="

# Find answers.sql
ANSWER_FILE=$(find . -type f -name "answers.sql" | head -n 1)

if [ -z "$ANSWER_FILE" ]; then
    echo "FAIL: answers.sql not found."
    exit 1
fi

echo "PASS: answers.sql found."
echo "File: $ANSWER_FILE"

# Convert answer file to uppercase
CONTENT=$(tr '[:lower:]' '[:upper:]' < "$ANSWER_FILE")

# Check STUDENT table
if echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+STUDENT"; then
    echo "PASS: STUDENT table found."
else
    echo "FAIL: STUDENT table not found."
    exit 1
fi

# Check COURSE table
if echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+COURSE"; then
    echo "PASS: COURSE table found."
else
    echo "FAIL: COURSE table not found."
    exit 1
fi

# Check FACULTY table
if echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+FACULTY"; then
    echo "PASS: FACULTY table found."
else
    echo "FAIL: FACULTY table not found."
    exit 1
fi

# Check DEPARTMENT table
if echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+DEPARTMENT"; then
    echo "PASS: DEPARTMENT table found."
else
    echo "FAIL: DEPARTMENT table not found."
    exit 1
fi

# Check StudentID
if echo "$CONTENT" | grep -q "STUDENTID"; then
    echo "PASS: StudentID found."
else
    echo "FAIL: StudentID not found."
    exit 1
fi

# Check StudentName
if echo "$CONTENT" | grep -q "STUDENTNAME"; then
    echo "PASS: StudentName found."
else
    echo "FAIL: StudentName not found."
    exit 1
fi

# Check CourseID
if echo "$CONTENT" | grep -q "COURSEID"; then
    echo "PASS: CourseID found."
else
    echo "FAIL: CourseID not found."
    exit 1
fi

# Check CourseName
if echo "$CONTENT" | grep -q "COURSENAME"; then
    echo "PASS: CourseName found."
else
    echo "FAIL: CourseName not found."
    exit 1
fi

# Check FacultyID
if echo "$CONTENT" | grep -q "FACULTYID"; then
    echo "PASS: FacultyID found."
else
    echo "FAIL: FacultyID not found."
    exit 1
fi

# Check FacultyName
if echo "$CONTENT" | grep -q "FACULTYNAME"; then
    echo "PASS: FacultyName found."
else
    echo "FAIL: FacultyName not found."
    exit 1
fi

# Check DepartmentID
if echo "$CONTENT" | grep -q "DEPARTMENTID"; then
    echo "PASS: DepartmentID found."
else
    echo "FAIL: DepartmentID not found."
    exit 1
fi

# Check DepartmentName
if echo "$CONTENT" | grep -q "DEPARTMENTNAME"; then
    echo "PASS: DepartmentName found."
else
    echo "FAIL: DepartmentName not found."
    exit 1
fi

# Check Primary Keys
PK_COUNT=$(echo "$CONTENT" | grep -Eic "PRIMARY[[:space:]]+KEY")

if [ "$PK_COUNT" -ge 4 ]; then
    echo "PASS: At least 4 primary keys found."
else
    echo "FAIL: At least 4 primary keys are required."
    exit 1
fi

# Check Foreign Keys
FK_COUNT=$(echo "$CONTENT" | grep -Eic "FOREIGN[[:space:]]+KEY")

if [ "$FK_COUNT" -ge 3 ]; then
    echo "PASS: At least 3 foreign keys found."
else
    echo "FAIL: At least 3 foreign keys are required."
    exit 1
fi

# Check that original denormalized columns are not all in STUDENT
if echo "$CONTENT" | grep -Eq \
"CREATE[[:space:]]+TABLE[[:space:]]+STUDENT.*COURSENAME.*FACULTYNAME.*DEPARTMENTNAME"
then
    echo "FAIL: Original denormalized structure detected."
    exit 1
fi

echo "PASS: No original denormalized structure detected."

echo "=========================================="
echo "       ALL 3NF CHECKS PASSED"
echo "=========================================="

exit 0
