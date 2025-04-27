# DE1_semester_project
# Členové týmu

    David Dobiáš - vedoucí týmu, hlavní programátor
    Tomáš Pokorný - pomocný programátor, readme maker
    Tomáš Rosa - pomocný programátor, video maker

# Shrnutí projektu

Naším úkolem bylo implementovat herní časovač pro námi zvolený sport, společně s počítadlem průběžnéhho skóre. Pro náš projekt jsme si vybrali časovač určený pro hokej. Délka hokejového zápasu je rozdělana do tří třetin, přičemž každá třetina trvá dvacet minut, vytvořili jsme tedy časovač, který odpočítává vždy dvacet minut. Defaultní hodnota časovače je dvacet minut a časovač odčítá směrem dolů do té doby, než se dostane na čas nula. Během hry (zaplého časovače) lze časovač pozastavovat a opětovně pouštět na přerušení hry a zároveň lze přidávat body jednotlivým týmům. Po uplynutí jedné třetiny lze čas opět vyresetovat na defaultní hodnotu a pokračovat novou třetinou. Zároveň je zde pomocí LED diod zobrazena indikace aktuální herní situace, tedy zda se zrovna hraje, nebo zda je hra přerušena, nebo zda skončila daná třetina. Implementace probíhala ve vývojovém prostředí Vivado pro desku Nexys A7-50T.

# Popis Hardwaru naší implemantace

Použíté vstupy:

    CLK100MHz - zabudovaný hodinový signál o frekvenci 100 MHz
    BTNC - tlačítko určené pro resetování času
    BTND - tlačítko určené pro resetování skóre
    BTNL -  tlačítko určené pro přidání bodů týmu 1
    BTNR - tlačítko určené pro přidání bodů týmu 2
    SW(0) - přepínač určený pro stopování a pouštění času

Použité výstupy:

    CA, CB, CC, CD, CE, CF, CG - výstupy určené pro spínání jednotlivých segmentý sedmisegmentového LED displeje
    DP - výstup určený pro vypnití desetinné tečky segmisegmentového displeje
    AN (7 downto 0) - výstupy určené pro spínání jednotlivých pozic sedmisegmentového displeje
    LED17_R - RGB LED pro signalizaci konce třetiny (červená barva)
    LED17_G - RGB LED pro signalizaci probíhající hry (zelená barva)
    LED17_B - RGB LED pro signalizaci pozastavené hry (modrá barva)

    
![Diagram_Final drawio](https://github.com/user-attachments/assets/cb55c96e-043b-4845-b9bf-1b584d4af58c)


# Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in src and sim folders.


# Test bench - game_timer

•    Tato komponenta, má za úkol odpočítávat čas 20:00 směrem dolů až do času 00:00. Spínačem 'start_stop' ovládáme, jestli čas běží (log.1), nebo je zastavený (log.0). Pokud je 'start_stop' v log.1 a zároveň na signálu 'en' je vzestupná hrana, timer se spustí a čas běží. Stiskem tlačítka 'reset' přivedeme stav do defaultního času 20:00.

•    Pokud čas běží, bude svítit zelená dioda. ('time_run v log.1')

•    Pokud je čas zastavený, bude svítit modrá dioda. ('time_puse v log.1')

•    Pokud čas vypršel (00:00), bude svítit červená dioda. ('time_end v log.1')

start time

![image](https://github.com/user-attachments/assets/2b1d12e3-590c-4a23-9931-89833953fc49)


end time

![image](https://github.com/user-attachments/assets/8cc6134e-7f44-4e99-8ee8-7297b065fa0e)

# Test bench - clock_enable

•    V této komponentě vytváříme z hlavního hodinového signálu 'clk', který má frekvenci 100MHz další dva pulzy.

•    První signál 'clk1Hz' vytvoří impulz jednou za sekundu a používáme ho pro počítání času.

•    Druhý signál 'clk2000Hz' slouží k rychlému přepínání mezi číslicemi na 7-segmentových displejích.

clk1Hz

![image](https://github.com/user-attachments/assets/a5dc51df-c666-4ca1-ad01-afa8176fc6c2)

clk2000Hz

![image](https://github.com/user-attachments/assets/04c009b0-687f-4153-8ea1-8267460569d4)


# Test bench - position_counter

•    Tato komponenta počítá pozice na displejích a říká, který se má zrovna rozsvítit. V jeden okamžik svítí pouze jeden displej, ale protože se pozice střídají velmi rychle, lidské oko tyto změny není schopné zaznamenat a vidí je, jakoby svítily všechny zároveň.

•    Počítá opět jako v předchozí komponentě pouze tehdy, kdy 'en' je v náběžné hraně.

•    Signál 'rst' slouží k nastavení do výchozí hodnoty a počítání znovu od hodnoty 7.

![image](https://github.com/user-attachments/assets/fbb1e923-d7d1-4511-851b-5ef3be76bf25)

# Test bench - score_counter

•    Tato komponenta počítá skóre obou týmů. Pokud stiskneme tlačítko 'BTNL' přijde impulz 'pointup_team1' a přičte se 1. Takto můžeme počítat až do cifry 99. Identicky to probíhá pro druhý tým s tlačítkem 'BTNR' s impulzem 'pointup_team2'.

•    Tlačítkem 'BTND' resetujeme skóre (00:00) a přičítání bodů může probíhat od začátku.

![image](https://github.com/user-attachments/assets/bd5bb028-3f0f-49eb-b3fe-aa30441edbc4)

# Test bench - bin2seg

•    Komponenta 'bin2seg' řídí zobrazování číslic na osmi 7-segmentových displejích a podle signálu 'position' přepíná aktuální pozici (0-7) a vybere správnou číslici. Zobrazujeme na čtyřech displejích čas a na dalších čtyřech skóre.

•    Dále musí převést vstupní signály z binárního čísla (4 bity) na BCD kód (7 bitů).

•    Signál 'an' řídí anody diod, které budou zapnuté.

•    Signál 'seg' řídí to, jaké číslo bude zobrazené (0-9).

signal anods

![image](https://github.com/user-attachments/assets/06ac7403-d577-4ee3-9759-d6fe19150125)

signal display

![image](https://github.com/user-attachments/assets/14581442-afed-4af6-96d1-129429118d39)





# References

    Put here the references and online tools you used.
    ...
