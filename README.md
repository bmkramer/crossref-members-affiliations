# Coverage of affiliation data in Crossref

Open science greatly benefits from the open availability of metadata on research output. Crossref members make a variety of metadata openly available to the research community. This facilitates analyzing and linking of research output, either by directly analyzing Crossref data or by integrating Crossref data in third-party applications. A prime example is the increasing (though still incomplete) [availability](https://i4oc.org/) and [use](http://opencitations.net/) of open citation data. 

Affiliation data, while very useful for such analyses, are not yet provided by all Crossref members,and where they are included, they are in free-text format which makes usability limited. The current Research Organization Registry (ROR) initiative, in which Crossref participates, aims to  https://www.ror.community/ROR (Research  

[Crossref Participation Reports](https://www.crossref.org/members/prep/) give an overview of the coverage of 10 selected metadata fields per member. Even though affiliation data are not included in these reports, Crossref does include information on coverage of affiliation data in the metadata they provide for each member via the Crossref REST API. 

This script uses the Crossref REST API to get information on the presence of affiliation information 
in metadata of all current research output and  current journal articles of each Crossref member (n=12238 as of Feb 28, 2019) 

Crossref REST API information: https://github.com/CrossRef/rest-api-doc
