USE Shumabo_secondary_school

-- Giving the security_Admin user to the 'securityadmin' role

    EXEC sp_addsrvrolemember 'Security_Admin', 'securityadmin'

-- Giving the 'db_securityadmin' role to the Security_Admin user | Begood
    
    EXEC sp_addrolemember 'db_securityadmin', 'Begood' 

-- Droping the role given to the Security_Admin
    EXEC sp_dropsrvrolemember 'Security_Admin', 'securityadmin'

    EXEC sp_droprolemember 'db_securityadmin', 'begood'