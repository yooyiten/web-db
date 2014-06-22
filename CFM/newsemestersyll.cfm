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
            
            <cfquery name="getinstructor"
               datasource="#Request.DSN#"
               username="#Request.username#"
               password="#Request.password#">
               select i.last_name || ', ' || i.first_name || ' | ' || i.email as instructor,
                      i.i_id
               from instructor i
               order by i.last_name
            </cfquery>
            
        <cfif getcourse.recordcount> 
            <cfform action="newsemesteradd.cfm" 
                    method="post">
            <br />
            Add new syllabus:
            <br />
            <br />      
            University: <b><cfoutput>#getcourse.uni_name#</cfoutput></b><br />
            <cfinput type="hidden" name="uni_name" value="#getcourse.uni_name#" />
            Department: <b><cfoutput>#getcourse.dept_name#</cfoutput></b><br />
            <cfinput type="hidden" name="dept_name" value="#getcourse.dept_name#" />
            <cfinput type="hidden" name="course_id" value="#getcourse.course_id#" />
            Course Code: <b><cfoutput>#getcourse.course_code#</cfoutput></b><br />
            <cfinput type="hidden" name="course_code" value="#getcourse.course_code#" />
            Course Name: <b><cfoutput>#getcourse.course_name#</cfoutput></b><br />
            <cfinput type="hidden" name="course_name" value="#getcourse.course_name#" />
            <br />
            Select semester:<br />
            <select name="semester">
            <option value="FALL">FALL</option>
            <option value="WINTER">WINTER</option>
            <option value="SPRING">SPRING</option>
            <option value="SUMMER">SUMMER</option>
            </select><br />
            <br />
            Enter year:<br/>
            <cfinput type="text" name="year" value="2013" required="yes" width="200"
                     maxlength="4" range="1900,2500" validate="integer" Message="Please enter a 4-digit year!" /><br />             
            <br />
            Enter student count:<br/>
            <cfinput type="text" name="studentcount" value="0" required="yes" width="200"
                     maxlength="3" range="0,999" validate="integer" Message="Please enter a number from 0 to 999!" /><br />             
            <br />
            Enter URL of syllabus:<br />
            <cfinput type="text" name="url" value="http://" required="yes" width="200"
                     maxlength="255" validate="url" Message="Please enter a correctly formatted URL!" /><br /> 
            <br />
            Select instructor:<br />
            <select name="selectinstructor">
            <cfoutput query="getinstructor">
            <option value="#i_id#">#instructor#</option>
            </cfoutput>
            </select><br />  
            <br />
            <cfinput name="submit" type="submit" value="Add" /> <cfinput name="reset" type="reset" value="Reset" /> 
            <br />
            <br />
            - or -
            <br />
            <br />
            <cfinput name="submit" type="submit" value="Add with instructor not listed" />          
            </cfform>  
        <cfelse>
            There is no such course in the database; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- getcourse.recordcount --->
        <cfelse>
            Invalid course; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- structKeyExists(URL,'course') --->
        <br />
        <br />
        <a href="syllabus.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>