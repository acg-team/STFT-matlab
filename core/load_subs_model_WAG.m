function [Q,Pi]=load_subs_model_WAG(mu)

Q=[...
-1.1171505893792935 0.0254545953029923 0.0209164644872614 0.0442435699225250 0.0208117549246523 0.0350234393329983 0.0964488640691284 0.1237844839268123 0.0081270207162304 0.0098341360886520 0.0360024015511351 0.0589977895257366 0.0182884081755220 0.0084902431868165 0.0690923396887679 0.2459330492527380 0.1358225841174793 0.0017081062979209 0.0089122007857295 0.1492591380261954 0.0000000000000000 
0.0501473241255364 -0.9743179239475008 0.0260650077005766 0.0088190425736844 0.0107031679831428 0.1170084570902824 0.0267594489673729 0.0510845158500407 0.0547986847419238 0.0095108331741281 0.0450280868586380 0.3483770760470917 0.0139832136976617 0.0041428324225921 0.0326352819177514 0.0893169789766522 0.0355011321092843 0.0175731137888684 0.0141246545055007 0.0187390714167722 0.0000000000000000 
0.0463539832782298 0.0293207498352432 -1.4524376491953594 0.3250576096400202 0.0053751001560733 0.0595022021752079 0.0577162530552802 0.0983446720090510 0.1014432718609483 0.0281916479128461 0.0119003402013437 0.1960816450259185 0.0040572610923386 0.0038786835461104 0.0093695754188763 0.2899600693996686 0.1299923130405920 0.0010858137607567 0.0402045820229805 0.0146018757638739 0.0000000000000000 
0.0671876734529610 0.0067979710799008 0.2227414261043036 -0.9896644389625309 0.0006138904368543 0.0237749389522371 0.3762142455577281 0.0756295307014130 0.0238634727187491 0.0020059938703709 0.0076729272905609 0.0312385276854699 0.0021236754298207 0.0018848635125809 0.0203635928890915 0.0781956766417114 0.0240040680670889 0.0019592499974569 0.0120580797562495 0.0113346348179822 0.0000000000000000 
0.0933756629153652 0.0243756255272355 0.0108821015362089 0.0018137458104703 -0.4873567859031621 0.0038091022934943 0.0013010557826730 0.0267953320513378 0.0063838935673988 0.0086540499311703 0.0347693725667066 0.0048196018272464 0.0079925306897783 0.0160540756183867 0.0052545815795836 0.1027029616532353 0.0328482787271386 0.0108264766518179 0.0201331293326920 0.0745652078412228 0.0000000000000000 
0.0826072407828078 0.1400860887215482 0.0633276804873536 0.0369265976193775 0.0020024282569022 -1.3797851247273658 0.3332748956377268 0.0288379612689962 0.1101053178939907 0.0057944773621484 0.0786692940007160 0.2535577236501372 0.0316289559408292 0.0040302901337865 0.0448290676583954 0.0750664195588169 0.0549363295381856 0.0032572434956604 0.0084300049470100 0.0224171077729773 0.0000000000000000 
0.1439083853068875 0.0202667720193342 0.0388587055934417 0.3696449512351277 0.0004326731102500 0.2108299277883666 -1.2368935123022988 0.0496037014099314 0.0146160167840419 0.0064800463807061 0.0139573488571246 0.1682462162656613 0.0064500751406869 0.0032725234053933 0.0327729334735179 0.0514323935359889 0.0526847115054937 0.0023637311631761 0.0072672928774007 0.0438051064497685 0.0000000000000000 
0.1288043008699331 0.0269818590223634 0.0461759892522516 0.0518222325741326 0.0062143871025109 0.0127224099092610 0.0345930819488476 -0.4976152706739596 0.0063951243298239 0.0015488681682730 0.0055466127790365 0.0243186002545118 0.0035635435003160 0.0020139592224051 0.0116984610739934 0.0978992711347515 0.0144609292488380 0.0050878416075969 0.0038355023166748 0.0139322963584384 0.0000000000000000 
0.0288165892892941 0.0986278980435700 0.1623064114918712 0.0557192694448644 0.0050451240916620 0.1655236981307700 0.0347337168657832 0.0217919476933948 -0.9923423046988145 0.0070291425044137 0.0451901322733072 0.0579670623084647 0.0082721081778359 0.0274023250262273 0.0334378010542844 0.0540027765397280 0.0303076124391907 0.0039643230758380 0.1433978233803808 0.0088065428679341 0.0000000000000000 
0.0175774885006836 0.0086289431009937 0.0227374778592087 0.0023610803642698 0.0034475852197633 0.0043911225189767 0.0077626452526055 0.0026605468363684 0.0035433311861528 -1.2331622149986590 0.2869018138210493 0.0210814410549876 0.0871432734684408 0.0427335598598366 0.0047994957382718 0.0233063623819029 0.0933714231024056 0.0032081139057668 0.0155550269139924 0.5819514839129826 0.0000000000000000 
0.0361773415923114 0.0229671500115769 0.0053959233753600 0.0050772298087529 0.0077871230572615 0.0335159170966801 0.0093998111747139 0.0053563490790729 0.0128067101881341 0.1612938708099036 -0.7260110141276797 0.0167668128872914 0.0993538852464336 0.0853150573482312 0.0199726355743881 0.0251521790044291 0.0209148248179582 0.0100449779725052 0.0147571547668844 0.1339560603157914 0.0000000000000000 
0.0823951308147622 0.2469640905637515 0.1235674165639099 0.0287287627912027 0.0015002097122957 0.1501354766993710 0.1574788121212860 0.0326392542257695 0.0228315759081584 0.0164719681271386 0.0233029630235166 -1.1245803015461167 0.0191231083704840 0.0035831864269007 0.0267472438242092 0.0705618652968000 0.0888135022319736 0.0020760799810454 0.0049335390595861 0.0227261158039556 0.0000000000000000 
0.0812342083192739 0.0315274230087927 0.0081319971974578 0.0062117182370475 0.0079126574295919 0.0595646478021182 0.0192016627228860 0.0152118122505915 0.0103625834640927 0.2165590350013819 0.4391801695770222 0.0608213037102251 -1.3220983469410856 0.0480238783315405 0.0082287869497320 0.0360353396951971 0.0970828180679893 0.0077862397927711 0.0158610778160034 0.1531609875673710 0.0000000000000000 
0.0191375377684480 0.0047400369819400 0.0039450407762127 0.0027977338503048 0.0080654061137931 0.0038516154304815 0.0049437865195680 0.0043626708643555 0.0174197586747797 0.0538907707442734 0.1913755442466718 0.0057832175250157 0.0243702573106335 -0.7136693977575119 0.0077540187610535 0.0398311599095751 0.0110075902134010 0.0230948327857625 0.2389425687470372 0.0483558505342048 0.0000000000000000 
0.1307890246600897 0.0313579167647228 0.0080031790036235 0.0253837841916106 0.0022169430945013 0.0359783948645268 0.0415783963369177 0.0212816835719505 0.0178512199517852 0.0050829566212827 0.0376245747725776 0.0362538915170779 0.0035068256425367 0.0065118189642099 -0.6055894601500736 0.1177050097153656 0.0509314039562763 0.0021047665885432 0.0079981944085975 0.0234294755238780 0.0000000000000000 
0.3064629915081046 0.0564954666289020 0.1630423982426311 0.0641659226414217 0.0285245705495755 0.0396595260242065 0.0429545224045407 0.1172401718213022 0.0189786808070304 0.0162485656097395 0.0311911637116891 0.0629600968635285 0.0101094310885904 0.0220200431044206 0.0774844737917316 -1.3922388212520544 0.2803409487098767 0.0079075690442724 0.0291351055432887 0.0173171731572020 0.0000000000000000 
0.1928455097819074 0.0255857515092669 0.0832830135589626 0.0224431055058028 0.0103950160541633 0.0330702788913035 0.0501340933416536 0.0197319310510502 0.0121360695688865 0.0741704496290312 0.0295519806979753 0.0902923031523961 0.0310325075916092 0.0069336811241333 0.0382016207368607 0.3194206130579099 -1.1549729160548474 0.0016738484492827 0.0107785300615347 0.1032926122911178 0.0000000000000000 
0.0102857423981578 0.0537140505303194 0.0029503756052609 0.0077691080870805 0.0145305782674681 0.0083159458103397 0.0095395930202297 0.0294435504172377 0.0067325343817711 0.0108081140948356 0.0601955738627198 0.0089515660968220 0.0105556620584376 0.0616977946558189 0.0066955042329517 0.0382122490815884 0.0070990353944870 -0.4666937267559051 0.0920111106022978 0.0271856381580815 0.0000000000000000 
0.0218869666341432 0.0176074668714210 0.0445530441095501 0.0195002116420282 0.0110201346743442 0.0087774652492269 0.0119614627812883 0.0090522952120062 0.0993189141739032 0.0213722758960814 0.0360660073169153 0.0086754772868397 0.0087694077348932 0.2603323933024494 0.0103765066354312 0.0574190585087057 0.0186432922953717 0.0375249512678841 -0.7262751253776507 0.0234177937851678 0.0000000000000000 
0.1823809331329370 0.0116226458107176 0.0080509730150302 0.0091202469074989 0.0203071857767867 0.0116133832846705 0.0358735421500976 0.0163605181417950 0.0030348186737873 0.3978365458410199 0.1628904756256249 0.0198837325131213 0.0421331195762525 0.0262132940851831 0.0151237562598290 0.0169806519985027 0.0888935443939297 0.0055164195236142 0.0116515544199748 -1.0854873411303729 0.0000000000000000 
0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 0.0000000000000000 -0.0000000000000000 
];
%%
for i=1:20
   Q(i,i)=Q(i,i)-mu;
   Q(i,end)=mu;
   %Pi(i)=1/20;
end
%%
Pi=zeros(21,1);
Pi(1) =  0.086627899999999994;
Pi(2) =  0.043971999999999997;
Pi(3) =  0.039089400000000003;
Pi(4) =  0.057045100000000001;
Pi(5) =  0.0193078;
Pi(6) =  0.0367281;
Pi(7) =  0.058058899999999997;
Pi(8) =  0.083251800000000001;
Pi(9) =  0.0244313;
Pi(10) =  0.048466000000000002;
Pi(11) =  0.086208999999999994;
Pi(12) =  0.062028600000000003;
Pi(13) =  0.019502700000000001;
Pi(14) =  0.038431899999999998;
Pi(15) =  0.045763199999999997;
Pi(16) =  0.069517899999999994;
Pi(17) =  0.061012700000000003;
Pi(18) =  0.0143859;
Pi(19) =  0.035274199999999999;
Pi(20) =  0.070895600000000003;
Pi(21) =  0;