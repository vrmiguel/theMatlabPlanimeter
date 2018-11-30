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

grayImage = rgb2gray(grayImage);
[linhas, colunas, numeroDeCanaisDeCores] = size(grayImage);
imshow(grayImage, []);
axis on;
title('Imagem Original em Grayscale', 'fontSize', tamanhoDeFonte);
set(gcf, 'Position', get(0,'Screensize')); % Maximiza figura
message = sprintf('Aperte o botao esquerdo e segure para desenhar.\nLevante o botao do mouse para parar');
uiwait(msgbox(message));
hFH = imfreehand(); % Chama a funcao para o desenho na tela
binaryImage = hFH.createMask(); % Cria uma mascara de hFH
areaEmPixel = bwarea(binaryImage);
xy = hFH.getPosition;
% Diminuir exibição para mostrar mais imagens
subplot(2, 2, 1);
imshow(grayImage, []);
axis on;
drawnow;
title('Imagem Original em Grayscale', 'fontSize', tamanhoDeFonte);

% Mostrar a máscara de desenho a mão
subplot(2, 2, 2);
imshow(binaryImage);
axis on;
title('Mascara binaria da regiao', 'fontSize', tamanhoDeFonte);

% Se for em tons de cinza, faça ser colorido
if numeroDeCanaisDeCores < 3
	rgbImage = cat(3, grayImage, grayImage, grayImage);
else
	% Se entrou aqui é pq já é colorido.
	rgbImage = grayImage;
end
% Extrair os canais individuais de cores (verde, vermelho e azul).
canalVermelho = rgbImage(:, :, 1);
canalVerde = rgbImage(:, :, 2);
canalAzul = rgbImage(:, :, 3);

% Especificar a cor que queremos nessa área
corDesejada = [146, 40, 146]; % RGB para roxo!
% Fazer o canal vermelho ser essa cor
canalVermelho(binaryImage) = corDesejada(1);
canalVerde(binaryImage) = corDesejada(2);
canalAzul(binaryImage) = corDesejada(3);
% Recombina os diferentes canais de cores em uma unica imagem colorida
rgbImage = cat(3, canalVermelho, canalVerde, canalAzul);
% Mostra a imagem
subplot(2, 2, 3);
imshow(rgbImage);
title('Imagem com Regiao Colorida', 'fontSize', tamanhoDeFonte);

message = sprintf('Area da Região em Pixels: %0.5f m²', areaEmPixel);
uiwait(msgbox(message));

pause(3); %Pausa a execução do programa por três segundos para que o usuário veja os três painéis

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

