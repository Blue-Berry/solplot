type t

(** Calculate the orbit of a body, where:
[a] = Semi-major axis (AU)
[e] = Eccentricity 
[i] = Inclination (degrees)
[omega2] = Longitude of ascending node (degrees)
[omega] = Argument of periapsis (degrees)
 *)
val compute_orbit
  :  a:float
  -> e:float
  -> i_deg:float
  -> omega2_deg:float
  -> omega_deg:float
  -> num_points:int
  -> t

val compute_orbit_section
  :  a:float
  -> e:float
  -> i_deg:float
  -> omega2_deg:float
  -> omega_deg:float
  -> num_points:int
  -> start_rad:float
  -> stop_rad:float
  -> t

val to_gnuplot : t -> Gnuplot.Series.t
val to_floatarrays : t -> floatarray * floatarray * floatarray
