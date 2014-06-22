<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
    
        <div id="osp">
        <cfif structKeyExists(URL,'instructor')>    
            <cfquery name="getinstructor"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">       
                     select i.i_id,
                            i.title,
                            i.first_name,
                            i.middle_name,
                            i.last_name,
                            i.suffix,
                            i.phone,
                            i.email
                     from instructor i
                     where i.i_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#URL.instructor#'>
            </cfquery>
            
        <cfif getinstructor.recordcount> 
            <cfoutput query="getinstructor">
            <cfform action="updateinstructor.cfm?instructor=#i_id#"
                    method="post">
            <br />
            First Name:<br /> 
            <b>#first_name#</b>
            <cfinput type="hidden" name="newfirst" value="#first_name#" /><br />
            <br />
            Last Name:<br /> 
            <b>#last_name#</b>
            <cfinput type="hidden" name="newlast" value="#last_name#" /><br />
            <br />
            Title:<br />
            <cfinput type="text" name="newtitle" value="#title#" required="no" width="200" 
                     maxlength="30" /><br />
            Middle Name:<br /> 
            <cfinput type="text" name="newmiddle" value="#middle_name#" required="no" width="200"
                     maxlength="30" /><br />
            Suffix:<br /> 
            <cfinput type="text" name="newsuffix" value="#suffix#" required="no" width="200"
                     maxlength="30" /><br />            
            Phone:<br /> 
            <cfinput type="text" name="newphone" value="#phone#" required="no" width="200"
                     maxlength="20" /><br />  
            Email:<br /> 
            <cfinput type="text" name="newemail" value="#email#" required="yes" width="200"
                     maxlength="50" validate="email" Message="Please enter a correctly formatted email or reset!" /><br />  
            <br />
            <cfinput name="submit" type="submit" value="Update" /> <cfinput name="reset" type="reset" value="Reset" />
            </cfform>
            </cfoutput>
        <cfelse>
            There is no such instructor in the database; please <a href="instructor.cfm">try searching again.</a><br />
        </cfif> <!--- not getinstructor.recordcount --->
        <cfelse>
            Invalid instructor; please <a href="instructor.cfm">try searching again.</a><br />
        </cfif> <!--- structKeyExists(URL,'instructor') --->
        <br />
        <a href="instructor.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>