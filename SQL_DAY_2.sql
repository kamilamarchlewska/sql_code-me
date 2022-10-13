/*---------------------------------------------------------------------------
 * SQL Day_2
 * Author:  Kamila Marchlewska
 *---------------------------------------------------------------------------
*/


/*---------------------------------------------------------------------------
 * 1. Provide details of the department (name, city, country, and region) 
   managed by a manager named Raphaely.
*/

SELECT 
    DEP.DEPARTMENT_NAME,
    EMP.LAST_NAME,
    LOC.CITY,
    COUNTRY_NAME,
    REGION_NAME
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.MANAGER_ID = DEP.MANAGER_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
LEFT JOIN REGIONS REG ON CNT.REGION_ID = REG.REGION_ID
WHERE EMP.LAST_NAME LIKE 'Raphaely';
  


/*---------------------------------------------------------------------------
 * 2. Display the name of the country, city, and the number of departments 
   in which there are departments with more than 5 employees.
*/

SELECT 
    COUNTRY_NAME, 
    CITY, 
    COUNT(EMPLOYEE_ID) AS EMP_NUMBER
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
GROUP BY 
    COUNTRY_NAME, CITY
HAVING 
    COUNT(EMPLOYEE_ID) > 5;



/*---------------------------------------------------------------------------
 * 3. Find the city with the most departments.
*/

SELECT
    CITY,
    COUNT(DEPARTMENT_ID) AS MAX_NUM_DEP
FROM LOCATIONS LOC 
LEFT JOIN DEPARTMENTS DEP ON LOC.LOCATION_ID = DEP.LOCATION_ID
GROUP BY
    CITY
ORDER BY
    MAX_NUM_DEP DESC
FETCH FIRST 1 ROWS ONLY;




/*---------------------------------------------------------------------------
 * 4. Find employees who started work in front of their managers. 
   (hint - use the self join on the employees table).
*/

SELECT 
    EMP.EMPLOYEE_ID AS EMP_ID,
    EMP.FIRST_NAME AS EMP_NAME,
    EMP.LAST_NAME AS EMP_LAST_NAME,
    EMP.HIRE_DATE AS EMP_HIRE_DATE,
    MNG.HIRE_DATE AS MNG_HIRE_DATE,
    MNG.FIRST_NAME AS MNG_NAME,
    MNG.LAST_NAME AS MNG_LAST_NAME
    
FROM 
    EMPLOYEES EMP, 
    EMPLOYEES MNG
WHERE 
    EMP.MANAGER_ID = MNG.EMPLOYEE_ID
AND
    EMP.HIRE_DATE < MNG.HIRE_DATE;



/*---------------------------------------------------------------------------
 * 5. Display name, last name, salary and DEPARTMENT number for all employees 
   who earn less than the average salary in the company and also work in 
   the same DEPARTMENT as the employee whose name is Kevin.
*/

SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
WHERE 
    SALARY < (SELECT AVG(SALARY) 
                FROM EMPLOYEES)
AND
    DEPARTMENT_ID = (SELECT DISTINCT DEPARTMENT_ID 
                        FROM EMPLOYEES 
                        WHERE FIRST_NAME LIKE 'Kevin');



/*---------------------------------------------------------------------------
 * 6. Display how many employees there are within each JOB_ID. 
   Display only those JOB_ID where there are more than 5 employees.
*/

SELECT 
    JOB_ID,
    COUNT(EMPLOYEE_ID) AS EMP_NUMBER
FROM 
    EMPLOYEES
GROUP BY 
    JOB_ID
HAVING 
    COUNT(EMPLOYEE_ID) > 5;



/*---------------------------------------------------------------------------
 * 7. Display the department number and average salary for each department.
*/

SELECT 
    DEPARTMENT_ID,
    ROUND(AVG(SALARY)) AS AVG_SALARY
FROM 
    EMPLOYEES
WHERE 
    DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 8. Display the position and number of employees for each position.
*/

SELECT 
    JOB_ID,
    COUNT(EMPLOYEE_ID) AS EMP_NUMBER
FROM 
    EMPLOYEES
GROUP BY
    JOB_ID;



/*---------------------------------------------------------------------------
 * 9. View the department number and average salary for each department 
   whose ID is between 20 and 80.
*/

SELECT 
    DEP.DEPARTMENT_ID,
    FLOOR(AVG(EMP.SALARY)) AS AVG_SALARY
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
WHERE 
    DEP.DEPARTMENT_ID BETWEEN 20 AND 80
GROUP BY
    DEP.DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 10. Display the name, surname, name of the department each employee. 
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    NVL(DEPARTMENT_NAME, 'No Department') AS DEPARTMENT_NAME
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 11. Display department name and manager's name.
*/

SELECT 
    DEP.DEPARTMENT_NAME,
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS MGR_NAME
FROM DEPARTMENTS DEP
JOIN EMPLOYEES EMP ON DEP.MANAGER_ID = EMP.MANAGER_ID;



/*---------------------------------------------------------------------------
 * 12. Display job titles and average salaries for those positions.
*/

SELECT 
    JOB_TITLE,
    FLOOR(AVG(SALARY)) AS AVG_SALARY
FROM 
    JOBS, EMPLOYEES EMP
WHERE 
    JOBS.JOB_ID = EMP.JOB_ID
GROUP BY
    JOB_TITLE;



/*---------------------------------------------------------------------------
 * 13. Using inner join, find managers and their employees.
*/

SELECT 
    EMP.EMPLOYEE_ID AS EMP_ID,
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS EMP_NAME,
    MNG.FIRST_NAME || ' ' || MNG.LAST_NAME AS MNG_NAME
FROM 
    EMPLOYEES EMP, 
    EMPLOYEES MNG
WHERE 
    EMP.MANAGER_ID = MNG.EMPLOYEE_ID;



/*---------------------------------------------------------------------------
 * 14. Display the name of the country, city, and department.
*/

SELECT 
    COUNTRY_NAME,
    CITY,
    DEPARTMENT_NAME
FROM DEPARTMENTS DEP
FULL JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
FULL JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID;



/*---------------------------------------------------------------------------
 * 15. Display the name of the department and the number of employees
   working in IT department.
*/

SELECT 
    DEPARTMENT_NAME,
    COUNT(EMPLOYEE_ID) AS EMP_NUMBER
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
WHERE DEPARTMENT_NAME LIKE '%IT%' 
GROUP BY DEPARTMENT_NAME;



/*---------------------------------------------------------------------------
 * 16. Display the name, surname, position, salary, department, city, 
   country and region where the employee works.
*/

SELECT 
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.JOB_ID,
    EMP.SALARY,
    DEP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME,
    LOC.CITY,
    CNT.COUNTRY_NAME,
    REG.REGION_NAME
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.MANAGER_ID = DEP.MANAGER_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
LEFT JOIN REGIONS REG ON CNT.REGION_ID = REG.REGION_ID;



/*---------------------------------------------------------------------------
 * 17. Find departments and the number of people working in them.
*/

SELECT 
    DEP.DEPARTMENT_NAME,
    COUNT(EMP.EMPLOYEE_ID) AS EMP_NUMBER
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
GROUP BY 
    DEP.DEPARTMENT_NAME;



/*---------------------------------------------------------------------------
 * 18. Find all employees and all departments using FULL OUTER JOIN.
*/

SELECT 
    *
FROM EMPLOYEES EMP 
FULL JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 20. Display the department name and the number of employees in the department.
*/

SELECT 
    DEP.DEPARTMENT_NAME,
    COUNT(EMP.EMPLOYEE_ID) AS EMP_NUMBER
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
GROUP BY 
    DEP.DEPARTMENT_NAME;



/*---------------------------------------------------------------------------
 * 21. Display the number of employees in each region.
*/

SELECT 
    REG.REGION_NAME,
    COUNT(EMP.EMPLOYEE_ID) AS EMP_NUMBER
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
RIGHT JOIN REGIONS REG ON CNT.REGION_ID = REG.REGION_ID
GROUP BY
    REG.REGION_NAME;



/*---------------------------------------------------------------------------
 * 22. Display the minimum and maximum salaries and 
   the average salary of employees in the sales position.
*/

SELECT 
    JOB_ID,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY,
    AVG(SALARY) AS AVG_SALARY
FROM 
    EMPLOYEES
WHERE 
    JOB_ID LIKE 'SA%'
GROUP BY
    JOB_ID;



/*---------------------------------------------------------------------------
 * 23. Display the employee's name, current salaries, 
   and earnings after a 5 percent increase.
*/

SELECT 
    LAST_NAME,
    SALARY AS SALARY_CURRENT,
    SALARY*1.05 AS SALARY_INCREASE
FROM 
    EMPLOYEES;



/*---------------------------------------------------------------------------
 * 24. Display the unique job titles from the employee and jobs board. 
*/

SELECT 
    DISTINCT EMPLOYEES.JOB_ID,
    JOBS.JOB_TITLE
FROM 
    EMPLOYEES LEFT JOIN JOBS ON EMPLOYEES.JOB_ID = JOBS.JOB_ID;



/*---------------------------------------------------------------------------
 * 25. Display the names and IDs of department employees numbered 90 and 40. 
*/

SELECT
    LAST_NAME,
    EMPLOYEE_ID
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID IN (90, 40);


