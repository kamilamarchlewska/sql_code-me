/*---------------------------------------------------------------------------
 * SQL Day_2
 * Author:  Kamila Marchlewska
 *---------------------------------------------------------------------------
*/

/*---------------------------------------------------------------------------
 * 1. Enter the number of managers. 
*/

SELECT 
    COUNT(DISTINCT MANAGER_ID) AS NUMBER_OF_MANAGERS
FROM 
    EMPLOYEES;



/*---------------------------------------------------------------------------
 * 2. Prepare 3 statements from the Jobs table, which will present:
   (a) the minimum minimum wage 
   (b) the highest minimum wage 
   (c) the difference between the lowest and highest maximum wages
*/

SELECT 
    MIN(MIN_SALARY) AS MIN_SALARY, 
    MAX(MAX_SALARY) AS MAX_SALARY,
    MAX(MAX_SALARY) - MIN(MIN_SALARY) AS DEFFERENCE_SALARY
FROM 
    JOBS;



/*---------------------------------------------------------------------------
 * 3. Prepare a report with information on the average seniority in individual 
   departments, counted in years rounded up. 
   The report is sorted by descending order, starting with the departments 
   with the longest seniority employees.
*/

SELECT 
    CEIL(AVG((SYSDATE - HIRE_DATE)/365)) AS SENIORITY, 
    DEPARTMENT_ID
FROM 
    EMPLOYEES
GROUP BY 
    DEPARTMENT_ID
ORDER BY 
    SENIORITY DESC;



/*---------------------------------------------------------------------------
 * 4. Prepare a summary based on the Locations table, including the country ID 
   and the number of cities in that country.
*/

SELECT 
    COUNTRY_ID,
    COUNT(CITY) AS NUMBER_OF_CITIES
FROM 
    LOCATIONS
GROUP BY
    COUNTRY_ID;



/*---------------------------------------------------------------------------
 * 5. Prepare a comparison with average earnings in departments where employees 
   do not work on commission.
*/

SELECT 
    FLOOR(AVG(SALARY)) AS AVG_SALARY,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
WHERE 
    COMMISSION_PCT IS NULL
GROUP BY 
    DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 6. Display employees whose phone number ends in 34.
*/

SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    PHONE_NUMBER
FROM 
    EMPLOYEES
WHERE
    PHONE_NUMBER LIKE '%34';



/*---------------------------------------------------------------------------
 * 7. (COUNTRIES) Display the data where the region number = 2 
   and the country name contains the letter 'n'. 
*/

SELECT 
    *
FROM
    COUNTRIES
WHERE 
    REGION_ID = 2
AND
    COUNTRY_NAME LIKE '%n%';



/*---------------------------------------------------------------------------
 * 8. From the department table, display those that do not have a manager 
   or the department ID is between 40-60.
*/

SELECT 
    *
FROM
    DEPARTMENTS
WHERE
    MANAGER_ID IS NULL
OR
    DEPARTMENT_ID BETWEEN 40 AND 60;



/*---------------------------------------------------------------------------
 * 9. Display the number of employees in the departments for specific positions.
*/

SELECT 
    COUNT(*) AS EMP_NUM,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
GROUP BY
    DEPARTMENT_ID;
    


/*---------------------------------------------------------------------------
 * 10. Display how many employees there are within each job_id.
*/

SELECT 
    COUNT(*) AS EMP_NUM, 
    JOB_ID
FROM 
    EMPLOYEES
GROUP BY 
    JOB_ID;



/*---------------------------------------------------------------------------
 * 11. Using the JOBS table, display the job name and the difference between the 
   minimum and max earnings for that position.
   Result for positions with maximum salary in the range from 10000 to 20000.
*/

SELECT 
    JOB_TITLE,
    MAX_SALARY - MIN_SALARY AS DEFFERENCE_SALARY
FROM 
    JOBS
WHERE MAX_SALARY BETWEEN 10000 AND 20000;



/*---------------------------------------------------------------------------
 * 12. Display name, surname, position and salary for all employees who are
   salespeople ( job_id starts with SA ) and whose salary is not equal 
   to 2500, 3500 or 7 000.
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    JOB_ID,
    SALARY
FROM 
    EMPLOYEES
WHERE
    JOB_ID LIKE 'SA%'
AND
    SALARY NOT IN (2500, 3500, 7000);
