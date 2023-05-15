#!/bin/bash
#
# script to create upper grid metal for cell extraction
#
lib=vx

export GRAAL_TECHNO_NAME=../../../alliance/etc/s100.graal
export MBK_CATA_LIB=.
export MBK_TARGET_LIB=.
export DREAL_TECHNO_NAME=../../../alliance/etc/s100.dreal
export RDS_TECHNO_NAME=../../../alliance/etc/vx200.rds
RDS_IN=cif
RDS_OUT=cif
rm -f vugrid.cif
s2r vugrid >/dev/null
../../../alliance/bin/vx_add_ab vugrid

echo
echo "# Read ${lib}lib200 CIF into Magic"
magic -T../../../magic/etc/pharosc -dnull -noconsole <<EOF >/dev/null 2>&1
;cif istyle pharosc200(1um-${lib}lib)
;cif read vugrid.cif
;load vugrid
;drc catchup
;save
;quit
EOF

echo "# Write ${lib}lib013 CIF file from Magic"
magic -T../../../magic/etc/pharosc -dnull -noconsole <<EOF >/dev/null 2>&1
;load vugrid
;cif ostyle pharosc013(55nm-${lib}lib)
;cif write vugrid
;quit
EOF
cp vugrid.cif vugrid.cif_013

