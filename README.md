

# SQL Executive Dashboard PROD

> This script is the source of truth for the Tableau Executive dashboard.

<p style="color:#8c8c8c;font-size:small">
This SQL query (Postgres) pulls all relevant information needed to build the executive dashboard in Tableau. Relevant tables from the Banner/PROD provide data to visualize enrollment counts by term, college gender, ethnicity, student level and first generation status.
</p>

--- 

### Tableau Workbook Visualizations

- Total enrollment by academic term
- Comparison of enrollment to previous term
- Gender by academic term
- Ethnicity by academic term
- First generation status by academic term
- Enrollment by college by academic term
- Student level (Graduate, Undergraduate) and Student classification (First time Freshman, Transfer, etc)

<br><br>

### Table description
<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 15% />
<col style="width: 70%" />

</colgroup>
<thead>
<tr class="header">
<th>Field</th>
<th>Source</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td> term_code </td>
<td>sfrstcr_term_code</td>
<td>Term code EX: 202040</td>
</tr>
<tr class="even">
<td>stvterm_desc</td>
<td>stvterm_desc</td>
<td>Term description EX: Fall 2020</td>
</tr>
<tr class="odd">
<td>levl_code</td>
<td>sgbstdn_levl_code</td>
<td>Student level code. EX: UG.</td>
</tr>
<tr class="even">
<td>stvlevl_desc</td>
<td>stvlevl_desc</td>
<td>Student level description. EX: Undergraduate</td>
</tr>
<tr class="odd">
<td>coll_code</td>
<td>sgbstdn_coll_code_1</td>
<td>Primary college enrolled by student. EX: College of Education</td>
</tr>
<tr class="even">
<td>student_pidm</td>
<td>sgbstdn_pidm</td>
<td>Student level pidm.</td>
</tr>
<tr class="odd">
<td>stvstyp_code</td>
<td>stvstyp_code</td>
<td>Student type code. EX: F
</tr>
<tr class="even">
<td>stvstyp_desc</td>
<td>stvstyp_desc</td>
<td>Student type description EX: Freshman</td>
</tr>
<tr class="odd">
<td>fterm_ind</td>
<td>sgbstdn_pidm</td>
<td>Case statement to creat first term indicator Y/N</td>
</tr>
<tr class="even">
<td>sgbstdn_program</td>
<td>sgbstdn_program</td>
<td>Program code indicator. EX: BSN-NURS</td>
</tr>
<tr class="odd">
<td>spbpers_sex</td>
<td>spbpers_sex</td>
<td>
Gender.
</td>
</tr>
<tr class="even">
<td>race_ethn</td>
<td>Ethnicity is pulled using a function: dsc.f_get_race_ethn.</td>
</tr>
</tbody>
</table>

