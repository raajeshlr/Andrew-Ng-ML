clear;
close all;
clc

input_layer_size = 400;
hidden_layer_size = 25;
num_labels = 10;

load('ex4data1.mat');
load('ex4weights.mat');

epsilon = 0.12;

Theta1 = rand(hidden_layer_size,input_layer_size+1)*2*epsilon-epsilon;
Theta2 = rand(num_labels,hidden_layer_size+1)*2*epsilon-epsilon;

nn = [Theta1(:);Theta2(:)];

lambda = 1;
options = optimset('MaxIter',50);

costFunc = @(t) cost(t,input_layer_size,hidden_layer_size,num_labels,X,y,1);

[nn_params,cost] = fmincg(costFunc,nn,options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
                 
                 
                 pred = predict(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
