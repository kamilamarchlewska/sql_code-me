/*---------------------------------------------------------------------------
 * SQL Day_4
 * Author:  Kamila Marchlewska
 *---------------------------------------------------------------------------
*/


/*---------------------------------------------------------------------------
 * 1. Give raises of $105 to each employee earning the least in the department.
*/

UPDATE EMPLOYEES SET SALARY = SALARY + 105
WHERE EMPLOYEE_ID IN 
    (SELECT EMPLOYEE_ID FROM 
        (SELECT EMPLOYEE_ID, 
                RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) RNK
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID IS NOT NULL )
    WHERE RNK = 1);



/*---------------------------------------------------------------------------
 * 2. Provide details of the department (name, city, country, and region) 
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
WHERE 
    EMP.LAST_NAME LIKE 'Raphaely';



/*---------------------------------------------------------------------------
 * 3. From the department where a man named Sully works, display employees who 
   earn above average.
*/

SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM 
    EMPLOYEES
WHERE 
    SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);



/*---------------------------------------------------------------------------
 * 4. Prepare a view that contains complete information about the employee - 
   their department, position, and workplace location.
*/

CREATE VIEW EMP_INFO_LOCATION AS
    SELECT 
        EMP.EMPLOYEE_ID,
        EMP.FIRST_NAME,
        EMP.LAST_NAME,
        DEP.DEPARTMENT_ID,
        DEP.DEPARTMENT_NAME,
        JOBS.JOB_ID,
        JOBS.JOB_TITLE,
        LOC.LOCATION_ID,
        LOC.CITY,
        CNT.COUNTRY_ID,
        CNT.COUNTRY_NAME,
        REG.REGION_ID,
        REG.REGION_NAME
    FROM EMPLOYEES EMP
    LEFT JOIN JOBS ON EMP.JOB_ID = JOBS.JOB_ID
    LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
    LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
    LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
    LEFT JOIN REGIONS REG ON CNT.REGION_ID = REG.REGION_ID;
     


/*---------------------------------------------------------------------------
 * 5. Remove employees of the department ID 20.
*/

DELETE
FROM 
    EMPLOYEES
WHERE
    DEPARTMENT_ID = 20;



/*---------------------------------------------------------------------------
 * 6. Remove all employees working in departments located in Europe.
*/

DELETE
FROM 
    EMPLOYEES
WHERE
    DEPARTMENT_ID IN 
    (SELECT DEPARTMENT_ID 
        FROM DEPARTMENTS 
        WHERE LOCATION_ID IN 
        (SELECT LOCATION_ID 
            FROM LOCATIONS 
            WHERE COUNTRY_ID IN 
            (SELECT COUNTRY_ID 
                FROM COUNTRIES 
                WHERE REGION_ID = 
                (SELECT REGION_ID 
                    FROM REGIONS 
                    WHERE REGION_NAME LIKE 'Europe'))));



/*---------------------------------------------------------------------------
 * 7. Insert a row into the department table with a new department with ID 280, 
   named 'Sports' and manager ID 120 and location ID for the city of Tokyo.
*/

INSERT INTO DEPARTMENTS
    (DEPARTMENT_ID,
     DEPARTMENT_NAME,
     MANAGER_ID,
     LOCATION_ID)
VALUES
    (280,
     'Sports',
     120,
     (SELECT LOCATION_ID
      FROM LOCATIONS
      WHERE CITY = 'Tokyo'));



/*---------------------------------------------------------------------------
 * 8. Insert the new employee into the employee table with 
   all the required details.
*/

INSERT INTO EMPLOYEES
    (EMPLOYEE_ID,
     FIRST_NAME,
     LAST_NAME,
     EMAIL,
     PHONE_NUMBER,
     HIRE_DATE,
     JOB_ID,
     SALARY,
     MANAGER_ID,
     DEPARTMENT_ID)
VALUES
    (208,
     'Anna',
     'Dark',
     'ADARK',
     '515.123.8187',
     (TO_DATE('94/06/09', 'yy/mm/dd')),
     'AC_ACCOUNT',
     8500,
     205,
     100);



/*---------------------------------------------------------------------------
 * 9. Create a view of departments and the amounts SUM of salaries paid in them.
*/

CREATE VIEW SUM_SALARIES_DEP AS
    SELECT
        NVL(TO_CHAR(DEPARTMENT_ID), 'TOTAL SALARIES') AS ID_DEPARTMENTS,
        SUM(SALARY) AS SUM_SALARY
    FROM 
        EMPLOYEES
    WHERE 
        DEPARTMENT_ID IS NOT NULL
    GROUP BY 
        ROLLUP(DEPARTMENT_ID);



/*---------------------------------------------------------------------------
 * 10. Create views of the EMPLOYEES and DEPARTMENTS tables to display data 
   without personal information.
*/

CREATE VIEW EMP_DEP_INFO AS
    SELECT 
        EMP.EMPLOYEE_ID, 
        EMP.HIRE_DATE, 
        EMP.JOB_ID, 
        EMP.MANAGER_ID, 
        EMP.DEPARTMENT_ID, 
        DEP.DEPARTMENT_NAME, 
        DEP.LOCATION_ID
    FROM EMPLOYEES EMP 
    LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;


