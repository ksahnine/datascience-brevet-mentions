#! /usr/bin/python
# -*- coding: utf-8 -*-
# vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4

__author__  = "Kadda SAHNINE"
__contact__ = "ksahnine@gmail.com"
__license__ = 'GPL v3'

import xml.etree.ElementTree as ET
import logging
import urllib
import urllib2
import os
import re
import sys
import string
import getopt
from unicodedata import normalize
from bs4 import BeautifulSoup

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger()

root_url = "http://www.francetvinfo.fr/brevet"
output_dir = 'output'

def main(argv):
    """
    Extracteur des resultats du brevet des colleges 2015
    Pour extraire d'autres resultats d'examen, modifier la variable root_url :
        - Baccalaureat  : http://www.francetvinfo.fr/bac
        - BEP           : http://www.francetvinfo.fr/bep
        - BTS           : http://www.francetvinfo.fr/bts
        - CAP           : http://www.francetvinfo.fr/cap
    """
    global output_dir
    academie = None
    departement = None
    commune = None

    try:
        opts, args = getopt.getopt(argv, "ho:a:d:c:", ["help","output-dir=","academie=","departement=","commune="])
    except getopt.GetoptError:
        usage()
        sys.exit(1)

    for o, a in opts:
        if o in ("-h", "--help"):
            usage()
            sys.exit(0)
        if o in ("-o", "--output-dir" ):
            output_dir = a
        if o in ("-a", "--academie" ):
            academie = a
        if o in ("-d", "--departement" ):
            departement = a
        if o in ("-c", "--commune" ):
            commune = a

    if not academie:
        list_keys()
    else:
        logger.debug("** Debut extraction academie %s %s commune %s **", academie, departement, commune)
        get_data_by_commune(academie,departement,commune)
        logger.debug("** Fin extraction academie %s %s commune %s **", academie, departement, commune)

def list_keys():
    soup = BeautifulSoup(urllib2.urlopen(root_url).read())
    for e in soup.find('form', id='exam-search-form').find_all('div', class_='col-1')[0].find_all('li'):
        ac_link = e.a['href']
        ac_id = ac_link.rsplit('/', 2)[1]
        url = "%s/%s/" % (root_url,ac_id)
        soup = BeautifulSoup(urllib2.urlopen(url).read())
        section = soup.find('div', id='exam').find_all('section', limit=1)[0]
        dep_nom = None
        for e in section.children:
            tag_name = e.name
            if tag_name == 'h3':
                dep_nom = normalize('NFKD', e.text).encode('ASCII', 'ignore').replace(" ", "_")
            elif tag_name == 'ul':
                for c in e.children:
                    com_link = c.a['href']
                    com_id = com_link.rsplit('/', 2)[1]
                    print "%s %s %s" % (ac_id, dep_nom, com_id) 

def get_data_by_commune(academie, departement, commune):
    url = "%s/%s/%s/" % (root_url,academie,commune)
    soup = BeautifulSoup(urllib2.urlopen( url ).read())
    for s in soup.find('div', id='exam').find_all('div', class_='list-specialty'):
        serie = None
        for e in s.children:
            tag_name = e.name
            if tag_name == 'h2':
                serie = re.sub('[/()\' ]', '', normalize("NFKD", e.text).encode('ASCII', 'ignore'))
                logger.debug(" - Serie : %s", serie)
            elif tag_name == 'div':
                for u in e.children:
                    if u.name == 'ul':
                        for c in u.children:
                            if not c.get('class'):
                                link = c.a['href']
                                nom = c.a.strong.text
                                prenoms = normalize('NFKD', list(c.a.children)[1].strip()).encode('ASCII', 'ignore')
                                prenom = prenoms.split(' ')[0]
                                write_resultats_candidat(academie, departement, commune, serie, nom, prenom, link)

def write_resultats_candidat(academie, departement, commune, serie, nom, prenom, link):
    outdir = "%s/%s/%s/%s" % (output_dir,academie,departement,commune)
    outfile = "%s/%s.csv" % (outdir, serie)
    if not os.path.exists(outdir):
        os.makedirs(outdir)

    try:
        soup = BeautifulSoup(urllib2.urlopen( link ).read())
        result = soup.find('div', id='exam').find_all('p', class_='result')[0]
        details_result = list(result.children)
        statut = None
        mention = None
        if ( len(details_result) == 0 ):
            statut = details_result.text
        if ( len(details_result) == 1 ):
            if isinstance(details_result[0], basestring):
                statut = details_result[0]
            else:
                statut = details_result[0].text
        if ( len(details_result) > 1 ):
            mention = details_result[1].strip()
            statut = details_result[0].text
    
        with open(outfile, "a") as res_file:
            res_file.write( "%s;%s;%s;%s;%s;%s;%s\n" % (academie,departement,commune,statut,mention,nom,prenom) )
    except urllib2.HTTPError, err:
        logger.error("Erreur HTTP %d %s", err.code, link)

if __name__ == "__main__":
    main(sys.argv[1:])
