<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
   
      <cfquery name="getcourse"
               datasource="#Request.DSN#"
               username="#Request.username#"
               password="#Request.password#">
               select c.course_id as course_id,
                      c.course_code as course_code,
                      c.course_name as course_name,
                      u.uni_name as uni_name,
                      u.uni_name || ' | ' || c.course_name as display
               from course c left join 
                    university u on c.uni_id = u.uni_id
               order by u.uni_name,
                        c.course_name
        </cfquery>       
        
        <div id="osp">
        <br />
        Select a course to update its syllabi:<br />
        <br />
        <cfform action="coursesyllabi.cfm" method="post">
        <cfselect name="courseid" size="15" multiple="no" required="yes"
                  query="getcourse" value="course_id" display="display" 
                  message="Please select a course!" />
        <br />
        <cfinput name="submitcourse" type="submit" value="View syllabi" />
        </cfform>
        <br />
        - or -
        <br />
        <br />
        <cfform action="newcoursesyll.cfm" method="post">
        <cfinput name="submitnew" type="submit" value="Add syllabus for course not listed" />
        </cfform>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>