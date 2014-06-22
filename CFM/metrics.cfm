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
        <a href="allsyllabi.cfm">View list of all syllabi</a>
        <br />
        <br />
        <cfform action="charts.cfm" 
                    method="post">
        View charts for uploaded syllabi:
        <select name="chart">
        <option value="uni">Comparison across universities</option>
        <option value="dept">Comparison across departments</option>
        <option value="instructor">Comparison by instructor</option>
        <option value="course">Comparison by course</option>
        <option value="studentcount">3 top syllabi by student count</option>
        </select>
        <br />
        <br />
        <cfinput name="submit" type="submit" value="Go!" />
        </cfform>
        <br />
        <br />
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>