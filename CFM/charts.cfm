<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">
    
        <cfparam name="Form.chart" default=-1 type="any">
     
        <div id="osp">
        <cfif not Form.chart is -1> 
            <cfif #Form.chart# eq "uni">
                <b>Syllabi counts by university:</b><br />
                <cfquery name="unisyllabi"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">
                         select s.syllabus_id,
                                c.course_id,
                                c.uni_id,
                                u.uni_name
                         from syllabus s inner join
                              course c on s.course_id = c.course_id inner join
                              university u on c.uni_id = u.uni_id    
                </cfquery>        
                <cfquery dbtype="query" name="chartdata">
                         select uni_name,
                         count(syllabus_id) as scount
                         from unisyllabi
                         group by uni_name
                </cfquery>
                <cfchart format="flash" 
                         xaxistitle="University" 
                         yaxistitle="Syllabus Count"> 
                <cfchartseries type="pie" 
                               query="chartdata" 
                               itemcolumn="uni_name" 
                               valuecolumn="scount">
                </cfchartseries>
                </cfchart>             
            <cfelseif #Form.chart# eq "dept">
                <b>Syllabi counts by department:</b><br />            
                <cfquery name="deptsyllabi"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">
                         select s.syllabus_id,
                                c.course_id,
                                c.dept_id,
                                d.dept_name
                         from syllabus s inner join
                              course c on s.course_id = c.course_id inner join
                              department d on c.dept_id = d.dept_id    
                </cfquery>        
                <cfquery dbtype="query" name="chartdata">
                         select dept_name,
                         count(syllabus_id) as scount
                         from deptsyllabi
                         group by dept_name
                </cfquery>
                <cfchart format="flash" 
                         xaxistitle="Department" 
                         yaxistitle="Syllabus Count"> 
                <cfchartseries type="pie" 
                               query="chartdata" 
                               itemcolumn="dept_name" 
                               valuecolumn="scount">
                </cfchartseries>
                </cfchart> 
            <cfelseif #Form.chart# eq "instructor">
                <b>Syllabi counts by instructor:</b><br />
                <cfquery name="instsyllabi"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">
                         select s.syllabus_id,
                                s.i_id,
                                i.first_name || ' ' || i.last_name as instructor
                         from syllabus s inner join
                              instructor i on s.i_id = i.i_id   
                </cfquery>        
                <cfquery dbtype="query" name="chartdata">
                         select instructor,
                         count(syllabus_id) as scount
                         from instsyllabi
                         group by instructor
                </cfquery>
                <cfchart format="flash" 
                         xaxistitle="Instructor" 
                         yaxistitle="Syllabus Count"> 
                <cfchartseries type="pie" 
                               query="chartdata" 
                               itemcolumn="instructor" 
                               valuecolumn="scount">
                </cfchartseries>
                </cfchart> 
            <cfelseif #Form.chart# eq "course">
                <b>Syllabi counts by course:</b><br />
                <cfquery name="coursesyllabi"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">
                         select s.syllabus_id,
                                c.course_id,
                                c.course_name
                         from syllabus s inner join
                              course c on s.course_id = c.course_id  
                </cfquery>        
                <cfquery dbtype="query" name="chartdata">
                         select course_name,
                         count(syllabus_id) as scount
                         from coursesyllabi
                         group by course_name
                </cfquery>
                <cfchart format="flash" 
                         xaxistitle="Course" 
                         yaxistitle="Syllabus Count"> 
                <cfchartseries type="pie" 
                               query="chartdata" 
                               itemcolumn="course_name" 
                               valuecolumn="scount">
                </cfchartseries>
                </cfchart> 
            <cfelseif #Form.chart# eq "studentcount">
                <b>Three top syllabi by student count:</b><br />
                <cfquery name="studsyllabi"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">
                         select syll.syllabus_id,
                                syll.semester,
                                to_char(syll.year) as syear,
                                syll.course_name,
                                syll.student_count
                         from (select s.syllabus_id,
                                      s.semester,
                                      s.year,
                                      c.course_name,
                                      s.student_count
                               from syllabus s inner join
                                    course c on s.course_id = c.course_id
                               order by s.student_count desc) syll
                         where rownum <= 3
                </cfquery>        
                <cfquery dbtype="query" name="chartdata">
                         select syllabus_id,
                                course_name || ' ' || semester || ' ' || syear as syllabus,
                                student_count
                         from studsyllabi
                </cfquery>
                <cfchart format="flash" 
                         xaxistitle="Syllabus" 
                         yaxistitle="Student Count"> 
                <cfchartseries type="bar" 
                               query="chartdata" 
                               itemcolumn="syllabus" 
                               valuecolumn="student_count">
                </cfchartseries>
                </cfchart> 
            <cfelse>
                Invalid chart request; please <a href="metrics.cfm">try again</a>.
            </cfif> <!--- check chart selection --->
        <cfelse>
            Invalid chart request; please <a href="metrics.cfm">try again</a>.
        </cfif> <!--- not Form.chart is -1 --->
        <br />
        <br />
        <a href="metrics.cfm">Back</a> 
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>