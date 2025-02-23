open Float

type t = floatarray * floatarray * floatarray

let valid_t (t : t) : bool =
  let open Stdlib.Array.Floatarray in
  let xs, ys, zs = t in
  length xs = length ys && length xs = length zs
;;

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

let compute_orbit_section
      ~a
      ~e
      ~i_deg
      ~omega2_deg
      ~omega_deg
      ~num_points
      ~start_rad
      ~stop_rad
  =
  let i = deg_to_rad i_deg in
  let omega2 = deg_to_rad omega2_deg in
  let omega = deg_to_rad omega_deg in
  let step = (stop_rad -. start_rad) /. Float.of_int num_points in
  let result : floatarray * floatarray * floatarray =
    Stdlib.Array.Floatarray.(create num_points, create num_points, create num_points)
  in
  let rec loop theta n =
    if n < 0
    then ()
    else (
      let r = a *. (1.0 -. (e *. e)) /. (1.0 +. (e *. cos theta)) in
      let x' = r *. cos theta in
      let y' = r *. sin theta in
      let x, y, z = rotate_orbit x' y' omega omega2 i in
      let xs, ys, zs = result in
      let open Stdlib.Array.Floatarray in
      set xs n x;
      set ys n y;
      set zs n z;
      loop (theta +. step) (n - 1))
  in
  loop start_rad (num_points - 1);
  assert (valid_t result);
  result
;;

let compute_orbit ~a ~e ~i_deg ~omega2_deg ~omega_deg ~(num_points : int) : t =
  compute_orbit_section
    ~a
    ~e
    ~i_deg
    ~omega2_deg
    ~omega_deg
    ~num_points
    ~start_rad:0.0
    ~stop_rad:(2.0 *. pi)
;;

(* let to_array (orbit : t) =  *)

(* let to_list (orbit : t) = List.map ~f:(fun (x, y, _) -> x, y) orbit *)

module Gp = Gnuplot

let to_gnuplot orbit =
  assert (valid_t orbit);
  let to_2list (xs, yx, _) =
    let len = Stdlib.Array.Floatarray.length xs in
    let rec loop i acc =
      if i = len
      then acc
      else
        let open Stdlib.Array.Floatarray in
        loop (i + 1) ((get xs i, get yx i) :: acc)
    in
    loop 0 []
  in
  to_2list orbit |> Gp.Series.lines_xy
;;

let to_floatarrays (orbit : t) : floatarray * floatarray * floatarray = orbit
