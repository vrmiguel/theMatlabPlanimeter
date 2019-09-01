% Configurações Iniciais
clc;	% Limpa janela de comando
clear;	% Deleta variáveis armazenadas na memória
close all;	% Fecha janelas de figura, exceto as criadas pelo imtool
imtool close all;	% Fecha as janelas criadas pelo imtool
workspace;	% Assegura que o painel de workspace está sendo mostrado
tamanhoDeFonte = 16;

% Ler imagem (box de seleção)
pastaInicial = pwd %Pasta inicial padrão do Ubuntu, modificar caso rodar em Windows
nomeArquivoPadrao = fullfile(pastaInicial, '*.*')
[nomeArquivoBase, pasta] = uigetfile(nomeArquivoPadrao, 'Selecione uma Imagem')
nomeCompletoArquivo = fullfile(pasta, nomeArquivoBase)
grayImage = imread(nomeCompletoArquivo)
% Final de leitura
imshow(grayImage, []);
axis on;
title('Imagem Original', 'fontSize', tamanhoDeFonte);
set(gcf, 'Position', get(0,'Screensize')); % Maximiza figura
message = sprintf('Aperte o botao esquerdo e segure para desenhar.\nLevante o botao do mouse para parar');
uiwait(msgbox(message));
hFH = imfreehand(); % Chama a funcao para o desenho na tela
xy = hFH.getPosition;
% Diminuir exibição para mostrar mais imagens
imshow(grayImage, []);
axis on;
drawnow;
title('Imagem Original', 'fontSize', tamanhoDeFonte);

xCoordinates = xy(:, 1);
yCoordinates = xy(:, 2);
plot(xCoordinates, yCoordinates, 'ro', 'LineWidth', 2, 'MarkerSize', 10);

%Início do cálculo de área através da fórmula do cadarço (ou fórmula de
%área de Gauss)
tam = size(xy);
n = tam(1);
soma1 = 0;
soma2 = 0;
soma = 0;
for i = 1 : (n-1)
    soma1 = soma1 + (xy(i,1) * xy(i+1,2));
    soma2 = soma2 + (xy(i+1,1) * xy(i,2));
end

soma = soma1 + (xy(n,1) * xy(1,2)) - soma2 - (xy(1,1) * xy(n,2));
areaEmPixel = 1/2 * abs(soma)

message = sprintf('Area da Região em Pixels: %0.5f px²', areaEmPixel);
uiwait(msgbox(message));

close all;	% Fecha janelas de figura, exceto as criadas pelo imtool
imtool close all;	% Fecha as janelas criadas pelo imtool
workspace;	% Assegura que o painel de workspace está sendo mostrado

imshow(grayImage, []);
axis on;
title('Imagem Original em Grayscale', 'fontSize', tamanhoDeFonte);
set(gcf, 'Position', get(0,'Screensize')); % Maximiza figura
message = sprintf('Faça na figura uma reta de comprimento real conhecido. \nAperte o botao esquerdo e segure para desenhar.\nLevante o botao do mouse para parar');
uiwait(msgbox(message));
hFH = imfreehand(); % Chama a funcao para o desenho na tela
xy = hFH.getPosition;
% Diminuir exibição para mostrar mais imagens
imshow(grayImage, []);
axis on;
drawnow;
title('Estimativa de Escala', 'fontSize', tamanhoDeFonte);

% Deletar resto de imfreehand.
delete(hFH);
% Overlay do desenho.
hold on; % Manter imagem e direção do eixo y.
xCoordinates = xy(:, 1);
yCoordinates = xy(:, 2);
plot(xCoordinates, yCoordinates, 'ro', 'LineWidth', 2, 'MarkerSize', 10);
pause(2) %Pausa a execução do programa por 1 segundo.

close all;	% Fecha janelas de figura, exceto as criadas pelo imtool
imtool close all;	% Fecha as janelas criadas pelo imtool

xInicial = xy(1, 1)
yInicial = xy(1, 2)
xFinal = xy(end, 1)
yFinal = xy(end, 2)
 
distanciaEmPixel = ((xFinal - xInicial)^2 + (yFinal - yInicial)^2)^(0.5)

%Leitura de escala pelo usuário
prompt = {'Digite o tamanho real da reta feita anteriormente: (em metros)'};
title = 'Leitura de escala';
dims = [1 35];
definput = {'10'};

answer = inputdlg(prompt,title,dims,definput)
distanciaEmMetro = str2double(cell2mat(answer))

areaEmMetros = (distanciaEmMetro^2)/(distanciaEmPixel^2) * (areaEmPixel)

message = sprintf('Area da Região em Metros: %0.5f m²', areaEmMetros);
uiwait(msgbox(message));

