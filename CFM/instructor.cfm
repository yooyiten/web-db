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
        <a href="allinstructors.cfm">List all instructors</a> or search by
        last name:
        <br />
        <br />
        <cfform action="searchinstructors.cfm" method="post">
            <cfinput name="lastname" type="text" required="yes" width="200" 
                     message="Please enter last name!" maxlength="30" />
            <br />
            <br />
            <cfinput name="submit" type="submit" value="Search" /> <cfinput name="reset" type="reset" value="Reset" /> 
        </cfform>
        <br />
        </div>        
 
    <cfinclude template="footer.cfm">
    </body>
    
</html>