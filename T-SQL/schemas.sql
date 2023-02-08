USE Shumabo_secondary_school

-- creating schemas

/*  
    Creating schemas which are
    authorized by the school Director
*/

GO  
    CREATE SCHEMA Shumabo AUTHORIZATION Mesafint;
GO


/*  
    Creating schemas which are
    authorized by Unit_leader
*/
-- Authorizing Assignments

    CREATE SCHEMA Assignment AUTHORIZATION Abiy;
 GO

/*  
    Creating schemas which are
    authorized by the System_Admin
*/

-- Operations 
-- authorizing Triggers
 GO
    CREATE SCHEMA Triggers AUTHORIZATION Gsix;
 GO

-- authorizing views
 GO
    CREATE SCHEMA views AUTHORIZATION Gsix;
 GO

-- Authorizing 

/*  
    Creating schemas which are
    authorized by the Registrar
*/

-- Authorizing Students' data

    CREATE SCHEMA Stud_data AUTHORIZATION AlemGezi
 GO

-- Authorizing staffs' data
    
    CREATE SCHEMA Staff_data AUTHORIZATION AlemGezi
 GO

-- Authorizing papers for students

    CREATE SCHEMA Paper AUTHORIZATION Alemgezi
 GO

/*  
    Creating schemas which are
    authorized by Teachers
*/

-- authorizing grade result process
 GO
    CREATE SCHEMA Result AUTHORIZATION Mintesnot;
 GO

-- authorizing generating ou Class_schedule

    CREATE SCHEMA Schedule AUTHORIZATION Mintesnot;
 GO

/*  
    Creating schemas which are
    authorized by Resource_officer
*/

-- authorizing processing on Items

 GO
    CREATE SCHEMA Resource AUTHORIZATION Zemenay;
 GO

/* 
    Creating schema which
    contains the security statuses like logins, users, schemas,
*/
 --- Create a schema for logins, users, schemas, roles, and other security statuses

 GO
   CREATE SCHEMA Security_Info;
 GO
 
 /*  
    Creating schemas which are
    Publicaly authorized
*/

 -- most of the displaying functionalities.
