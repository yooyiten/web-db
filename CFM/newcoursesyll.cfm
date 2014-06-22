<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
        
        <div id="osp">      
            <cfquery name="getuni"
               datasource="#Request.DSN#"
               username="#Request.username#"
               password="#Request.password#">
               select u.uni_id,
                      u.uni_name
               from university u
               order by u.uni_name
            </cfquery>
            
            <cfquery name="getdept"
               datasource="#Request.DSN#"
               username="#Request.username#"
               password="#Request.password#">
               select d.dept_id,
                      d.dept_name
               from department d
               order by d.dept_name
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
            
            <cfform action="newcourseadd.cfm" 
                    method="post">
            <br />
            Add new syllabus:
            <br />
            <br />      
            Select university:<br />
            <select name="selectuni">
            <cfoutput query="getuni">
            <option value="#uni_id#">#uni_name#</option>
            </cfoutput>
            </select><br />
            <br />
            Select department:<br />
            <select name="selectdept">
            <cfoutput query="getdept">
            <option value="#dept_id#">#dept_name#</option>
            </cfoutput>
            </select><br />
            <br />
            Enter course code:<br/>
            <cfinput type="text" name="course_code" required="yes" width="200"
                     maxlength="20" Message="Please enter the course code!" /><br />             
            <br />
            Enter course name:<br/>
            <cfinput type="text" name="course_name" required="yes" width="200"
                     maxlength="255" Message="Please enter the course name!" /><br />             
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
        <br />
        <br />
        <a href="syllabus.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>