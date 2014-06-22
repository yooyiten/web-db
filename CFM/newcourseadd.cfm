<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
 
        <cfparam name="Form.selectuni" default=-1 type="any">
        <cfparam name="Form.selectdept" default=-1 type="any">
        <cfparam name="Form.course_code" default=-1 type="any">        
        <cfparam name="Form.course_name" default=-1 type="any">
        <cfparam name="Form.semester" default=-1 type="any">
        <cfparam name="Form.year" default=-1 type="any">
        <cfparam name="Form.studentcount" default=-1 type="any">
        <cfparam name="Form.url" default=-1 type="any">
        <cfparam name="Form.selectinstructor" default=-1 type="any">
        
        <div id="osp"> 
        <cfif (not Form.selectuni is -1) && (not Form.selectdept is -1) && 
              (not Form.course_code is -1) && (not Form.course_name is -1) && (not Form.semester is -1) &&
              (not Form.year is -1) && (not Form.studentcount is -1) && (not Form.url is -1) &&
              (not Form.selectinstructor is -1)>
            <cfquery name="checkcourse"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select c.course_id
                     from course c
                     where c.uni_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectuni#'> and
                           c.dept_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectdept#'> and
                           upper(c.course_code) like upper(<cfqueryparam value="%#trim(Form.course_code)#%" cfsqltype="CF_SQL_VARCHAR">) and
                           upper(c.course_name) like upper(<cfqueryparam value="%#trim(Form.course_name)#%" cfsqltype="CF_SQL_VARCHAR">)
            </cfquery>   
        <cfif checkcourse.recordcount>
            This course is already in the database. You can go back and <a href="syllabus.cfm">select it from the list</a>.
        <cfelse>
            <cfif #Form.submit# eq "Add">
                <cfquery name="addcourse"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         INSERT into course values (-1,
                                                    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectuni#'>,
                                                    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectdept#'>,
                                                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.course_code#'>,
                                                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.course_name#'>)                                     
                </cfquery>
                <cfquery name="checkcourse"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         select c.course_id
                         from course c
                         where c.uni_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectuni#'> and
                               c.dept_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectdept#'> and
                               upper(c.course_code) like upper(<cfqueryparam value="%#trim(Form.course_code)#%" cfsqltype="CF_SQL_VARCHAR">) and
                               upper(c.course_name) like upper(<cfqueryparam value="%#trim(Form.course_name)#%" cfsqltype="CF_SQL_VARCHAR">)
                </cfquery> 
                <cfquery name="addsyll"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">  
                         INSERT into syllabus values(-1,
                                                     <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.url#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.semester#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.year#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#checkcourse.course_id#'>,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectinstructor#'>,
                                                     default,
                                                     default,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.studentcount#'>)                                
                </cfquery>
                Syllabus for <cfoutput><b>#Form.course_name#</b> (#Form.semester# #Form.year#)</cfoutput> successfully added.
            <cfelseif #Form.submit# eq "Add with instructor not listed">
                <cfquery name="getuni"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         select u.uni_name
                         from university u
                         where u.uni_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectuni#'>
                </cfquery> 
                <cfquery name="getdept"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         select d.dept_name
                         from department d
                         where d.dept_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.selectdept#'>
                </cfquery> 
                <cfform action="newcourse.cfm" 
                        method="post">
                <cfoutput>
                <br />
                University: <b>#getuni.uni_name#</b><br />
                <cfinput type="hidden" name="uni_name" value="#Form.selectuni#" />
                Department: <b>#getdept.dept_name#</b><br />
                <cfinput type="hidden" name="dept_name" value="#Form.selectdept#" />
                Course Code: <b>#Form.course_code#</b><br />
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
        </cfif> <!--- checkcourse.recordcount --->
        <cfelse>
            Invalid syllabus update; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- form variables were passed --->
        <br />
        <br />
        <a href="syllabus.cfm">Back</a>        
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>