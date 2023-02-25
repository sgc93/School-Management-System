USE Shumabo_secondary_school

-- Giving the security_Admin user to the 'securityadmin' role

    EXEC sp_addsrvrolemember 'Security_Admin', 'securityadmin'

-- Giving the 'db_securityadmin' role to the Security_Admin user | Begood
    
    EXEC sp_addrolemember 'db_securityadmin', 'Begood' 






















-- creating user defined role

-- 1. Create a user-defined role

    CREATE ROLE Security_Controller;

-- 3. Grant permissions for the created role on the above shcema

    GRANT SELECT, INSERT, UPDATE, DELETE , VIEW DEFINITION
    ON SCHEMA :: Security_Info 
    TO Security_Controller

-- 4. Assign the Security_Controller role to user Begood whose login is 'Security_Admin'

    EXEC sp_addrolemember 'Security_Controller', 'Begood';
    EXEC sp_droprolemember 'Security_Controller', 'Begood';
-- 5. Execute the created user defined role || Security_controller

    EXECUTE AS ROLE = 'Security_Controller';



-- Perform any necessary operations as the Security_Admin role
SELECT * FROM Security_Info.logins;

