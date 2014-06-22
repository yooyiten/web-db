<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
    
        <cfparam name="Form.coursename" default=-1 type="any">
        
        <div id="osp">
        <cfif not Form.coursename is -1>
            <cfquery name="searchcourses"
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
               where upper(c.course_name) like upper(<cfqueryparam value="%#trim(Form.coursename)#%" cfsqltype="CF_SQL_VARCHAR">)
               order by u.uni_name,
                        d.dept_name,
                        c.course_name
            </cfquery>
            
        <cfif searchcourses.recordcount>
            <cfoutput query="searchcourses">
            #uni_name#<br />
            #dept_name#<br />
            <a href="showcourse.cfm?course=#course_id#">#course_name#</a> (#course_code#)<br />
            <br />
            </cfoutput>
        <cfelse>
            There are no matches on '<i><cfoutput>#Form.coursename#</cfoutput></i>'.<br />
        </cfif> <!--- not searchcourses.recordcount --->
        <cfelse>
            Invalid course name search; please <a href="course.cfm">try again</a>.<br />
        </cfif> <!--- Form.coursename parameter was passed --->
        <br />
        <a href="course.cfm">Back</a>            
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>