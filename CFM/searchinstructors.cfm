<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
    
        <cfparam name="Form.lastname" default=-1 type="any">
        
        <div id="osp">
        <cfif not Form.lastname is -1>
            <cfquery name="searchinstructors"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">      
               select i.last_name || ', ' || i.first_name as instructor,
                      i.i_id
               from instructor i
               where upper(i.last_name) like upper(<cfqueryparam value="%#trim(Form.lastname)#%" cfsqltype="CF_SQL_VARCHAR">)
               order by i.last_name
            </cfquery>
            
        <cfif searchinstructors.recordcount>
            <cfoutput query="searchinstructors">
            <a href="showinstructor.cfm?instructor=#i_id#">#instructor#</a><br />
            <br />
            </cfoutput>
        <cfelse>
            There are no matches on '<i><cfoutput>#Form.lastname#</cfoutput></i>'.<br />
        </cfif> <!--- not searchinstructors.recordcount --->
        <cfelse>
            Invalid instructor last name search; please <a href="instructor.cfm">try again</a>.<br />
        </cfif> <!--- Form.coursename parameter was passed --->
        <br />
        <a href="instructor.cfm">Back</a>            
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>