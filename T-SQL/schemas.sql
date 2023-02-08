
-- creating schemas

/*  
    Creating schemas which are
    authorized by the school Director
*/

GO  
    CREATE SCHEMA Shumabo AUTHORIZATION Director;
GO


/*  
    Creating schemas which are
    authorized by Unit_leader
*/
-- Authorizing Assignments

    CREATE SCHEMA Assignment AUTHORIZATION Unit_leader;
 GO


/*  
    Creating schemas which are
    authorized by the System_Admin
*/

-- Operations 
-- authorizing Triggers
 GO
    CREATE SCHEMA Triggers AUTHORIZATION System_Admin;
 GO

-- authorizing views
 GO
    CREATE SCHEMA views AUTHORIZATION System_Admin;
 GO

-- Authorizing 

/*  
    Creating schemas which are
    authorized by the Registrar
*/

-- Authorizing Students' data

    CREATE SCHEMA Stud_data AUTHORIZATION Registrar
 GO

-- Authorizing staffs' data
    
    CREATE SCHEMA Staff_data AUTHORIZATION Registrar
 GO

-- Authorizing papers for students

    CREATE SCHEMA Paper AUTHORIZATION Registrar
 GO

/*  
    Creating schemas which are
    authorized by Teachers
*/

-- authorizing grade result process
 GO
    CREATE SCHEMA Result AUTHORIZATION Teacher;
 GO

-- authorizing generating ou Class_schedule

    CREATE SCHEMA Schedule AUTHORIZATION Teacher;
 GO

/*  
    Creating schemas which are
    authorized by Resource_officer
*/

-- authorizing processing on Items

 GO
    CREATE SCHEMA Resource AUTHORIZATION Resource_officer;
 GO

 /*  
    Creating schemas which are
    Publicaly authorized
*/

 -- most of the displaying functionalities.
