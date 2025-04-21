# DE1_semester_project
# Členové týmu

    David Dobiáš - vedoucí týmu, hlavní programátor
    Tomáš Pokorný - pomocný programátor, poster maker
    Tomáš Rosa - pomocný programátor, video maker

# Shrnutí projektu

Naším úkolem bylo implementovat herní časovač pro námi zvolený sport, společně s počítadlem průběžnéhho skóre. Pro náš projekt jsme si vybrali časovač určený pro hokej. Délka hokejového zápasu je rozdělana do tří třetin, přičemž každá třetina trvá dvacet minut, vytvořili jsme tedy časovač, který odpočítává vždy dvacet minut. Defaultní hodnota časovače je dvacet minut a časovač odčítá směrem dolů do té doby, než se dostane na čas nula. Během hry (zaplého časovače) lze časovač pozastavovat a opětovně pouštět na přerušení hry a zároveň lze přidávat body jednotlivým týmům. Po uplynutí jedné třetiny lze čas opět vyresetovat na defaultní hodnotu a pokračovat novou třetinou. Zároveň je zde pomocí LED diod zobrazena indikace aktuální herní situace, tedy zda se zrovna hraje, nebo zda je hra přerušena, nebo zda skončila daná třetina. Implementace probíhala ve vývojovém prostředí Vivado pro desku Nexys A7-50T.

[Photo(s) of your application with labels of individual parts.]

[Link to A3 project poster.]



![Diagram_komplet drawio](https://github.com/user-attachments/assets/4d97586e-29f8-4288-bed1-b91037cf96ca)




[Optional: Link to your short video presentation.]
# Popis Hardwaru naší implemantace

Describe your implementation. Put a descriptive top-level schematic of your application.
# Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in src and sim folders.
# Component(s) simulations

Write descriptive text and put simulation screenshots of components you created during the project.
# References

    Put here the references and online tools you used.
    ...
