<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
    
        <div id="osp">
        <cfif structKeyExists(URL,'course')>    
            <cfquery name="getcourse"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">       
                     select c.course_id,
                            c.course_code,
                            c.course_name,
                            u.uni_name,
                            d.dept_name
                     from course c left join
                          university u on c.uni_id = u.uni_id left join
                          department d on c.dept_id = d.dept_id
                     where c.course_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#URL.course#'>                    
            </cfquery>
            
        <cfif getcourse.recordcount> 
            <cfoutput query="getcourse">
            <cfform action="updatecourse.cfm?course=#course_id#" 
                    method="post">   
            #uni_name#<br />
            #dept_name#<br />
            #course_code#<br />
            #course_name#<br />
            <br />
            Course Code:<br />
            <cfinput name="newccode" type="text" value="#course_code#" required="yes" width="200" 
                     maxlength="20" message="Please enter new course code or reset!"/><br />
            Course Name:<br />
            <cfinput name="newcname" type="text" value="#course_name#" required="yes" width="200" 
                      maxlength="255" message="Please enter new course name or reset!" /><br />
            <br />
            <cfinput name="submit" type="submit" value="Update" /> <cfinput name="reset" type="reset" value="Reset" />  
            </cfform>
            </cfoutput>
        <cfelse>
            There is no such course in the database; please <a href="course.cfm">try searching again.</a><br />
        </cfif> <!--- getcourse.recordcount --->
        <cfelse>
            Invalid course; please <a href="course.cfm">try searching again.</a><br />
        </cfif> <!--- structKeyExists(URL,'course') --->
        <br />
        <a href="course.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>