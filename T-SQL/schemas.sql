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
