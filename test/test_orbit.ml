module To_test = struct
  let orbit = Solplot.Orbit.compute_orbit
  let orbit_section = Solplot.Orbit.compute_orbit_section
end

let test_orbit () =
  Alcotest.(check int)
    "orbit length"
    200
    (let xs, _, _ =
       To_test.orbit
         ~a:1.0
         ~e:0.0
         ~i_deg:0.0
         ~omega2_deg:0.0
         ~omega_deg:0.0
         ~num_points:200
       |> Solplot.Orbit.to_floatarrays
     in
     Stdlib.Array.Floatarray.length xs)
;;

let test_orbit_section () =
  Alcotest.(check int)
    "orbit section length"
    200
    (let xs, _, _ =
       To_test.orbit_section
         ~a:1.0
         ~e:0.0
         ~i_deg:0.0
         ~omega2_deg:0.0
         ~omega_deg:0.0
         ~num_points:200
         ~start_rad:0.0
         ~stop_rad:2.0
       |> Solplot.Orbit.to_floatarrays
     in
     Stdlib.Array.Floatarray.length xs)
;;

let () =
  let open Alcotest in
  run
    "Orbit"
    [ ( "orbit"
      , [ test_case "length" `Quick test_orbit
        ; test_case "section length" `Quick test_orbit_section
        ] )
    ]
;;
