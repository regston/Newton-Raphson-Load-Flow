% 计算节点导纳矩阵

function Y = ybusppg(num)

linedata = linedatas(num);
fb = linedata(:,1);
tb = linedata(:,2);
r = linedata(:,3);
x = linedata(:,4);
b = linedata(:,5);              % B/2
a = linedata(:,6);              % Tap setting value
z = r + i*x;                    % z matrix
y = 1./z;
b = i*b;                        % Make B imaginary

nb = max(max(fb),max(tb));      % No. of buses
nl = length(fb);                % No. of branches
Y = zeros(nb,nb);               % 初始化节点导纳矩阵

 % 非对角元
 for k = 1:nl
     Y(fb(k),tb(k)) = Y(fb(k),tb(k)) - y(k)/a(k);
     Y(tb(k),fb(k)) = Y(fb(k),tb(k));
 end

 % 对角元
 for m = 1:nb
     for n = 1:nl
         if fb(n) == m
             Y(m,m) = Y(m,m) + y(n)/(a(n)^2) + b(n);
         elseif tb(n) == m
             Y(m,m) = Y(m,m) + y(n) + b(n);
         end
     end
 end
