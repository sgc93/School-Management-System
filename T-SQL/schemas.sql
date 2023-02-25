USE Shumabo_secondary_school

-- creating schemas

/*  
    Creating schemas which are
    authorized by the school Director
    */
    GO
    CREATE SCHEMA Shumabo AUTHORIZATION Mesafint;

/*  
    Creating schemas which are
    authorized by Unit_leader
    */
    GO
    CREATE SCHEMA Assignment AUTHORIZATION Abiy;

/*  
    Creating schemas which are
    authorized by the System_Admin
    */
    GO
    CREATE SCHEMA Control AUTHORIZATION Gsix;

  -- Operations 
    -- authorizing Triggers
    GO
    CREATE SCHEMA Triggr AUTHORIZATION Gsix;

    -- authorizing views
    GO
    CREATE SCHEMA Indx AUTHORIZATION Gsix;

    -- authorizing backup tables
    GO
    CREATE SCHEMA backp AUTHORIZATION Gsix;
    
/*  
    Creating schemas which are
    authorized by the Registrar
    */

    -- Authorizing Students' data
    GO
    CREATE SCHEMA Stud_data AUTHORIZATION AlemGezi;
    
    -- Authorizing Teachers' data
    GO
    CREATE SCHEMA Teacher_data AUTHORIZATION AlemGezi
    
    -- Authorizing staffs' data
    GO    
    CREATE SCHEMA Staff_data AUTHORIZATION AlemGezi

    -- Authorizing papers (transcript, transfer_form, ...) for students
    GO
    CREATE SCHEMA Paper AUTHORIZATION Alemgezi
 
/*  
    Creating schemas which are
    authorized by Teachers
    */

    -- authorizing grade result process
    GO
    CREATE SCHEMA Result AUTHORIZATION Teacher;

/*  
    Creating schemas which are
    authorized by Resource_officer
*/

-- authorizing processing on Items

    GO
    CREATE SCHEMA Resource AUTHORIZATION Zemenay;
