  module Gp = Gnuplot
(* Example usage *)
let () =
  (* let a = 1.0 in      (* Semi-major axis (AU) *) *)
  (* let e = 0.5 in      (* Eccentricity *) *)
  (* let i = 30.0 in     (* Inclination (degrees) *) *)
  (* let omega2 = 45.0 in (* Longitude of ascending node (degrees) *) *)
  (* let omega = 60.0 in (* Argument of periapsis (degrees) *) *)

  (* let points = compute_orbit ~a ~e ~i_deg:i ~omega2_deg:omega2 ~omega_deg:omega ~num_points:200 in *)
  (* List.iter (fun (x, y, z) -> Printf.printf "%f %f %f\n" x y z) points; *)
  let gp = Gp.create () in
  let open Solplot.Orbit in
  Gp.plot_many
  ~output:(Gp.Output.create (`Png_cairo "plot.png")) gp [
    (compute_orbit_section ~a:0.38709927 ~e:0.20563593 ~i_deg:7.00497902 ~omega2_deg:252.25032350 ~omega_deg:77.45779628 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:0.72333566 ~e:0.00677672 ~i_deg:3.39467605 ~omega2_deg:181.97909950 ~omega_deg:131.60246718 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:1.00000261 ~e:0.01671123 ~i_deg:(-0.00001531) ~omega2_deg:100.46457166 ~omega_deg:102.93768193 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:1.52371034 ~e:0.09339410 ~i_deg:1.84969142 ~omega2_deg:(-4.55343205) ~omega_deg:(-23.94362959) ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:5.20288700 ~e:0.04838624 ~i_deg:1.30439695 ~omega2_deg:34.39644051 ~omega_deg:14.72847983 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:9.53667594 ~e:0.05386179 ~i_deg:2.48599187 ~omega2_deg:49.95424423 ~omega_deg:92.59887831 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:19.18916464 ~e:0.04725744 ~i_deg:0.77263783 ~omega2_deg:313.23810451 ~omega_deg:170.95427630 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
    (compute_orbit_section ~a:30.06992276 ~e:0.00859048 ~i_deg:1.77004347 ~omega2_deg:(-55.12002969) ~omega_deg:44.96476227 ~num_points:200 ~start_rad:0.0 ~stop_rad:(Float.pi) |> to_gnuplot);
  ];
  Gp.close gp;


(*                  a              e               I                L            long.peri.      long.node. *)
(*            au, au/Cy     rad, rad/Cy     deg, deg/Cy      deg, deg/Cy      deg, deg/Cy     deg, deg/Cy *)
(* ----------------------------------------------------------------------------------------------------------- *)
(* Mercury   0.38709927      0.20563593      7.00497902      252.25032350     77.45779628     48.33076593 *)
(*           0.00000037      0.00001906     -0.00594749   149472.67411175      0.16047689     -0.12534081 *)
(* Venus     0.72333566      0.00677672      3.39467605      181.97909950    131.60246718     76.67984255 *)
(*           0.00000390     -0.00004107     -0.00078890    58517.81538729      0.00268329     -0.27769418 *)
(* EM Bary   1.00000261      0.01671123     -0.00001531      100.46457166    102.93768193      0.0 *)
(*           0.00000562     -0.00004392     -0.01294668    35999.37244981      0.32327364      0.0 *)
(* Mars      1.52371034      0.09339410      1.84969142       -4.55343205    -23.94362959     49.55953891 *)
(*           0.00001847      0.00007882     -0.00813131    19140.30268499      0.44441088     -0.29257343 *)
(* Jupiter   5.20288700      0.04838624      1.30439695       34.39644051     14.72847983    100.47390909 *)
(*          -0.00011607     -0.00013253     -0.00183714     3034.74612775      0.21252668      0.20469106 *)
(* Saturn    9.53667594      0.05386179      2.48599187       49.95424423     92.59887831    113.66242448 *)
(*          -0.00125060     -0.00050991      0.00193609     1222.49362201     -0.41897216     -0.28867794 *)
(* Uranus   19.18916464      0.04725744      0.77263783      313.23810451    170.95427630     74.01692503 *)
(*          -0.00196176     -0.00004397     -0.00242939      428.48202785      0.40805281      0.04240589 *)
(* Neptune  30.06992276      0.00859048      1.77004347      -55.12002969     44.96476227    131.78422574 *)
(*           0.00026291      0.00005105      0.00035372      218.45945325     -0.32241464     -0.00508664 *)
