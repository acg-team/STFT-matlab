function [volume,polarity,composition]=load_volume_polarity()

volume = [
    31.0  %* A *% ALA
    124.0 %* R *% ARG
    56.0  %* N *% ASN
    54.0  %* D *% ASP
    55.0  %* C *% CYS
    85.0  %* Q *% GLN
    83.0  %* E *% GLU
    3.0   %* G *% GLY
    96.0  %* H *% HIS
    111.0 %* I *% ILE
    111.0 %* L *% LEU
    119.0 %* K *% LYS
    105.0 %* M *% MET
    132.0 %* F *% PHE
    32.5  %* P *% PRO
    32.0  %* S *% SER
    61.0  %* T *% THR
    170.0 %* W *% TRP
    136.0 %* Y *% TYR
    84.0  %* V *% VAL
    0.0   %-
    ];

polarity=[
    8.1   %* A *% ALA
    10.5  %* R *% ARG
    11.6  %* N *% ASN
    13.0  %* D *% ASP
    5.5   %* C *% CYS
    10.5  %* Q *% GLN
    12.3  %* E *% GLU
    9.0   %* G *% GLY
    10.4  %* H *% HIS
    5.2   %* I *% ILE
    4.9   %* L *% LEU
    11.3  %* K *% LYS
    5.7   %* M *% MET
    5.2   %* F *% PHE
    8.0   %* P *% PRO
    9.2   %* S *% SER
    8.6   %* T *% THR
    5.4   %* W *% TRP
    6.2   %* Y *% TYR
    5.9   %* V *% VAL
    0.0   %-
    ];


composition=[
   0.00   %* A *% ALA
   0.65   %* R *% ARG
   1.33   %* N *% ASN
   1.38   %* D *% ASP
   2.75   %* C *% CYS
   0.89   %* Q *% GLN
   0.92   %* E *% GLU
   0.74   %* G *% GLY
   0.58   %* H *% HIS
   0.00   %* I *% ILE
   0.00   %* L *% LEU
   0.33   %* K *% LYS
   0.00   %* M *% MET
   0.00   %* F *% PHE
   0.39   %* P *% PRO
   1.42   %* S *% SER
   0.71   %* T *% THR
   0.13   %* W *% TRP
   0.20   %* Y *% TYR
   0.00   %* V *% VAL
   0.00   %-
    ];