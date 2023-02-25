
USE Shumabo_secondary_school

-- creating users for each login

-- 1. Creating a user for system_Admin login

    CREATE USER Gsix FOR LOGIN System_Admin;


-- 2. Creating a user for Director login

    CREATE USER Mesafint FOR LOGIN Director;


-- 3. Creating a user for Teacher login

    CREATE USER Mintesnot FOR LOGIN Teacher;

    CREATE USER Sewlesew FOR LOGIN Teacher;

    CREATE USER Gemenaye FOR LOGIN Teacher;

-- 4. Creating a user for Student login | for publicaly authorized functionalities

    -- Student 1 
    CREATE USER Bezabh FOR LOGIN Student


    -- student 2
    CREATE USER Seblewongel FOR LOGIN Student


-- 5. Creating a user for Parent login

    -- Parent 1

    CREATE USER  Bogale FOR LOGIN Parent

    -- Parent 2

    CREATE USER Meshesha FOR LOGIN Parent

-- 6. Creating a user for Staff login

    -- Staff 1
    CREATE USER Tiruaynet FOR LOGIN Staff

    -- Staff 2
    CREATE USER Wudnesh FOR LOGIN Staff


-- 7. Creating a user for Resource Officer login

    CREATE USER Zemenay FOR LOGIN Resource_officer

-- 8. Creating a user for Registrar login

    CREATE USER AlemGezi FOR LOGIN Registrar


-- 9. creating a user for Unit_leader login

    CREATE USER Abiy FOR LOGIN Unit_leader


-- 10. creating a user for the Security_Admin login

    CREATE USER Begood FOR LOGIN Security_admin
