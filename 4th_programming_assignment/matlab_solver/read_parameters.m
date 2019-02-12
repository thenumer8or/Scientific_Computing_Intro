function [problem, infile, outfile, xlength, ...
  ylength, imax, jmax, t_end, delt, tau, delx, dely, del_vec, del_trace, ...
  del_streak, del_inj, vecfile, tracefile, streakfile, n, pos1x, pos1y, ...
  pos2x, pos2y, itermax, eps, omega, gamma, p_bound, re, pr, beta, gx,...
  gy, ui, vi, ti, ww, we, wn, ws ]= read_parameters (inputfile)

!*******************************************************************************
!
!! READ_PARAMETERS reads parameter data and returns to main program
!
!  Reference:
!
!    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
!    Numerical Simulation in Fluid Dynamics,
!    SIAM, 1998.
!
!  Parameters:
!
!    Output, character ( len = * ) PROBLEM, indicates the problem.
!
!    Output, character ( len = * ) INPUTFILE, ?
! 
!    Output, character ( len = * ) INFILE, ?
!
!    Output, character ( len = * ) OUTFILE, ?
!
!    Output, real XLENGTH, YLENGTH, the width and height of the region.
!
!    Output, integer IMAX, JMAX, the index of the last computational
!    row and column of the grid.
!
!    Output, real T_END, the final time.
!
!    Output, real DELT, the time step.
!
!    Output, real TAU, the safety factor for time step control.
!
!    Output, real DELX, DELY, the width and height of one cell.
!
!    Output, real DEL_VEC, ?
!
!    Output, real DEL_TRACE, ?
!
!    Output, real DEL_STREAK, ?
!
!    Output, real DEL_INJ, ?
!    
!    Output, character ( len = * ) VECFILE, ?
!
!    Output, character ( len = * ) TRACEFILE, ?
!
!    Output, character ( len = * ) STREAKFILE, ?
!
!    Output, integer N, ?
!
!    Output, real POS1X, POS1Y, POS2X, POS2Y, ?
!
!    Output, integer ITERMAX, the maximum number of pressure iterations.
!
!    Output, real EPS, the stopping tolerance for the pressure iteration.
!
!    Output, real OMEGA, the relaxation parameter for the SOR iteration.
!
!    Output, real GAMMA, the upwind differencing factor.
!
!    Output, real P_BOUND, the boundary condition type for pressure.
!
!    Output, real RE, the Reynolds number.
!
!    Output, real PR, the Prandtl number.
!
!    Output, real BETA, coefficient of thermal expansion.
!
!    Output, real GX, GY, the X and Y components of a volume force.
!
!    Output, real UI, VI, TI, scalars that may be used to initialize 
!    the flow and temperature.
!
!    Output, integer WW, WE, WN, WS, specify the boundary condition
!    to be applied on the west, east, north and south walls.
!    1 = slip
!    2 = no-slip                             
!    3 = outflow
!    4 = periodic  
!
!  Read the data.
!
  read (5,*) problem
  read (5,'(1a1)') 

  read (5,*) infile
  read (5,*) outfile
  read (5,'(1a1)') 

  read (5,*) xlength
  read (5,*) ylength
  read (5,*) imax
  read (5,*) jmax

  delx = xlength / imax
  dely = ylength / jmax

  read (5,'(1a1)') 

  read (5,*) t_end
  read (5,*) delt
  read (5,*) tau
  read (5,'(1a1)') 

  read (5,*) del_trace
  read (5,*) del_inj
  read (5,*) del_streak
  read (5,*) del_vec
  read (5,'(1a1)') 
  
  read (5,*) vecfile
  read (5,*) tracefile
  read (5,*) streakfile
  read (5,'(1a1)') 

  read (5,*) n
  read (5,*) pos1x
  read (5,*) pos1y
  read (5,*) pos2x
  read (5,*) pos2y
  read (5,'(1a1)') 

  read (5,*) itermax
  read (5,*) eps 
  read (5,*) omega
  read (5,*) gamma
  read (5,*) p_bound
  read (5,'(1a1)') 
  read (5,'(1a1)') 
  read (5,'(1a1)') 

  read (5,*) re
  read (5,*) pr
  read (5,*) beta
  read (5,*) gx
  read (5,*) gy
  read (5,*) ui
  read (5,*) vi
  read (5,*) ti
  read (5,'(1a1)') 

  read (5,*) ww
  read (5,*) we
  read (5,*) wn
  read (5,*) ws
!
!  Print the data.
!
  write (6,*) " problem: ", problem

  write (6,*) " xlength = ", xlength
  write (6,*) " ylength = ", ylength

  write (6,*) " imax = ", imax
  write (6,*) " jmax = ", jmax

  write (6,*) " delx = ", delx
  write (6,*) " dely = ", dely

  write (6,*) " delt = ", delt
  write (6,*) " t_end = ", t_end
  write (6,*) " tau = ", tau

  write (6,*) " del_trace = ", del_trace
  write (6,*) " del_inj = ", del_inj
  write (6,*) " del_streak = ", del_streak
  write (6,*) " del_vec = ", del_vec

  write (6,*) " vecfile: ", vecfile
  write (6,*) " tracefile: ", tracefile
  write (6,*) " streakfile: ", streakfile
  write (6,*) " infile: ", infile
  write (6,*) " outfile: ", outfile

  write (6,*) " n = ", n
  write (6,*) " pos1x = ", pos1x
  write (6,*) " pos1y = ", pos1y
  write (6,*) " pos2x = ", pos2x
  write (6,*) " pos2y = ", pos2y

  write (6,*) " itermax = ", itermax
  write (6,*) " eps = ", eps
  write (6,*) " omega = ", omega
  write (6,*) " gamma = ", gamma

  if ( p_bound /= 1  .and. p_bound /= 2 ) then
    write (6,*) " p_bound must be 1 or 2"
    stop ' init'
  else
    write (6,*) " p_bound = ", p_bound
  end if

  write (6,*) " re = ", re
  write (6,*) " pr = ", pr
  write (6,*) " beta = ", beta
  write (6,*) " gx = ", gx
  write (6,*) " gy = ", gy
  write (6,*) " ui = ", ui
  write (6,*) " vi = ", vi
  write (6,*) " ti = ", ti
!
!  Perform some simple checks on the data.
!
  if ( ww < 1 .or. 4 < ww ) then
    write (6,*) "ww must be 1,2,3, or 4"
    stop ' ww'
  else
    write (6,*) " ww = ", ww
  end if

  if ( we < 1 .or. 4 < we ) then
    write (6,*) "we must be 1,2,3, or 4"
    stop ' we'
  else
    write (6,*) " we = ", we
  end if

  if ( wn < 1 .or. 4 < wn ) then
    write (6,*) "wn must be 1,2,3, or 4"
    stop ' wn'
  else
    write (6,*) " wn = ", wn
  end if

  if ( ws < 1 .or. 4 < ws ) then
    write (6,*) "ws must be 1,2,3, or 4"
    stop ' ws'
  else
    write (6,*) " ws = ", ws
  end if

  if (((ww == 4).and.(we /= 4)) .or. (ww /= 4).and.(we == 4)) then
    write (6,*) "Periodic boundary conditions need ww=we=4"
    stop ' ww or we'
  end if

  if (((ws == 4).and.(wn /= 4)) .OR. (ws /= 4).and.(wn == 4)) then
    write (6,*) "Periodic boundary conditions need ws=wn=4"
    stop ' wn or ws'
  end if
