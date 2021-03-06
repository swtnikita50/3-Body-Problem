%{ 
...
Modified and Updated on 7 Aug 2019 -Karthi 
(last updated : (1) 21:26, 10/8/2019  (2) 16:06 13/08/2019)  
(3) Including Manifolds 14/08/2019 - 15/08/2019 (4) Eigen Value Plot and
others 20/08/2019

A fresh Modification to reduce the number of varibles in workspace is started on 20
Feb,2020


REFERENCES FOR ALGORITHMS(Any one will do as long as you have no doubt)
--------------------------------------------------------------------------
  1) W S koon ,MW Lo, JE Marsden, SD Ross - Dynamical Systems, the Three Body Problem and Space Mission Design 
    (Main refrence for almost everything)
  2) Daniel J Grebow - Generating Periodic Orbits in the circular
     Restricted Three Body Problem With Applications to Lunar South Pole
     Coverage - MS Thesis (2006)(Insights for differential Correction and
     continuation Halo orbits)
  3) Srianish Vutukuri - Spacecraft Trajectory Design Techniques using
     Resonant Orbits (for DC and continuation)
  4) Thomas Pavlak - Mission Design In the Earth Moon System Transfer
     Trajectories and station keeping
  5) TM Vaquero Escribano - Poincare Sections and resonant orbits in the
     Restricted Three Body Problem.



File dependencies (Explicit -E)
  1) GlobalData
  2) LyapOrbitParameters     - will call I(8) and I(1)
  3) Plotter                 - will call I(10),I(11),I(12)
 
 

File dependencies (Implicit - I)
  1) DiffCorrec             - will call E(1) I(3) I(4) I(5)
  2) Integrator             - will call I(5) 
  3) StateTransAndX         - willcall I(6),I(3) and I(3) will call (7)
  4) CRes3BP_EOM
  5) VarEq_Init 
  6) VarEqAndSTMDOT         - will call E(1) I(8) I(5) 
  7) Dfmatrix3D
  8) InitialGuess 
  9) SunPlanetMoonParameters
  10) PlotContourEquilPoints  - will call E(1)
  11) LyapunovPlotter         - Plots the Lyapunov Orbits
  12) plotEqPointManifold     - plots eq.points manifolds

See Function descriptions for more details

****************************************************************
                    Read before proceeding
****************************************************************

NOTE:
-----
1) See the descriptions of each functions inside respective function files(if required).
2) Some figures might be small, try to zoom and see 
3) Eq.Point Manifolds might require different time of integration depending on mu
   value. Change it and see 
4) Except the "LyapunovPlotter" all the plots requires only global
   variables in workspace
5) "LyapunovPlotter" requires saved parameters of the orbits (Changing the
    file name might require you to change the variable name inside the plotter.
    This is made for convience because once the parameters are saved for a
    particular primary and secondary, one can extract and plot the required
    data any number of times without having to worry to run whole script again.
6) ENTER ONLY "UserDat" asked for . This is fully sufficient.
7) To know the flow see the file depencies above(if required).


Description for entering Primary Secondary
-------------------------------------------
1) Primary can be 'Sun' or any of the nine
    Planets('Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus',
    'Neptune' and 'Pluto')
2) Secondary any of nine planets(if primary is sun) or natural satellites for the planets
3) Case does not matter while entering any of these two 
4) Enter as string inside double or single quotes.

Natural Satellites included are 
Jupiter - 'Callisto','Ganymede','Europa' and 'Io'.
Saturn - 'Titan'
Neptune - 'Triton'.
Earth - 'moon'

...
%}

%% --------------------------------- Mainline Program ----------------------------------------------------------------
clearvars;clc;close all
systemparameters;

%% Get the UserData
% ------------------
% The program can handle both 2 and 3 dimension
% Choose the dimension of the problem(3 or 2)
UserDat.Dimension      = 3;% input('Give the problem dimension: ');
% Input the Primary/Secondary
% See the description above before entering Primary and Secondary
UserDat.Primary        = 'earth';%input('Enter the primary body (string input):');
UserDat.Secondary      = 'moon';%input('Enter the secondary body (string input):');

% Input for how many equilibrium points you want the data for ?(Max 3-
% L1,L2,L3)
UserDat.PointLoc       = 2;%input('For how many  equilibrium points do you want orbit parameters? :');
% Enter the number of families
UserDat.NoofFam        = 20;%input('Enter No of Lyapunov orbit families:');
% Check if you want to see correction plot(Enter 0 or 1).
UserDat.CorrectionPlot = 0;%input('Do You want to see correction plot of differential correction?:');

tic
%% Get the GlobalData
% ---------------------


G_varExt                  = GlobalData('ext');
G_varInt                  = GlobalData('int');
fprintf('mu value %f\n',G_varExt.Constants.mu)
%% Perform Differential Correction and Continuation and get all the orbit parameters
% ----------------------------------------------------------------------------------


% Only user data and global variables are required to continue.
[LyapOrbExt]              = LyapOrbitParameters(UserDat,G_varExt);
%[LyapOrbInt]              = LyapOrbitParameters(UserDat,G_varInt);

for i = 1:UserDat.NoofFam
stabilityIdx(i) = abs(LyapOrbExt(1).Eigens(i).S_EigVal(1))+abs(LyapOrbExt(1).Eigens(i).US_EigVal(1));
stabilityIdx(i) = stabilityIdx(i)/2;
end
stabilityIdx = stabilityIdx';
%% Save the parameters in .mat file
% --------------------------------------

fprintf('\n\n')
fprintf('Saving Lyapunov Orbit data...\n')
fprintf('\n')
save LyapOrbExtPar LyapOrbExt % used for plotting (Using the saved file saves time)
%save LyapOrbIntPar LyapOrbInt % used for plotting (Using the saved file saves time)

                  %% ---------------------Plots Section-----------------------------
% Note this "Plotter" uses the saved data internally so that one need not run every time to get
% the plot 

%Plotter(G_varExt,G_varInt);


fprintf('\n\n')
fprintf('Saving Lyapunov Orbit Manifold data...\n')
fprintf('\n')
save XNextIC XNext % used for plotting (Using the saved file saves time)
%PlotInvariantManifolds(G_varInt,G_varInt,LyapOrbInt,40,'int');

toc

fprintf('\n')
fprintf('Simulation completed Succesfully !!!\n')
% takes 21.493200 seconds for earth moon system(for 30- orbits) with i7 - 4 core and 16g Ram ,without
% parallel pool.




%{
...
Log 
----
1) Till lyapunov orbits parameters and all the plots fully completed on 9
   March 2020(Start date was 20 Feb 2020)
2) Equilibrium Orbit manifolds (10 March 2020)
...
%}






























%% Not Required (This is natural Parameter Continuation)
% ================================================================================================
% [XGuess] = InitialGuess(UserDat.PointLoc);
% [Corrected.time,Corrected.InitialX,Corrected.DF] =...
% GrebowContinuation(XGuess(1),UserDat.NoofFam,UserDat.CorrectionPlot);
% =================================================================================================