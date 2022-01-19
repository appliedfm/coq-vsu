let create_unit_metadata fname package =
  try
    Atdgen_runtime.Util.Json.to_file fname package
  with e ->
    (* Print decent error message and exit *)
    let msg =
      match e with
          Failure s
        | Yojson.Json_error s -> s
        | e -> Printexc.to_string e
    in
    Printf.eprintf "Error: %s\n%!" msg;
    exit 1

let load_unit_metadata fname =
  try
    Some (Atdgen_runtime.Util.Json.from_file Unit_j.read_package fname)
  with e ->
    (* Print decent error message and exit *)
    let msg =
      match e with
          Failure s
        | Yojson.Json_error s -> s
        | e -> Printexc.to_string e
    in
    Printf.eprintf "Error: %s\n%!" msg;
    None
