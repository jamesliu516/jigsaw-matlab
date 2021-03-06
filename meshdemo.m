function meshdemo(varargin)
%MESHDEMO build example meshes for JIGSAW.
%
%   MESHDEMO(N) calls the N-TH demo problem. The following 
%   demo problems are currently available:
%
%   - DEMO-1: Build surface meshes for the "stanford-bunny" 
%     geometry. Compare the performance of the "delaunay" & 
%     "delfront" meshing kernals. Show mesh quality metrics.
%
%   - DEMO-2: Build _volume meshes for the "stanford-bunny" 
%     geometry. Compare the performance of the "delaunay" & 
%     "delfront" meshing kernals. Show mesh quality metrics.
%
%   - DEMO-3: Build surface meshes for the "fandisk" domain. 
%     Investigate options designed to detect and preserve 
%     "sharp-features" in the input geometry.
%
%   - DEMO-4: Build planar meshes for the "lake" test-case. 
%     Investigate options designed to preserve "topological" 
%     consistency.
%
%   - DEMO-5: Build planar meshes for the "airfoil" problem. 
%     Investigate the use of user-defined mesh-spacing defi-
%     nitions.
%
%   - DEMO-6: Build surface- and volume-meshes based on an 
%     analytic geometry definition. [iso-surface extraction 
%     (case 1)].
%
%   - DEMO-7: Build surface- and volume-meshes based on an 
%     analytic geometry definition. [iso-surface extraction 
%     (case 2)].
%
%   See also JIGSAW

%-----------------------------------------------------------
%   Darren Engwirda
%   github.com/dengwirda/jigsaw-matlab
%   08-Dec-2017
%   de2363@columbia.edu
%-----------------------------------------------------------
%

    close all ;

    n = 1;

    if (nargin >= 1), n = varargin{1}; end
       
    switch (n)
        case 1, demo1 ;
        case 2, demo2 ;
        case 3, demo3 ;
        case 4, demo4 ;
        case 5, demo5 ;
        case 6, demo6 ;
        case 7, demo7 ;
        
        otherwise
        error('Invalid demo selection!') ;
    end

end

function demo1
% DEMO-1 --- Build surface meshes for the "stanford-bunny" 
%   geometry. Compare the performance of the "delaunay" & 
%   "delfront" meshing kernals. Show mesh quality metrics.

    name = 'bunny' ;

%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
        ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
        ['jigsaw/out/',name,'.jig'];
    
    opts.mesh_file = ...            % output file
        ['jigsaw/out/',name,'.msh'];
  
%-- read GEOM file for display
    geom = loadmsh (opts.geom_file);

%-- draw the output
    drawmesh(geom,...
        struct('title','Input geometry',...
            'flips',[3,1,2],'views',[50,10]));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delaunay';
    opts.mesh_dims = 2 ;
    
    opts.hfun_hmax = 0.03 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (delaunay)', ...
            'flips',[3,1,2],'views',[50,10]));
        
    drawcost(meshcost(mesh)) ;
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    
    opts.hfun_hmax = 0.03 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (delfront)', ...
            'flips',[3,1,2],'views',[50,10]));

    drawcost(meshcost(mesh)) ;
    
    drawnow ;
    
    set(figure(1),'units','normalized', ...
        'position',[.65,.50,.30,.35]) ;
    
    set(figure(2),'units','normalized', ...
        'position',[.05,.50,.30,.35]) ;
    set(figure(4),'units','normalized', ...
        'position',[.35,.50,.30,.35]) ;
    
    set(figure(3),'units','normalized', ...
        'position',[.05,.15,.30,.25]) ;
    set(figure(5),'units','normalized', ...
        'position',[.35,.15,.30,.25]) ;
    
end

function demo2
% DEMO-2 --- Build _volume meshes for the "stanford-bunny" 
%   geometry. Compare the performance of the "delaunay" & 
%   "delfront" meshing kernals. Show mesh quality metrics.

    name = 'bunny' ;

%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
        ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
        ['jigsaw/out/',name,'.jig'];
    
    opts.mesh_file = ...            % output file
        ['jigsaw/out/',name,'.msh'];
  
%-- read GEOM file for display
    geom = loadmsh (opts.geom_file);

%-- draw the output
    drawmesh(geom,...
        struct('title','Input geometry',...
            'flips',[3,1,2],'views',[50,10]));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delaunay';
    opts.mesh_dims = 3 ;
    opts.mesh_vol3 = 0.05 ;
    
    opts.hfun_hmax = 0.03 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (delaunay)',...
            'flips',[3,1,2],'views',[50,10]));
    
    drawcost(meshcost(mesh)) ;
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 3 ;
    opts.mesh_vol3 = 0.05 ;
    
    opts.hfun_hmax = 0.03 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (delfront)',...
            'flips',[3,1,2],'views',[50,10]));

    drawcost(meshcost(mesh)) ;
    
    drawnow ;
    
    set(figure(1),'units','normalized',...
        'position',[.65,.50,.30,.35]) ;
    
    set(figure(2),'units','normalized',...
        'position',[.05,.50,.30,.35]) ;
    set(figure(3),'units','normalized',...
        'position',[.05,.50,.30,.35]) ;
    set(figure(6),'units','normalized',...
        'position',[.35,.50,.30,.35]) ;
    set(figure(7),'units','normalized',...
        'position',[.35,.50,.30,.35]) ;
    
    set(figure(4),'units','normalized',...
        'position',[.05,.15,.30,.25]) ;
    set(figure(5),'units','normalized',...
        'position',[.05,.15,.30,.25]) ;
    set(figure(8),'units','normalized',...
        'position',[.35,.15,.30,.25]) ;
    set(figure(9),'units','normalized',...
        'position',[.35,.15,.30,.25]) ;

end

function demo3
% DEMO-3 --- Build surface meshes for the "fandisk" domain. 
%   Investigate options designed to detect and preserve 
%   "sharp-features" in the input geometry.

    name = 'fandisk' ;

%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
        ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
        ['jigsaw/out/',name,'.jig'];
    
    opts.mesh_file = ...            % output file
        ['jigsaw/out/',name,'.msh'];
  
%-- read GEOM file for display
    geom = loadmsh (opts.geom_file);

%-- draw the output
    drawmesh(geom,...
        struct('title','Input geometry',...
            'flips',[3,2,1],'views',[-40,20]));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    
    opts.geom_feat =false ;
    
    opts.hfun_hmax = 0.03 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (FEAT.=false)',...
            'flips',[3,2,1],'views',[-40,20]));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    
    opts.geom_feat = true ;
    
    opts.hfun_hmax = 0.03 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (FEAT.=true)',...
            'flips',[3,2,1],'views',[-40,20]));
    
    drawnow ;
    
    set(figure(1),'units','normalized',...
        'position',[.65,.50,.30,.35]) ;
    
    set(figure(2),'units','normalized',...
        'position',[.05,.50,.30,.35]) ;
    
    set(figure(3),'units','normalized',...
        'position',[.35,.05,.30,.35]) ;
    set(figure(4),'units','normalized',...
        'position',[.35,.50,.30,.35]) ;
    
end

function demo4
% DEMO-4 --- Build planar meshes for the "lake" test-case. 
%   Investigate options designed to preserve "topological" 
%   consistency.

    name = 'lake' ;

%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
        ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
        ['jigsaw/out/',name,'.jig'];
    
    opts.mesh_file = ...            % output file
        ['jigsaw/out/',name,'.msh'];
  
%-- read GEOM file for display
    geom = loadmsh (opts.geom_file);

%-- draw the output
    drawmesh(geom,...
        struct('title','Input geometry'));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    opts.mesh_top1 =false ;
    
    opts.optm_iter = 0 ;
    
    opts.geom_feat = true ;
    
    opts.hfun_hmax = 0.05 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (TOPO.=false)'));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    opts.mesh_top1 = true ;
    
    opts.optm_iter = 0 ;
    
    opts.geom_feat = true ;
    
    opts.hfun_hmax = 0.05 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output (TOPO.=true)') );
    
    drawnow ;
    
    set(figure(1),'units','normalized',...
        'position',[.65,.50,.30,.35]) ;
    
    set(figure(2),'units','normalized',...
        'position',[.05,.05,.30,.35]) ;
    set(figure(3),'units','normalized',...
        'position',[.05,.50,.30,.35]) ;
    
    set(figure(4),'units','normalized',...
        'position',[.35,.05,.30,.35]) ;
    set(figure(5),'units','normalized',...
        'position',[.35,.50,.30,.35]) ;

end

function demo5
% DEMO-5 --- Build planar meshes for the "airfoil" problem. 
%   Investigate the use of user-defined mesh-spacing defi-
%   nitions.

    name = 'airfoil' ;

%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
        ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
    ['jigsaw/out/',name,'-BACK.jig'] ;
    
    opts.mesh_file = ...            % output file
    ['jigsaw/out/',name,'-BACK.msh'] ;
  
%-- read GEOM file for display
    geom = loadmsh (opts.geom_file);

%-- draw the output
    drawmesh(geom,...
        struct('title','Input geometry'));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    opts.mesh_top1 = true ;
    
    opts.optm_iter = 0 ;
    
    opts.geom_feat = true ;
    
    opts.hfun_hmax = 0.04 ;
    
%-- build the mesh!
    back = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(back,...
        struct('title','JIGSAW output'));
    
    
    fun1 = ...
   +.1 * (back.point.coord(:,1)-.40).^2 + ...
   +2. * (back.point.coord(:,2)-.55).^2 ;
   
    fun2 = ...
   +.7 * (back.point.coord(:,1)-.75).^2 + ...
   +.7 * (back.point.coord(:,2)-.45).^2 ;
    
    hmin = 0.01;
    hmax = 0.10;
    
    back.value = 0.4 * ...
    max(min(min(fun1,fun2),hmax),hmin) ;
    
    
%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
        ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
    ['jigsaw/out/',name,'-MESH.jig'] ;
    
    opts.mesh_file = ...            % output file
    ['jigsaw/out/',name,'-MESH.msh'] ;
    
    opts.hfun_file = ...            % sizing file
    ['jigsaw/out/',name,'-HFUN.msh'] ;
 
    savemsh(opts.hfun_file,back) ;
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 2 ;
    opts.mesh_top1 = true ;
    
    opts.optm_iter = 8 ;
    
    opts.geom_feat = true ;
    
    opts.hfun_scal = 'absolute';
    opts.hfun_hmax = +inf ;
    opts.hfun_hmin = +0.0 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output'));
    
    figure  ;
    patch ('faces',back.tria3.index(:,1:3), ...
        'vertices',back.point.coord(:,1:2), ...
        'facevertexcdata',back.value, ...
        'facecolor','flat', ...
        'edgecolor','k' ) ;
    axis image off ;
    
    drawnow ;
    
    set(figure(1),'units','normalized', ...
        'position',[.65,.50,.30,.35]) ;
    
    set(figure(2),'units','normalized', ...
        'position',[.05,.50,.30,.35]) ;
    set(figure(3),'units','normalized', ...
        'position',[.05,.50,.30,.35]) ;
    
    set(figure(4),'units','normalized', ...
        'position',[.35,.50,.30,.35]) ;
    set(figure(5),'units','normalized', ...
        'position',[.35,.50,.30,.35]) ;
        
    set(figure(6),'units','normalized', ...
        'position',[.05,.05,.30,.35]) ;
        
end

function demo6
% DEMO-6 --- Build surface- and volume-meshes based on an 
%   analytic geometry definition. [iso-surface extraction 
%   (case 1)].

    name = 'eight';

   [y,x,z] = ndgrid(linspace(-.75,+.75,2^7), ...
                    linspace(-.10,+2.1,2^7), ...
                    linspace(-.20,+.20,2^7)) ;
              
    F = (x.*(x-1.).^2.*(x-2.) + y.^2).^2 + z.^2 ;
    
   [f,v] = isosurface(x,y,z,F,.020);
   
    geom.point.coord = [v,zeros(size(v,1),1)];
    geom.tria3.index = [f,zeros(size(f,1),1)];
   
%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
    ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
    ['jigsaw/out/',name,'.jig'];
    
    opts.mesh_file = ...            % output file
    ['jigsaw/out/',name,'.msh'];
 
    
    savemsh(opts.geom_file,geom) ;
    
%-- draw the output
    drawmesh(geom,...
        struct('title','Input surface','views',[-30,+30]));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 3 ;
    
    opts.hfun_hmax = 0.04 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output','views',[-30,+30]));
    
    drawnow ;
    
    set(figure(1),'units','normalized',...
        'position',[.05,.50,.30,.35]) ;
    set(figure(2),'units','normalized',...
        'position',[.35,.50,.30,.35]) ;
    set(figure(3),'units','normalized',...
        'position',[.65,.50,.30,.35]) ;
    
end

function demo7
% DEMO-7 --- Build surface- and volume-meshes based on an 
%   analytic geometry definition. [iso-surface extraction 
%   (case 2)].

    name = 'orbis';

   [y,x,z] = ndgrid(linspace(-6,+6,2^7), ...
                    linspace(-6,+6,2^7), ...
                    linspace(-6,+6,2^7)) ;

    F = - (cos(x).*sin(y) + ...
           cos(y).*sin(z) + ...
           cos(z).*sin(x) ) ...
       .* (cos(x).*sin(y) + ...
           cos(y).*sin(z) + ...
           cos(z).*sin(x) ) ...
        + 0.02 ...
        + exp((x.*x+y.*y+z.*z)-32.0) ;
    
   [f,v] = isosurface(x,y,z,F,.001);
    
    geom.point.coord = [v,zeros(size(v,1),1)];
    geom.tria3.index = [f,zeros(size(f,1),1)];
   
%-- setup files for JIGSAW
    opts.geom_file = ...            % domain file
    ['jigsaw/geo/',name,'.msh'];
    
    opts.jcfg_file = ...            % config file
    ['jigsaw/out/',name,'.jig'];
    
    opts.mesh_file = ...            % output file
    ['jigsaw/out/',name,'.msh'];
 
  
    savemsh(opts.geom_file,geom) ;
    
%-- draw the output
    drawmesh(geom,...
        struct('title','Input surface'));
    
%-- meshing options for JIGSAW
    opts.mesh_kern = 'delfront';
    opts.mesh_dims = 3 ;
    
    opts.mesh_top2 = true ;
    
    opts.hfun_hmax = 0.04 ;
    
%-- build the mesh!
    mesh = jigsaw  (opts) ;
 
%-- draw the output
    drawmesh(mesh,...
        struct('title','JIGSAW output'));
    
    drawnow ;
    
    set(figure(1),'units','normalized',...
        'position',[.05,.50,.30,.35]) ;
    set(figure(2),'units','normalized',...
        'position',[.35,.50,.30,.35]) ;
    set(figure(3),'units','normalized',...
        'position',[.65,.50,.30,.35]) ;
    
end



