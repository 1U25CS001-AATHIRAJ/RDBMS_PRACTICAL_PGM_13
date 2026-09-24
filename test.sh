### test.sh

```bash
#!/bin/bash

set -u

echo "=========================================="
echo "     STUDENT TABLE 3NF AUTOGRADING"
echo "=========================================="

ANSWER_FILE=$(find . -type f -name "answers.sql" | head -n 1)

if [ -z "$ANSWER_FILE" ]; then
    echo "FAIL: answers.sql not found."
    exit 1
fi

echo "PASS: answers.sql found."
echo "File: $ANSWER_FILE"

CONTENT=$(tr '[:lower:]' '[:upper:]' < "$ANSWER_FILE")

# Check STUDENT table
if ! echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+STUDENT"; then
    echo "FAIL: STUDENT table not found."
    exit 1
fi
echo "PASS: STUDENT table found."

# Check COURSE table
if ! echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+COURSE"; then
    echo "FAIL: COURSE table not found."
    exit 1
fi
echo "PASS: COURSE table found."

# Check FACULTY table
if ! echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+FACULTY"; then
    echo "FAIL: FACULTY table not found."
    exit 1
fi
echo "PASS: FACULTY table found."

# Check DEPARTMENT table
if ! echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+DEPARTMENT"; then
    echo "FAIL: DEPARTMENT table not found."
    exit 1
fi
echo "PASS: DEPARTMENT table found."

# Check StudentID
if ! echo "$CONTENT" | grep -q "STUDENTID"; then
    echo "FAIL: StudentID not found."
    exit 1
fi
echo "PASS: StudentID found."

# Check StudentName
if ! echo "$CONTENT" | grep -q "STUDENTNAME"; then
    echo "FAIL: StudentName not found."
    exit 1
fi
echo "PASS: StudentName found."

# Check CourseID
if ! echo "$CONTENT" | grep -q "COURSEID"; then
    echo "FAIL: CourseID not found."
    exit 1
fi
echo "PASS: CourseID found."

# Check CourseName
if ! echo "$CONTENT" | grep -q "COURSENAME"; then
    echo "FAIL: CourseName not found."
    exit 1
fi
echo "PASS: CourseName found."

# Check FacultyID
if ! echo "$CONTENT" | grep -q "FACULTYID"; then
    echo "FAIL: FacultyID not found."
    exit 1
fi
echo "PASS: FacultyID found."

# Check FacultyName
if ! echo "$CONTENT" | grep -q "FACULTYNAME"; then
    echo "FAIL: FacultyName not found."
    exit 1
fi
echo "PASS: FacultyName found."

# Check DepartmentID
if ! echo "$CONTENT" | grep -q "DEPARTMENTID"; then
    echo "FAIL: DepartmentID not found."
    exit 1
fi
echo "PASS: DepartmentID found."

# Check DepartmentName
if ! echo "$CONTENT" | grep -q "DEPARTMENTNAME"; then
    echo "FAIL: DepartmentName not found."
    exit 1
fi
echo "PASS: DepartmentName found."

# Check primary key
PK_COUNT=$(echo "$CONTENT" | grep -Eic "PRIMARY[[:space:]]+KEY")

if [ "$PK_COUNT" -lt 4 ]; then
    echo "FAIL: At least 4 primary key definitions are expected."
    exit 1
fi

echo "PASS: Primary keys found."

# Check foreign keys
FK_COUNT=$(echo "$CONTENT" | grep -Eic "FOREIGN[[:space:]]+KEY")

if [ "$FK_COUNT" -lt 3 ]; then
    echo "FAIL: At least 3 foreign key definitions are expected."
    exit 1
fi

echo "PASS: Foreign keys found."

# Check that original denormalized table is not created
if echo "$CONTENT" | grep -Eq "CREATE[[:space:]]+TABLE[[:space:]]+STUDENT[[:space:]]*\([^)]*COURSENAME[^)]*FACULTYNAME[^)]*DEPARTMENTNAME"; then
    echo "FAIL: Original denormalized structure detected."
    exit 1
fi

echo "PASS: No original denormalized structure detected."

echo "=========================================="
echo "       ALL 3NF CHECKS PASSED"
echo "=========================================="

exit 0
```

---

### `.github/workflows/normalization_3nf.yml`

```yaml
name: Student Table 3NF Autograding

on:
  push:
  pull_request:
  workflow_dispatch:

jobs:
  autograding:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Show Repository Structure
        run: |
          echo "======================================"
          echo "REPOSITORY FILES"
          echo "======================================"
          find . -maxdepth 5 -type f | sort
          echo "======================================"

      - name: Find and Run Test
        run: |
          echo "Searching for test.sh..."

          TEST_FILE=$(find . -type f -name "test.sh" | head -n 1)

          if [ -z "$TEST_FILE" ]; then
            echo "ERROR: test.sh not found."
            exit 1
          fi

          echo "PASS: test.sh found at:"
          echo "$TEST_FILE"

          chmod +x "$TEST_FILE"

          TEST_DIR=$(dirname "$TEST_FILE")

          echo "Test directory:"
          echo "$TEST_DIR"

          cd "$TEST_DIR"

          echo "Running 3NF autograding..."
          ./test.sh
```
