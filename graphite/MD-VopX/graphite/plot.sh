python fort99_reaxfp.py
paste pqeq 99table.txt > all
awk '{ print $1,$2,$3+$7,$4}' all  > eng.dat
