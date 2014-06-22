<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">    
    
        <cfparam name="Form.newccode" default=-1 type="any">
        <cfparam name="Form.newcname" default=-1 type="any">
        
        <div id="osp">
        <cfif structKeyExists(URL,'course') && (not Form.newccode is -1) &&
              (not Form.newcname is -1)>   
            <cfquery name="updatecourse"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">       
                     update course c
                     set c.course_code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=20 value='#Form.newccode#'>,
                         c.course_name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=255 value='#Form.newcname#'>
                     where c.course_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" maxlength=7 value='#URL.course#'>   
            </cfquery>
            <br />
            Information for <b><cfoutput>#Form.newcname#</cfoutput></b> successfully updated.
        <cfelse>
            Invalid course update; please <a href="course.cfm">try searching again.</a>
        </cfif> <!--- structKeyExists(URL,'course') and there are submitted form values --->
        <br />
        <br />
        <a href="course.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>