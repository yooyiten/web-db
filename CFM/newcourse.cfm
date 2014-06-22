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
        <cfparam name="Form.course_code" default=-1 type="any">        
        <cfparam name="Form.course_name" default=-1 type="any">
        <cfparam name="Form.semester" default=-1 type="any">
        <cfparam name="Form.year" default=-1 type="any">
        <cfparam name="Form.studentcount" default=-1 type="any">
        <cfparam name="Form.url" default=-1 type="any">
        <cfparam name="Form.newfirst" default=-1 type="any">
        <cfparam name="Form.newlast" default=-1 type="any">
        <cfparam name="Form.newemail" default=-1 type="any">
        
        <div id="osp"> 
        <cfif (not Form.uni_name is -1) && (not Form.dept_name is -1) && 
              (not Form.course_code is -1) && (not Form.course_name is -1) && (not Form.semester is -1) &&
              (not Form.year is -1) && (not Form.studentcount is -1) && (not Form.url is -1) &&
              (not Form.newfirst is -1) && (not Form.newlast is -1) && (not Form.newemail is -1)>
            <cfquery name="checkcourse"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select c.course_id
                     from course c
                     where c.uni_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.uni_name#'> and
                           c.dept_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.dept_name#'> and
                           upper(c.course_code) like upper(<cfqueryparam value="%#trim(Form.course_code)#%" cfsqltype="CF_SQL_VARCHAR">) and
                           upper(c.course_name) like upper(<cfqueryparam value="%#trim(Form.course_name)#%" cfsqltype="CF_SQL_VARCHAR">)
            </cfquery>                      
        <cfif checkcourse.recordcount>
            This course is already in the database. You can go back and <a href="syllabus.cfm">select it from the list</a>.
        <cfelse>
            <cfquery name="checkinstructor"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select i.i_id
                     from instructor i
                     where upper(i.first_name) like upper(<cfqueryparam value="%#trim(Form.newfirst)#%" cfsqltype="CF_SQL_VARCHAR">) and
                           upper(i.last_name) like upper(<cfqueryparam value="%#trim(Form.newlast)#%" cfsqltype="CF_SQL_VARCHAR">) and  
                           upper(i.email) like upper(<cfqueryparam value="%#trim(Form.newemail)#%" cfsqltype="CF_SQL_VARCHAR">)
            </cfquery>
            <cfif checkinstructor.recordcount>
                This instructor is already in the database. Please <a href="newcoursesyll.cfm">go back</a> and select the instructor from the dropdown.
            <cfelse>
                <cfquery name="addinstructor"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         INSERT into instructor values(-1,
                                                       null,
                                                       <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.newfirst#'>,
                                                       null,
                                                       <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.newlast#'>,
                                                       null,
                                                       null,
                                                       <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.newemail#'>)
                </cfquery>
                <cfquery name="checkinstructor"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         select i.i_id
                         from instructor i
                         where upper(i.first_name) like upper(<cfqueryparam value="%#trim(Form.newfirst)#%" cfsqltype="CF_SQL_VARCHAR">) and
                               upper(i.last_name) like upper(<cfqueryparam value="%#trim(Form.newlast)#%" cfsqltype="CF_SQL_VARCHAR">) and  
                               upper(i.email) like upper(<cfqueryparam value="%#trim(Form.newemail)#%" cfsqltype="CF_SQL_VARCHAR">)
                </cfquery>
                <cfquery name="addcourse"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         INSERT into course values (-1,
                                                    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.uni_name#'>,
                                                    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.dept_name#'>,
                                                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.course_code#'>,
                                                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#Form.course_name#'>)                                     
                </cfquery>
                <cfquery name="checkcourse"
                         datasource="#Request.DSN#"
                         username="#Request.username#"
                         password="#Request.password#">   
                         select c.course_id
                         from course c
                         where c.uni_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.uni_name#'> and
                               c.dept_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.dept_name#'> and
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
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#checkinstructor.i_id#'>,
                                                     default,
                                                     default,
                                                     <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#Form.studentcount#'>)                                             
                </cfquery>
                Syllabus for <cfoutput><b>#Form.course_name#</b> (#Form.semester# #Form.year#)</cfoutput> successfully added.
            </cfif> <!--- checkinstructor.recordcount --->           
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