
%% SCRIPT 1: PINON A CREMALLERA (MCU -> MRU)
clear; clc; close all;

% =====================================================
% PARAMETROS DEL PROTOTIPO
% =====================================================

R_pinion = 0.007;       % Radio del pinon (m)
x_max = 0.0125;         % Desplazamiento maximo (m)

t_final = 2;            % Tiempo de simulacion (s)
dt = 0.05;              % Paso de tiempo (s)
t = 0:dt:t_final;

% =====================================================
% MODELO MATEMATICO
% =====================================================

% x = r*theta
% theta = x/r

theta_max = x_max / R_pinion;

% Velocidad angular constante
omega_pinion = theta_max / t_final;

% Movimiento circular uniforme
theta_pinion = omega_pinion .* t;

% Conversion angular -> lineal
x_cremallera = R_pinion .* theta_pinion;

% Velocidad lineal de la cremallera
v_cremallera = R_pinion * omega_pinion;

% =====================================================
% RESULTADOS
% =====================================================

fprintf('====================================\n');
fprintf('SIMULACION PINON - CREMALLERA\n');
fprintf('====================================\n');

fprintf('Radio del pinon: %.2f mm\n', ...
    R_pinion * 1000);

fprintf('Desplazamiento maximo: %.2f mm\n', ...
    x_max * 1000);

fprintf('Angulo maximo: %.2f grados\n', ...
    rad2deg(theta_max));

fprintf('Velocidad angular: %.4f rad/s\n', ...
    omega_pinion);

fprintf('Velocidad lineal: %.4f m/s\n', ...
    v_cremallera);

fprintf('Tiempo de simulacion: %.2f s\n', ...
    t_final);

% =====================================================
% GRAFICAS
% =====================================================

figure('Name', 'Pinon a Cremallera', ...
       'NumberTitle', 'off');

% Movimiento angular
subplot(2,1,1);

plot(t, rad2deg(theta_pinion), ...
    'b-', 'LineWidth', 2);

xlabel('Tiempo (s)');
ylabel('Angulo (grados)');
title('Movimiento Angular del Pinon (MCU)');

grid on;
xlim([0 t_final]);

% Movimiento lineal
subplot(2,1,2);

plot(t, x_cremallera * 1000, ...
    'r-', 'LineWidth', 2);

xlabel('Tiempo (s)');
ylabel('Desplazamiento (mm)');
title('Desplazamiento Lineal de la Cremallera (MRU)');

grid on;
xlim([0 t_final]);

sgtitle('Conversion de Movimiento Angular a Lineal');
