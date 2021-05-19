function [s, err_mse, iter_time]=hard_l0_Mterm(x,A,m,M, varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Default values and initialisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



[n1 n2]=size(x);
if n2 == 1
    n=n1;
elseif n1 == 1
    x=x';
    n=n2;
else
   error('x must be a vector.');
end
    
sigsize     = x'*x/n;
oldERR      = sigsize;
err_mse     = [];
iter_time   = [];
STOPTOL     = 1e-16;
MAXITER     = n^2;
verbose     = false;
initial_given=0;
s_initial   = zeros(m,1);
MU          = 0;

if verbose
   display('Initialising...') 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Output variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch nargout 
    case 3
        comp_err=true;
        comp_time=true;
    case 2 
        comp_err=true;
        comp_time=false;
    case 1
        comp_err=false;
        comp_time=false;
    case 0
        error('Please assign output variable.')        
    otherwise
        error('Too many output arguments specified')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Look through options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Put option into nice format
Options={};
OS=nargin-4;
c=1;
for i=1:OS
    if isa(varargin{i},'cell')
        CellSize=length(varargin{i});
        ThisCell=varargin{i};
        for j=1:CellSize
            Options{c}=ThisCell{j};
            c=c+1;
        end
    else
        Options{c}=varargin{i};
        c=c+1;
    end
end
OS=length(Options);
if rem(OS,2)
   error('Something is wrong with argument name and argument value pairs.') 
end
for i=1:2:OS
   switch Options{i}
        case {'stopTol'}
            if isa(Options{i+1},'numeric') ; STOPTOL     = Options{i+1};   
            else error('stopTol must be number. Exiting.'); end
        case {'P_trans'} 
            if isa(Options{i+1},'function_handle'); Pt = Options{i+1};   
            else error('P_trans must be function _handle. Exiting.'); end
        case {'maxIter'}
            if isa(Options{i+1},'numeric'); MAXITER     = Options{i+1};             
            else error('maxIter must be a number. Exiting.'); end
        case {'verbose'}
            if isa(Options{i+1},'logical'); verbose     = Options{i+1};   
            else error('verbose must be a logical. Exiting.'); end 
        case {'start_val'}
            if isa(Options{i+1},'numeric') && length(Options{i+1}) == m ;
                s_initial     = Options{i+1};  
                initial_given=1;
            else error('start_val must be a vector of length m. Exiting.'); end
        case {'step_size'}
            if isa(Options{i+1},'numeric') && (Options{i+1}) > 0 ;
                MU     = Options{i+1};   
            else error('Stepsize must be between a positive number. Exiting.'); end
        otherwise
            error('Unrecognised option. Exiting.') 
   end
end

if nargout >=2
    err_mse = zeros(MAXITER,1);
end
if nargout ==3
    iter_time = zeros(MAXITER,1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Make P and Pt functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if          isa(A,'float')      P =@(z) A*z;  Pt =@(z) A'*z;
elseif      isobject(A)         P =@(z) A*z;  Pt =@(z) A'*z;
elseif      isa(A,'function_handle') 
    try
        if          isa(Pt,'function_handle'); P=A;
        else        error('If P is a function handle, Pt also needs to be a function handle. Exiting.'); end
    catch error('If P is a function handle, Pt needs to be specified. Exiting.'); end
else        error('P is of unsupported type. Use matrix, function_handle or object. Exiting.'); end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Do we start from zero or not?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if initial_given ==1;
    
    if length(find(s_initial)) > M
        display('Initial vector has more than M non-zero elements. Keeping only M largest.')
    
    end
    s                   =   s_initial;
    [ssort sortind]     =   sort(abs(s),'descend');
    s(sortind(M+1:end)) =   0;
    Ps                  =   P(s);
    Residual            =   x-Ps;
    oldERR      = Residual'*Residual/n;
else
    s_initial   = zeros(m,1);
    Residual    = x;
    s           = s_initial;
    Ps          = zeros(n,1);
    oldERR      = sigsize;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Random Check to see if dictionary norm is below 1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
        x_test=randn(m,1);
        x_test=x_test/norm(x_test);
        nP=norm(P(x_test));
        if abs(MU*nP)>1;
            display('WARNING! Algorithm likely to become unstable.')
            display('Use smaller step-size or || P ||_2 < 1.')
        end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Main algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if verbose
   display('Main iterations...') 
end
tic
t=0;
done = 0;
iter=1;

while ~done
    
    if MU == 0

        %Calculate optimal step size and do line search
        olds                =   s;
        oldPs               =   Ps;
        IND                 =   s~=0;
        d                   =   Pt(Residual);
        % If the current vector is zero, we take the largest elements in d
        if sum(IND)==0
            [dsort sortdind]    =   sort(abs(d),'descend');
            IND(sortdind(1:M))  =   1;    
         end  

        id                  =   (IND.*d);
        Pd                  =   P(id);
        mu                  =   id'*id/(Pd'*Pd);
        s                   =   olds + mu * d;
        [ssort sortind]     =   sort(abs(s),'descend');
        s(sortind(M+1:end)) =   0;
        Ps                  =   P(s);
        
        % Calculate step-size requirement 
        omega               =   (norm(s-olds)/norm(Ps-oldPs))^2;

        % As long as the support changes and mu > omega, we decrease mu
        while mu > (0.99)*omega && sum(xor(IND,s~=0))~=0 && sum(IND)~=0
%             display(['decreasing mu'])
                    
                    % We use a simple line search, halving mu in each step
                    mu                  =   mu/2;
                    s                   =   olds + mu * d;
                    [ssort sortind]     =   sort(abs(s),'descend');
                    s(sortind(M+1:end)) =   0;
                    Ps                  =   P(s);
                    % Calculate step-size requirement 
                    omega               =   (norm(s-olds)/norm(Ps-oldPs))^2;
        end
        
    else
        % Use fixed step size
        s                   =   s + MU * Pt(Residual);
        [ssort sortind]     =   sort(abs(s),'descend');
        s(sortind(M+1:end)) =   0;
        Ps                  =   P(s);
        
    end
        Residual            =   x-Ps;

        
     ERR=Residual'*Residual/n;
     if comp_err
         err_mse(iter)=ERR;
     end
     
     if comp_time
         iter_time(iter)=toc;
     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Are we done yet?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
         if comp_err && iter >=2
             if ((err_mse(iter-1)-err_mse(iter))/sigsize<STOPTOL);
                 if verbose
                    display(['Stopping. Approximation error changed less than ' num2str(STOPTOL)])
                 end
                done = 1; 
             elseif verbose && toc-t>10
                display(sprintf('Iteration %i. --- %i mse change',iter ,(err_mse(iter-1)-err_mse(iter))/sigsize)) 
                t=toc;
             end
         else
             if ((oldERR - ERR)/sigsize < STOPTOL) && iter >=2;
                 if verbose
                    display(['Stopping. Approximation error changed less than ' num2str(STOPTOL)])
                 end
                done = 1; 
             elseif verbose && toc-t>10
                display(sprintf('Iteration %i. --- %i mse change',iter ,(oldERR - ERR)/sigsize)) 
                t=toc;
             end
         end
         
    % Also stop if residual gets too small or maxIter reached
     if comp_err
         if err_mse(iter)<1e-16
             display('Stopping. Exact signal representation found!')
             done=1;
         end
     elseif iter>1 
         if ERR<1e-16
             display('Stopping. Exact signal representation found!')
             done=1;
         end
     end

     if iter >= MAXITER
         display('Stopping. Maximum number of iterations reached!')
         done = 1; 
     end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    If not done, take another round
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
     if ~done
        iter=iter+1; 
        oldERR=ERR;        
     end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Only return as many elements as iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout >=2
    err_mse = err_mse(1:iter);
end
if nargout ==3
    iter_time = iter_time(1:iter);
end
if verbose
   display('Done') 
end