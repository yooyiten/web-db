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
                      d.dept_name as dept_name
               from course c left join 
                    university u on c.uni_id = u.uni_id left join
                    department d on c.dept_id = d.dept_id
               order by u.uni_name,
                        d.dept_name,
                        c.course_name
        </cfquery>      
            
        <div id="osp">
            <br />
            <cfoutput query="getcourse">
            #uni_name#<br />
            #dept_name#<br />
            <a href="showcourse.cfm?course=#course_id#">#course_name#</a> (#course_code#)<br />
            <br />
            </cfoutput>
            <br />
            <br />
            <a href="course.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>