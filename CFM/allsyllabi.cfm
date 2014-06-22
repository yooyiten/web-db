<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project: all syllabi</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
      <cfquery name="getsyllabus"
               datasource="#Request.DSN#"
               username="#Request.username#"
               password="#Request.password#">
               select s.syllabus_id as id,
                      s.url,
                      s.semester,
                      s.year,
                      s.student_count,             
                      trim(c.course_code) as course_code,
                      trim(c.course_name) as course_name,
                      trim(u.uni_name) as uni_name,
                      trim(d.dept_name) as dept_name,
                      trim(i.first_name) || ' ' || trim(i.last_name) as instructor
               from syllabus s left join
                    course c on s.course_id = c.course_id left join
                    university u on c.uni_id = u.uni_id left join
                    department d on c.dept_id = d.dept_id left join
                    instructor i on s.i_id = i.i_id
               order by trim(u.uni_name),
                        trim(d.dept_name),
                        trim(c.course_name)
        </cfquery>      
            
        <div id="osp">
            <cfoutput query="getsyllabus">
            <br />
            <a href="#url#" target=new>#course_name#</a><br />
            #semester# #year#<br />
            #instructor#, #uni_name#<br />
            [<a href="showsyllabus.cfm?syllabus=#id#">update</a>]
            <br />
            </cfoutput>
            <br />
            <a href="metrics.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>