mex CsharedSketch.c;  % learning from aligned images
mex mexc_Sigmoid.cpp; % sigmoid transformation
mex Ccopy.c; % copy around detect location
mex ClocalNormalize.c
mex mexc_ComputeMAX1.cpp
mex mexc_ComputeSUM2.cpp
mex mexc_ComputeMAX2.cpp
mex mexc_ComputeSUM3.cpp
mex mexc_TemplateAffineTransform.cpp  %分层的关键？
mex mexc_CropInstance.cpp
mex mexc_FakeMAX2.cpp %只计算M2，不计算改变轨迹
