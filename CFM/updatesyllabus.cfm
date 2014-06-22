<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">     
    
        <cfparam name="Form.newurl" default=-1 type="any">
        <cfparam name="Form.newcount" default=-1 type="any">
        
        <div id="osp">
        <cfif structKeyExists(URL,'syllabus') && (not Form.newurl is -1) &&
              (not Form.newcount is -1)>   
            <cfquery name="updatesyllabus"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">       
                     update syllabus s
                     set s.url = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=255 value='#Form.newurl#'>,
                         s.student_count = <cfqueryparam cfsqltype="CF_SQL_INTEGER" maxlength=3 value='#Form.newcount#'>
                     where s.syllabus_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" maxlength=7 value='#URL.syllabus#'>
            </cfquery>
            <br />
            Information for syllabus successfully updated.
        <cfelse>
            Invalid syllabus update; please <a href="syllabus.cfm">try searching again.</a>
        </cfif> <!--- structKeyExists(URL,'syllabus') and there are submitted form values --->
        <br />
        <br />
        <a href="syllabus.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>