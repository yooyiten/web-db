<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

    <head>
        <title>open syllabus project</title>
        <link rel="stylesheet" type="text/css" href="ospstyle.css">
    </head>
    
    <body>
    <cfinclude template="header.cfm">  
    
        <div id="osp">
        <cfif structKeyExists(URL,'syllabus')>    
            <cfquery name="getsyllabus"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select s.syllabus_id,
                            s.url,
                            s.semester,
                            s.year,
                            s.student_count,             
                            c.course_code || ' | ' || c.course_name as course,
                            u.uni_name,
                            d.dept_name,
                            i.first_name || ' ' || i.last_name as instructor
                     from syllabus s left join
                          course c on s.course_id = c.course_id left join
                          university u on c.uni_id = u.uni_id left join
                          department d on c.dept_id = d.dept_id left join
                          instructor i on s.i_id = i.i_id
                     where s.syllabus_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#URL.syllabus#'>
            </cfquery>
            <cfquery name="gettags"
                     datasource="#Request.DSN#"
                     username="#Request.username#"
                     password="#Request.password#">   
                     select st.syllabus_id,
                            t.tag_id,
                            t.tag_desc
                     from syllabus_tag st inner join
                          tag t on st.tag_id = t.tag_id
                     where st.syllabus_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value='#URL.syllabus#'>
            </cfquery>
            
        <cfif getsyllabus.recordcount> 
            <cfoutput query="getsyllabus">
            <cfform action="updatesyllabus.cfm?syllabus=#syllabus_id#"
                    method="post">     
            #uni_name#<br />
            #dept_name#<br />
            #course#<br />
            #semester# #year#, #instructor#<br />
            <br />
            URL:<br />
            <cfinput type="text" name="newurl" value="#url#" required="yes" width="200"
                     maxlength="255" validate="url" Message="Please enter a correctly formatted URL or reset!" /><br /> 
            Student Count:<br />
            <cfinput type="text" name="newcount" value="#student_count#" required="yes" width="200"
                     maxlength="3" range="0,999" validate="integer" Message="Please enter a number from 0 to 999 or reset!" /><br />  
            <br />
            <cfinput name="submit" type="submit" value="Update" /> <cfinput name="reset" type="reset" value="Reset" />           
            </cfform>
            </cfoutput>
            <br />
            <br />
            Tags:
            <cfoutput query="gettags">
            #tag_desc#</a>/
            </cfoutput>
            <br />
            [ Update Tags ]
            <br />
            </form>
        <cfelse>
            There is no such syllabus in the database; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- not getsyllabus.recordcount --->
        <cfelse>
            Invalid syllabus; please <a href="syllabus.cfm">try searching again.</a><br />
        </cfif> <!--- structKeyExists(URL,'syllabus') --->
        <br />
        <a href="syllabus.cfm">Back</a>
        </div>
        
    <cfinclude template="footer.cfm">
    </body>
    
</html>