/*---------------------------------------------------------------------------
 * SQL Day_4
 * Author:  Kamila Marchlewska
 *---------------------------------------------------------------------------
*/


/*---------------------------------------------------------------------------
 * 1. View name, salary and department number for all employees who earn more 
   than the maximum salary in the department by id 50.
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
    SALARY > (SELECT MAX(SALARY) 
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID = 50);



/*---------------------------------------------------------------------------
 * 2. Find the ID of departments in which the manager has more than 3 subordinates 
   and then using subquery display the full names of these departments, 
   e.g. SALES, IT, etc. - only 1 column with the name of the department.
*/

SELECT DISTINCT 
    DEPARTMENT_ID, 
    DEPARTMENT_NAME 
FROM 
    DEPARTMENTS
WHERE 
    DEPARTMENT_ID IN 
    (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID IN 
    (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE EMPLOYEE_ID IN 
    (SELECT MNG.EMPLOYEE_ID AS MNG_NUMBER
        FROM EMPLOYEES EMP 
        JOIN EMPLOYEES MNG ON EMP.MANAGER_ID = MNG.EMPLOYEE_ID
        GROUP BY MNG.EMPLOYEE_ID
        HAVING COUNT(EMP.EMPLOYEE_ID) > 3)));



/*---------------------------------------------------------------------------
 * 3. Enter the department id and the lowest salary in the department only for 
   departments in which the minimum wage is greater than or equal 
   to the minimum wage in a department of id 80.
*/

SELECT 
    DEPARTMENT_ID, 
    SALARY AS MIN_SALARY
FROM 
    EMPLOYEES
WHERE 
    SALARY >= (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80)
ORDER BY 
    SALARY
FETCH FIRST 1 ROWS ONLY;



/*---------------------------------------------------------------------------
 * 5. Display the name, name, and department number for all employees 
   hired later than the employee with ID 101.
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
    HIRE_DATE < (SELECT HIRE_DATE 
                    FROM EMPLOYEES 
                    WHERE EMPLOYEE_ID = 101);



/*---------------------------------------------------------------------------
 * 6. Display the name, surname and department number for all employees 
   working in the sales department (table of EMPLOYEES and DEPARTMANETS).
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                        FROM DEPARTMENTS 
                        WHERE DEPARTMENT_NAME LIKE 'Sales');



/*---------------------------------------------------------------------------
 * 7. Display the department name and number for all departments
   located in Toronto (DEPARTMENTS table).
*/

SELECT 
    DEPARTMENT_ID,
    DEPARTMENT_NAME
FROM 
    DEPARTMENTS
WHERE
    LOCATION_ID = (SELECT LOCATION_ID 
                    FROM LOCATIONS 
                    WHERE CITY LIKE 'Toronto');



/*---------------------------------------------------------------------------
 * 8. Display the name, salary and department number for all employees, 
   whose salary is equal to at least one salary 
   in department number 20 (TABLE OF EMPLOYEES).
*/

SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
WHERE
    SALARY IN (SELECT SALARY 
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID=20);



/*---------------------------------------------------------------------------
 * 9. Display the name, surname,salary and department number for all employees,
   who earn less than the minimum wage in department 90 (EMPLOYEES TABLE).
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
WHERE
    SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID = 90);



/*---------------------------------------------------------------------------
 * 10. Display the name,surname, salary and department number for all employees,
   whose department is located in Seattle 
  (TABLE OF EMPLOYEES, DEPARTMENTS AND LOCATIONS).
*/

SELECT 
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.SALARY,
    EMP.DEPARTMENT_ID
FROM 
    EMPLOYEES EMP 
    LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
    LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
WHERE
    LOC.CITY LIKE 'Seattle';



/*---------------------------------------------------------------------------
 * 11. Display the name,surname, salary and department number for all employees,
   who earn less than the average salary in the company, 
   and also work in the same department as the employee whose name is 'Kevin'.
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
WHERE
    DEPARTMENT_ID = (SELECT DISTINCT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE FIRST_NAME LIKE 'Kevin');



/*---------------------------------------------------------------------------
 * 12. Change the employee's salary with an ID of 116 = 9000 
   if the current salary is less than 6000.
*/

UPDATE EMPLOYEES SET SALARY = 9000
WHERE 
    SALARY < 6000
AND 
    EMPLOYEE_ID = 116;



/*---------------------------------------------------------------------------
 * 13. Change employee ID 110 to 'IT_PROG' if the employee belongs 
   to department 10 and the current JOB ID does not start with 'IT'.
*/

UPDATE EMPLOYEES SET JOB_ID = 'IT_PROG'
WHERE 
    DEPARTMENT_ID = 10 
AND 
    JOB_ID NOT LIKE 'IT%';


