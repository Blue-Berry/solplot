open Float

type t = (float * float * float) list

(* Degrees to radians conversion *)
let deg_to_rad deg = deg *. pi /. 180.0

(* Rotation matrices and orbit calculation *)
let rotate_orbit x' y' omega omega2 i =
  let cos_omega = cos omega
  and sin_omega = sin omega in
  let cos_Omega = cos omega2
  and sin_Omega = sin omega2 in
  let cos_i = cos i
  and sin_i = sin i in
  let x =
    (x' *. ((cos_Omega *. cos_omega) -. (sin_Omega *. sin_omega *. cos_i)))
    -. (y' *. ((cos_Omega *. sin_omega) +. (sin_Omega *. cos_omega *. cos_i)))
  in
  let y =
    (x' *. ((sin_Omega *. cos_omega) +. (cos_Omega *. sin_omega *. cos_i)))
    -. (y' *. ((sin_Omega *. sin_omega) -. (cos_Omega *. cos_omega *. cos_i)))
  in
  let z = (x' *. (sin_omega *. sin_i)) +. (y' *. (cos_omega *. sin_i)) in
  x, y, z
;;

(* Generate orbit points *)
let compute_orbit ~a ~e ~i_deg ~omega2_deg ~omega_deg ~num_points =
  let i = deg_to_rad i_deg in
  let omega2 = deg_to_rad omega2_deg in
  let omega = deg_to_rad omega_deg in
  let step = 2.0 *. pi /. float_of_int num_points in
  let rec loop theta acc =
    if theta > 2.0 *. pi
    then List.rev acc
    else (
      let r = a *. (1.0 -. (e *. e)) /. (1.0 +. (e *. cos theta)) in
      let x' = r *. cos theta in
      let y' = r *. sin theta in
      let x, y, z = rotate_orbit x' y' omega omega2 i in
      loop (theta +. step) ((x, y, z) :: acc))
  in
  loop 0.0 []
;;


let compute_orbit_section ~a ~e ~i_deg ~omega2_deg ~omega_deg ~num_points ~start_rad ~stop_rad =
  let i = deg_to_rad i_deg in
  let omega2 = deg_to_rad omega2_deg in
  let omega = deg_to_rad omega_deg in
  let step = (stop_rad -. start_rad) /. float_of_int num_points in
  let rec loop theta acc =
    if theta > stop_rad
    then List.rev acc
    else (
      let r = a *. (1.0 -. (e *. e)) /. (1.0 +. (e *. cos theta)) in
      let x' = r *. cos theta in
      let y' = r *. sin theta in
      let x, y, z = rotate_orbit x' y' omega omega2 i in
      loop (theta +. step) ((x, y, z) :: acc))
  in
  loop start_rad []
;;


module Gp = Gnuplot

let to_gnuplot orbit = List.map (fun (x, y, _) -> x, y) orbit |> Gp.Series.lines_xy
