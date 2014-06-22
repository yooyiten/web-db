<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
 
        <cfparam name="Form.uni_name" default=-1 type="any">
        <cfparam name="Form.dept_name" default=-1 type="any">
        <cfparam name="Form.course_id" default=-1 type="any">
        <cfparam name="Form.course_code" default=-1 type="any">        
        <cfparam name="Form.course_name" default=-1 type="any">
        <cfparam name="Form.semester" default=-1 type="any">
        <cfparam name="Form.year" default=-1 type="any">
        <cfparam name="Form.studentcount" default=-1 type="any">
        <cfparam name="Form.url" default=-1 type="any">
        <cfparam name="Form.selectinstructor" default=-1 type="any">
        
        <div id="osp"> 
        <cfif (not Form.uni_name is -1) && (not Form.dept_name is -1) && (not Form.course_id is -1) &&
              (not Form.course_code is -1) && (not Form.course_name is -1) && (not Form.semester is -1) &&
              (not Form.year is -1) && (not Form.studentcount is -1) && (not Form.url is -1) &&
              (not Form.selectinstructor is -1)>
            <cfquery name="checksyllabus"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select s.syllabus_id
                     from syllabus s
                     where s.course_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.course_id#'> and
                           upper(s.semester) like upper(<cfqueryparam value="%#trim(Form.semester)#%" cfsqltype="CF_SQL_VARCHAR">) and
                           s.year = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.year#'>
            </cfquery>                      
        <cfif checksyllabus.recordcount>
            This syllabus is already in the database. You can 
            <a href="showsyllabus.cfm?syllabus=<cfoutput>#checksyllabus.syllabus_id#</cfoutput>">update it instead</a>.
        <cfelse>
            <cfif #Form.submit# eq "Add">
                <cfquery name="addsyll"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         INSERT into syllabus values(-1,
                                                     <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.url#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.semester#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.year#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.course_id#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectinstructor#'>,
                                                     default,
                                                     default,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.studentcount#'>)                                             
                </cfquery>
                Syllabus for <cfoutput><b>#Form.course_name#</b> (#Form.semester# #Form.year#)</cfoutput> successfully added.
            <cfelseif #Form.submit# eq "Add with instructor not listed">
                <cfform action="newinstructor.cfm" 
                        method="post">
                <cfoutput>
                <br />
                University: <b>#Form.uni_name#</b><br />
                <cfinput type="hidden" name="uni_name" value="#Form.uni_name#" />
                Department: <b>#Form.dept_name#</b><br />
                <cfinput type="hidden" name="dept_name" value="#Form.dept_name#" />
                Course Code: <b>#Form.course_code#</b><br />
                <cfinput type="hidden" name="course_id" value="#Form.course_id#" />
                <cfinput type="hidden" name="course_code" value="#Form.course_code#" />
                Course Name: <b>#Form.course_name#</b><br />
                <cfinput type="hidden" name="course_name" value="#Form.course_name#" />
                Semester: <b>#Form.semester#</b><br />
                <cfinput type="hidden" name="semester" value="#Form.semester#" />
                Year: <b>#Form.year#</b><br />
                <cfinput type="hidden" name="year" value="#Form.year#" />
                Student Count: <b>#Form.studentcount#</b><br />
                <cfinput type="hidden" name="studentcount" value="#Form.studentcount#" />
                URL: <b>#Form.url#</b><br />
                <cfinput type="hidden" name="url" value="#Form.url#" />
                <br />
                </cfoutput>
                Instructor first name:<br />
                <cfinput type="text" name="newfirst" required="yes" width="200" 
                         maxlength="30" Message="Please enter first name!"  /><br />
                Instructor last name:<br />
                <cfinput type="text" name="newlast" required="yes" width="200" 
                         maxlength="30" Message="Please enter last name!"  /><br />
                Instructor email:<br />
                <cfinput type="text" name="newemail" required="yes" width="200" 
                        maxlength="50" validate="email" Message="Please enter a correctly formatted email!" /><br /> 
                <br />
                <cfinput name="submit" type="submit" value="Add" />            
                </cfform>
            </cfif> <!--- check which submit button was used --->           
        </cfif> <!--- checksyllabus.recordcount --->
        <cfelse>
            Invalid syllabus update; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- form variables were passed --->
        <br />
        <br />
        <a href="newsemestersyll.cfm?course=<cfoutput>#Form.course_id#</cfoutput>">Back</a>        
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>