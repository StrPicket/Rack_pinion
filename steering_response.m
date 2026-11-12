
%% SCRIPT 2: SISTEMA COMPLETO DE DIRECCION
% Movimiento Angular -> Lineal -> Angular

clear; clc; close all;

% =====================================================
% PARAMETROS DEL PROTOTIPO
% =====================================================

R_pinion = 0.007;       % Radio del pinon (m)
x_max = 0.0125;         % Desplazamiento maximo (m)

angulo_max = 40;        % Giro maximo de ruedas (grados)

% =====================================================
% PARAMETROS DE SIMULACION
% =====================================================

t_final = 8;            % Tiempo total (s)
dt = 0.05;              % Paso de tiempo (s)

t = 0:dt:t_final;

frecuencia = 1/t_final;

% =====================================================
% MODELO GEOMETRICO
% =====================================================

% Aproximacion geometrica:
%
% x = L*sin(delta)
%
% Donde:
% x     = desplazamiento de la cremallera
% L     = longitud efectiva del mecanismo
% delta = angulo de las ruedas
%
% Se calcula L utilizando el rango experimental
% aproximado de +/-40 grados.

L_efectiva = x_max / sind(angulo_max);

% =====================================================
% MOVIMIENTO ANGULAR DEL PINON
% =====================================================

theta_max = x_max / R_pinion;

% Entrada sinusoidal
theta_pinion = theta_max .* ...
    sin(2*pi*frecuencia*t);

% =====================================================
% DESPLAZAMIENTO DE LA CREMALLERA
% =====================================================

x_cremallera = R_pinion .* theta_pinion;

% Limitar recorrido fisico
x_cremallera = max(min(x_cremallera, x_max), -x_max);

% =====================================================
% ANGULO DE LAS RUEDAS DELANTERAS
% =====================================================

% Conversion lineal -> angular
angulo_ruedas = asind(x_cremallera ./ L_efectiva);

% =====================================================
% RESULTADOS
% =====================================================

fprintf('====================================\n');
fprintf('SIMULACION SISTEMA DE DIRECCION\n');
fprintf('====================================\n');

fprintf('Radio del pinon: %.2f mm\n', ...
    R_pinion*1000);

fprintf('Recorrido total de cremallera: %.2f mm\n', ...
    2*x_max*1000);

fprintf('Angulo maximo del pinon: %.2f grados\n', ...
    rad2deg(theta_max));

fprintf('Longitud efectiva: %.2f mm\n', ...
    L_efectiva*1000);

fprintf('Angulo maximo de ruedas: %.2f grados\n', ...
    max(angulo_ruedas));

fprintf('Angulo minimo de ruedas: %.2f grados\n', ...
    min(angulo_ruedas));

% =====================================================
% GRAFICAS
% =====================================================

figure('Name', 'Sistema Completo de Direccion', ...
       'NumberTitle', 'off');

% -----------------------------------------------------
% GRAFICA 1: MOVIMIENTO ANGULAR DEL PINON
% -----------------------------------------------------

subplot(3,1,1);

plot(t, rad2deg(theta_pinion), ...
    'b-', 'LineWidth', 2);

xlabel('Tiempo (s)');
ylabel('Angulo (grados)');
title('Movimiento Angular del Pinon');

grid on;
xlim([0 t_final]);
ylim([-110 110]);

% -----------------------------------------------------
% GRAFICA 2: DESPLAZAMIENTO DE LA CREMALLERA
% -----------------------------------------------------

subplot(3,1,2);

plot(t, x_cremallera*1000, ...
    'r-', 'LineWidth', 2);

xlabel('Tiempo (s)');
ylabel('Desplazamiento (mm)');
title('Movimiento Lineal de la Cremallera');

grid on;
xlim([0 t_final]);
ylim([-15 15]);

% -----------------------------------------------------
% GRAFICA 3: ANGULO DE LAS RUEDAS
% -----------------------------------------------------

subplot(3,1,3);

plot(t, angulo_ruedas, ...
    'g-', 'LineWidth', 2);

xlabel('Tiempo (s)');
ylabel('Angulo (grados)');
title('Movimiento Angular de las Ruedas Delanteras');

grid on;
xlim([0 t_final]);
ylim([-45 45]);

sgtitle('Sistema de Direccion: Angular - Lineal - Angular');

% =====================================================
% GRAFICA ADICIONAL: RELACION CREMALLERA - RUEDAS
% =====================================================

figure('Name', 'Relacion Cremallera - Ruedas', ...
       'NumberTitle', 'off');

plot(x_cremallera*1000, angulo_ruedas, ...
    'm-', 'LineWidth', 2);

xlabel('Desplazamiento de Cremallera (mm)');
ylabel('Angulo de las Ruedas (grados)');

title('Relacion entre Desplazamiento y Direccion');

grid on;

% =====================================================
% ANIMACION DEL SISTEMA
% =====================================================

figure('Name', 'Animacion de Direccion', ...
       'NumberTitle', 'off');

for i = 1:length(t)

    clf;

    % Cremallera
    subplot(2,1,1);

    plot([-30 30], [0 0], ...
        'k--', 'LineWidth', 1);

    hold on;

    rectangle( ...
        'Position', ...
        [x_cremallera(i)*1000-12.5, -2, 25, 4], ...
        'FaceColor', [0.2 0.5 0.9]);

    plot(0, 0, 'ko', 'MarkerFaceColor', 'k');

    xlim([-35 35]);
    ylim([-10 10]);

    axis equal;
    grid on;

    title(sprintf( ...
        'Cremallera: %.2f mm', ...
        x_cremallera(i)*1000));

    xlabel('Posicion (mm)');

    % Ruedas delanteras
    subplot(2,1,2);

    delta = deg2rad(angulo_ruedas(i));

    % Posiciones de las ruedas
    rueda_izq = [-15, 0];
    rueda_der = [15, 0];

    % Vector de orientacion de cada rueda
    longitud = 10;

    dx = longitud*sin(delta);
    dy = longitud*cos(delta);

    hold on;

    plot( ...
        [rueda_izq(1)-dx/2, rueda_izq(1)+dx/2], ...
        [rueda_izq(2)-dy/2, rueda_izq(2)+dy/2], ...
        'b-', 'LineWidth', 5);

    plot( ...
        [rueda_der(1)-dx/2, rueda_der(1)+dx/2], ...
        [rueda_der(2)-dy/2, rueda_der(2)+dy/2], ...
        'b-', 'LineWidth', 5);

    plot([-15 15], [0 0], ...
        'k--', 'LineWidth', 1);

    xlim([-30 30]);
    ylim([-15 15]);

    axis equal;
    grid on;

    title(sprintf( ...
        'Angulo de Direccion: %.2f grados', ...
        angulo_ruedas(i)));

    xlabel('Posicion X (mm)');
    ylabel('Posicion Y (mm)');

    sgtitle(sprintf('Tiempo: %.2f s', t(i)));

    drawnow;

    pause(0.02);

end
