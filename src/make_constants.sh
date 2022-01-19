#!/usr/bin/env bash

OUT_ML="constants.ml"
OUT_MLI="constants.mli"

cat << EOF > ${OUT_ML}
let opam_switch_base_path : string = "${OPAM_SWITCH_PREFIX}"
let vsu_base_path : string = "${OPAM_SWITCH_PREFIX}/lib/coq-vsu"
let vsu_unit_metadata_path : string = "${OPAM_SWITCH_PREFIX}/lib/coq-vsu/unit-metadata"
let vsu_include_path : string = "${OPAM_SWITCH_PREFIX}/lib/coq-vsu/lib/include"
let coq_library_path : string = "${OPAM_SWITCH_PREFIX}/lib/coq/user-contrib"
let coq_variant_path : string = "${OPAM_SWITCH_PREFIX}/lib/coq-variant"
EOF

cat << EOF > ${OUT_MLI}
val opam_switch_base_path : string
val vsu_base_path : string
val vsu_unit_metadata_path : string
val vsu_include_path : string
val coq_library_path : string
val coq_variant_path : string
EOF
