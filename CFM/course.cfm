<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
        
        <div id="osp">
        <br />
        <br />
        <a href="allcourses.cfm">List all courses</a> or search by
        course name:
        <br />
        <br />
        <cfform action="searchcourses.cfm" method="post">
            <cfinput name="coursename" type="text" required="yes" width="200" 
                     message="Please enter search text!" maxlength="255" />
            <br />
            <br />
            <cfinput name="submit" type="submit" value="Search" /> <cfinput name="reset" type="reset" value="Reset" /> 
        </cfform>
        <br />
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>