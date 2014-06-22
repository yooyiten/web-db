<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">    
    
        <cfparam name="Form.newfirst" default=-1 type="any"> 
        <cfparam name="Form.newlast" default=-1 type="any">         
        <cfparam name="Form.newtitle" default=-1 type="any">
        <cfparam name="Form.newmiddle" default=-1 type="any">   
        <cfparam name="Form.newsuffix" default=-1 type="any">
        <cfparam name="Form.newphone" default=-1 type="any">
        <cfparam name="Form.newemail" default=-1 type="any">
        
        <div id="osp">
        <cfif structKeyExists(URL,'instructor') && (not Form.newtitle is -1) &&
              (not Form.newfirst is -1) && (not Form.newmiddle is -1) &&
              (not Form.newlast is -1) && (not Form.newsuffix is -1) &&
              (not Form.newphone is -1) && (not Form.newemail is -1)>   
            <cfquery name="updateinstructor"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">       
                     update instructor i
                     set i.title = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=30 value='#Form.newtitle#'>,
                         i.middle_name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=30 value='#Form.newmiddle#'>,
                         i.suffix = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=30 value='#Form.newsuffix#'>,
                         i.phone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=20 value='#Form.newphone#'>,
                         i.email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength=50 value='#Form.newemail#'>
                     where i.i_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" maxlength=7 value='#URL.instructor#'>
            </cfquery>
            <br />
            Information for <b><cfoutput>#Form.newfirst# #Form.newlast#</cfoutput></b> successfully updated.
        <cfelse>
            Invalid instructor update; please <a href="instructor.cfm">try searching again.</a>
        </cfif> <!--- structKeyExists(URL,'instructor') and there are submitted form values --->
        <br />
        <br />
        <a href="instructor.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>