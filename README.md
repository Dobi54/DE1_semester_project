# DE1_semester_project
# Členové týmu

    David Dobiáš - vedoucí týmu, hlavní programátor
    Tomáš Pokorný - pomocný programátor, poster maker
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

![Diagram_Final drawio](https://github.com/user-attachments/assets/187ea8ff-6f10-46ee-aa2e-ab74308ccea0)


# Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in src and sim folders.
# Component(s) simulations


# Test bench - game_timer

začátek času

![image](https://github.com/user-attachments/assets/2b1d12e3-590c-4a23-9931-89833953fc49)


konec času

![image](https://github.com/user-attachments/assets/8cc6134e-7f44-4e99-8ee8-7297b065fa0e)

# Test bench - clock_enable

![image](https://github.com/user-attachments/assets/a5dc51df-c666-4ca1-ad01-afa8176fc6c2)

# Test bench - position_counter

![image](https://github.com/user-attachments/assets/fbb1e923-d7d1-4511-851b-5ef3be76bf25)

# Test bench - score_counter

![image](https://github.com/user-attachments/assets/bd5bb028-3f0f-49eb-b3fe-aa30441edbc4)






Write descriptive text and put simulation screenshots of components you created during the project.
# References

    Put here the references and online tools you used.
    ...
