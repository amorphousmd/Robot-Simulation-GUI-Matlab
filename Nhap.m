% T3Rotate = T30([1:3],[1:3])
% T3Translate = T30([1:3],[4:4])
% T3Rotate4x4 = [0 0 0 0;
%     0 0 0 0;
%     0 0 0 0;
%     0 0 0 1]
% T3Translate4x4 = [1 0 0 0;
%     0 1 0 0;
%     0 0 1 0;
%     0 0 0 1]
% T3Rotate4x4([1:3],[1:3]) = T3Rotate4x4([1:3],[1:3]) + T3Rotate;
% T3Translate4x4([1:3],[4:4]) = T3Translate4x4([1:3],[4:4]) + T3Translate;
% T3Rotate4x4
% T3Translate4x4

% T30 = T1*T2*T3;
% buffer = T30(1, 4);
% T30(1, 4) = T30(2, 4);
% T30(2, 4) = buffer;
% T30
