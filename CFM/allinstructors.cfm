<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
    
      <cfquery name="getinstructor"
               datasource="#Request.DSN#"
               username="#Request.username#"
               password="#Request.password#">
               select i.last_name || ', ' || i.first_name as instructor,
                      i.i_id
               from instructor i
               order by i.last_name
        </cfquery>      
            
        <div id="osp">
            <br />
            <cfoutput query="getinstructor">
            <a href="showinstructor.cfm?instructor=#i_id#">#instructor#</a>
            <br />
            <br />
            </cfoutput>
            <br />
            <br />
            <a href="instructor.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>