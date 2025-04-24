#let details = toml(sys.inputs.tomlfile)

#set page(
  header: [
    Gutachten Abschlussarbeit
    #h(1fr)
    #details.name, #details.matrikelnr
  ],
)

#set par(
  justify: true
)

#let format(name, matrikelnr, titel) = [

    = Metadaten
    / Studiengang: Angewandte Informatik (Bachelor) 
    / Titel: #titel
    / Matrikelnummer: #matrikelnr
    / Name: #name
    / Gutachter: Prof. Dr.-Ing. Piotr Wojciech Dabrowski
]

#let getgrade(score) = {
  if score > 94 [1.0] 
  else if score > 89 [1.3] 
  else if score > 84 [1.7] 
  else if score > 79 [2.0] 
  else if score > 74 [2.3] 
  else if score > 69 [2.7] 
  else if score > 64 [3.0] 
  else if score > 59 [3.3] 
  else if score > 54 [3.7] 
  else if score > 49 [4.0] 
  else [5.0]
} 

#let scoretable(
  s01_aufbau,
  s02_einteilung,
  s03_ausgewogenheit,
  s04_bezug,
  s05_tiefe,
  s06_fachsprache,
  s07_kapitellogik,
  s08_hintergruende,
  s09_abgrenzung,
  s10_inititive,
  s11_kreativ,
  s12_grammatik,
  s13_graphiken,
  s14_diskussion,
  s15_quellen
) = [
  #let sumpoints=(s01_aufbau+s02_einteilung+s03_ausgewogenheit+s04_bezug+s05_tiefe+s06_fachsprache+s07_kapitellogik+s08_hintergruende+s09_abgrenzung+
                  s10_inititive+s11_kreativ+s12_grammatik+s13_graphiken+s14_diskussion+s15_quellen)
  = Quantitative Bewertung

    #table(
      columns: (1fr, auto, auto, auto),
      table.header[*Nr.*][*Bereich*][*Max.*][*Erreicht*],
      "01", "Aufbau entsprechend den Anforderungen an eine wissenschaftliche Arbeit", "6", str(s01_aufbau),
      "02", "Kapiteleinteilung nach sachlogischen Gesichtspunkten", "6", str(s02_einteilung),
      "03", "Ausgewogenheit der Kapitelumfänge", "6", str(s03_ausgewogenheit),
      "04", "Bezug zum Thema", "6", str(s04_bezug),
      "05", "Technische Tiefe und Korrektheit", "12", str(s05_tiefe),
      "06", "Beherrschung der Fachsprache, fachliches Verständnis", "10", str(s06_fachsprache),
      "07", "Logischer Aufbau der Kapitel", "6", str(s07_kapitellogik),
      "08", "Verständliche Erklärung der Hintergründe", "10", str(s08_hintergruende),
      "09", "Abgrenzung des Themas, klare Zielstellung", "6", str(s09_abgrenzung),
      "10", "Eigeninitiative/Selbstständigkeit", "10", str(s10_inititive),
      "11", "Einfallsreichtum/Kreativität", "5", str(s11_kreativ),
      "12", "Orthographie und Grammatik", "6", str(s12_grammatik),
      "13", "Verdichtung in Übersichten und Graphiken", "7", str(s13_graphiken),
      "14", "Kritische Auseinandersetzung mit den Ergebnissen in Diskussion/Fazit", "5", str(s14_diskussion),
      "15", "Zitierweise, angebrachte Verwendung von Quellen", "5", str(s15_quellen),
      table.cell(colspan: 2, [Summe]), "100", str(sumpoints)
    )
    Die erreichte Punktzahl von #sumpoints/100 Punkten entspricht einer Note von #getgrade(sumpoints).
]

  

#format(details.name, details.matrikelnr, details.titel)
#scoretable(
  details.s01_aufbau,
  details.s02_einteilung,
  details.s03_ausgewogenheit,
  details.s04_bezug,
  details.s05_tiefe,
  details.s06_fachsprache,
  details.s07_kapitellogik,
  details.s08_hintergruende,
  details.s09_abgrenzung,
  details.s10_inititive,
  details.s11_kreativ,
  details.s12_grammatik,
  details.s13_graphiken,
  details.s14_diskussion,
  details.s15_quellen
)

#let sumpoints=(
  details.s01_aufbau+
  details.s02_einteilung+
  details.s03_ausgewogenheit+
  details.s04_bezug+
  details.s05_tiefe+
  details.s06_fachsprache+
  details.s07_kapitellogik+
  details.s08_hintergruende+
  details.s09_abgrenzung+
  details.s10_inititive+
  details.s11_kreativ+
  details.s12_grammatik+
  details.s13_graphiken+
  details.s14_diskussion+
  details.s15_quellen
)
== Qualitative Bewertung

#details.text

Auf dieser Basis wird für die Arbeit die Note #getgrade(sumpoints) vorgeschlagen.

#grid(
  columns: (3cm, auto),
  rows: (auto),
  "", image("/Documents/HTW/Verwaltung/signature_wojtek.png", width: 3cm)
)
#v(-26pt)
//#datetime(year: 2025, month: 4, day: 2).display("[day].[month repr:numerical].[year]"), Prof. Dr.-Ing. Piotr Wojciech Dabrowski
#datetime.today().display("[day].[month repr:numerical].[year]"), Prof. Dr.-Ing. Piotr Wojciech Dabrowski
