#! /bin/bash

#mongoimport --host mongodb --db movies --collection credits --type JSON --file "/jsons/tmdb_5000_credits.json" --jsonArray

tail -n +2 /mongo/casting.csv | mongoimport --host mongodb -d movies -c casting --drop --type csv --columnsHaveTypes --fields "cast_id.int32(),character_name.auto(),gender.auto(),name.auto(),order_id.int32(),movie_id.int32()"
tail -n +2 /mongo/crew.csv | mongoimport --host mongodb -d movies -c crew --drop --type csv --columnsHaveTypes --fields "department.auto(),crew_id.int32(),name.auto(),job.auto(),movie_id.int32()"

#tail -n +2 /mongo-data/psm.csv | mongoimport --host mongodb -d bioitems -c psms --drop --type csv --fieldFile /mongo-seed/psmHeaderFields.txt --columnsHaveTypes

#tail -n +2 /mongo-seed/protein.csv | mongoimport --host mongodb --type csv -d cromixdb -c protein --drop --fieldFile /mongo-seed/proteinHeaderFields.txt --columnsHaveTypes
#tail -n +2 /mongo-seed/peptide.csv | mongoimport --host mongodb --type csv -d cromixdb -c peptide --drop --fieldFile /mongo-seed/peptideHeaderFields.txt --columnsHaveTypes
#tail -n +2 /mongo-seed/psm.csv | mongoimport --host mongodb --type csv -d cromixdb -c psm --drop --fieldFile /mongo-seed/psmHeaderFields.txt --columnsHaveTypes
