# Coverage of affiliation data in Crossref

Open science greatly benefits from the open availability of metadata on research output. Crossref members make a variety of metadata openly available to the research community. This facilitates analyzing and linking of research output, either by directly analyzing Crossref data or by integrating Crossref data in third-party applications. A prime example is open citation data, made available by an increasing number of Crossref members (see [I4OC](https://i4oc.org/)).  

Affiliation data, while very useful for analyses, are not yet provided by all Crossref members,and where they are included, they are in free-text format which makes usability limited. The current [Research Organization Registry (ROR)](https://www.ror.community/ROR) initiative, in which Crossref participates, aims to provide a system of unique identifiers for research organizations. If implemented as Crossref metadata, it would greatly increase the possibilities to link and analyse information on research output at institutional levels using open data. 

Meanwhile though, it is interesting to look at which members currently already provide affiliation data, and which don't. [Crossref Participation Reports](https://www.crossref.org/members/prep/) give an overview of the coverage of 10 selected metadata fields per member. Affiliation data are not (yet) included in these reports, but information on their availability is included as 11th coverage parameter via the [Crossref REST API](https://github.com/CrossRef/rest-api-doc).

Therefore, I used a script to query the Crossref REST API for information on the presence of affiliation information 
in metadata of all current research output and  current journal articles of each Crossref member (n=12238 as of Feb 28, 2019). 
'Current' is defined by Crossref as the current year plus the two full preceding years. 

##Results
