# $Id$
#  
#  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
#  project.
#  
#  Copyright (C) 1998-2006 OpenLink Software
#  
#  This project is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; only version 2 of the License, dated June 1991.
#  
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License along
#  with this program; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
#  
#  

# ----------------------------------------------------------------------
#  Fix issues with LOCALE
# ----------------------------------------------------------------------
LANG=C
LC_ALL=POSIX
export LANG LC_ALL



cache_file()
{
  rawfile=$1
  arrayname=cres_`echo ${rawfile} | sed 's/[.-]/_/g'`
  filename=${fileprefix}${rawfile}
  uri=${uriprefix}${rawfile}
  publicid=$2${rawfile}
  pdate=${publishingdate}
  comment=$3
  echo "static const char * ${arrayname}[] =" >> texts.tmp
  awk -f res_to_c.awk $filename >> texts.tmp
  echo "" >> texts.tmp
  echo "CACHE_RESOURCE (${arrayname}, \"${uri}\", \"${publicid}\", \"${pdate}\", \"${comment}\");" >> function.tmp
}

echo "" > texts.tmp
echo "" > function.tmp

fileprefix='w3-TR-xhtml1-DTD/'
uriprefix='http://www.w3.org/TR/xhtml1/DTD/'
publishingdate='2002-08-01 18:37'
cache_file 'xhtml-lat1.ent'		'-//W3C//ENTITIES Latin 1 for XHTML//EN'	'Latin 1 character entity set'
cache_file 'xhtml-special.ent'		'-//W3C//ENTITIES Special for XHTML//EN'	'Special characters for XHTML'
cache_file 'xhtml-symbol.ent'		'-//W3C//ENTITIES Symbols for XHTML//EN'	'Mathematical, Greek and Symbolic characters for XHTML'
cache_file 'xhtml1-frameset.dtd'	'-//W3C//DTD XHTML 1.0 Frameset//EN'		'Extensibe HTML version 1.0 Frameset DTD'
cache_file 'xhtml1-strict.dtd'		'-//W3C//DTD XHTML 1.0 Strict//EN'		'Extensibe HTML version 1.0 Strict DTD'
cache_file 'xhtml1-transitional.dtd'	'-//W3C//DTD XHTML 1.0 Transitional//EN'	'Extensibe HTML version 1.0 Transitional DTD'

fileprefix='w3-2000-01/'
uriprefix='http://www.w3.org/2000/01/'
publishingdate='2004-02-10 20:54'
cache_file 'rdf-schema'		'<owl:Onthology rdf:about=\"http://www.w3.org/2000/01/rdf-schema#\"/>'	'An RDF description of the RDF and RDFS vocalulary'

fileprefix='openlinksw-sparql/'
uriprefix='http://www.openlinksw.com/sparql/'
publishingdate='2006-09-11 01:25'
cache_file 'virtrdf-data-formats.ttl'	''	'Quad Map memtadata for generic formats of relational-to-RDF data mapping'

cat texts.tmp
echo "void cache_resources (void)"
echo "{"
cat function.tmp
echo "}"
