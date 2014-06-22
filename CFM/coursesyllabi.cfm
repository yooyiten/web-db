<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
    
        <cfparam name="Form.courseid" default=-1 type="any">
        
        <div id="osp"> 
        <cfif not Form.courseid is -1>
            <cfquery name="getsyllabus"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select s.syllabus_id,
                            s.url,
                            s.semester,
                            s.year,
                            s.student_count,  
                            s.course_id,
                            c.course_code,
                            c.course_name,
                            u.uni_name,
                            d.dept_name,
                            i.first_name|| ' ' || i.last_name as instructor
                     from syllabus s left join
                          course c on s.course_id = c.course_id left join
                          university u on c.uni_id = u.uni_id left join
                          department d on c.dept_id = d.dept_id left join
                          instructor i on s.i_id = i.i_id
                     where s.course_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.courseid#'>
                     order by s.year,
                              s.semester
            </cfquery>
            
        <cfif getsyllabus.recordcount> 
            Syllabi for <b><cfoutput>#getsyllabus.uni_name# / #getsyllabus.dept_name# / #getsyllabus.course_name#</cfoutput></b>:
            <br />
            <br />
            <cfoutput query="getsyllabus">
            <a href="#url#" target=new>#course_name#</a><br />
            #semester# #year#<br/>
            Instructor: #instructor#<br />
            [ <a href="showsyllabus.cfm?syllabus=#syllabus_id#">Update</a> ]
            <br />
            <br />
            </cfoutput>
            <br />
            <br />
            <cfform action="newsemestersyll.cfm?course=#Form.courseid#" method="post">
            <cfinput name="submitnew" type="submit" value="Add syllabus for different semester" />
            </cfform>        
        <cfelse>
            There are no syllabi for this course.<br />
        </cfif> <!--- not getsyllabus.recordcount --->
        <cfelse>
            Invalid course; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- not Form.courseid is -1 --->
        <br />
        <br />
        <a href="syllabus.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>