{ pkgs, ... }:

{
  services.espanso = {
    enable = true;
    configs = {
      default = {
        toggle_key = "OFF"; 
        backend = "Clipboard";
        key_delay = "5"; 
        auto_restart = "true";
        search_shortcut = "ALT+SPACE";
      };
      contour = {
        filter_title = "Contour";
        paste_shortcut = "CTRL+SHIFT+V";
      };
    };
    matches = {
      mail = {
        matches = [
          {
            trigger = "::zoom"; 
            replace = "https://htw-berlin.zoom.us/my/dabrowskiw";
          } 
          {
            trigger = "::dokp"; 
            replace = "/home/wojtek/Documents/HTW/Studiengang/IKG/Praktikum/Antraege/";
          } 
          {
            trigger = "::lg"; 
            replace = "Liebe Grüße\n-Wojtek";
          } 
          {
            trigger = "::vg"; 
            replace = "Viele Grüße\n-Wojtek Dabrowski";
          } 
          {
            trigger = "::vd"; 
            replace = "Vielen Dank im Voraus\n";
          } 
          {
            trigger = "::bw"; 
            replace = "Best wishes\nWojtek Dabrowski";
          } 
          {
            trigger = "::termin"; 
            replace = "Hallo\n\nvielen Dank! Ich habe gerade eine entsprechende Termineinladung mit zoom-Link verschickt.";
          } 
          {
            trigger = "::sgdh"; 
            replace = "Sehr geehrte Damen und Herren,\n\n";
          } 
          {
            trigger = "::sw"; 
            replace = "ein schönes Wochenende schon mal";
          } 
          {
            trigger = "::srw"; 
            replace = "ein schönes Restwochenende";
          } 
          {
            trigger = "::gsw"; 
            replace = "einen guten Start in die Woche";
          } 
          {
            trigger = "::lk"; 
            replace = "Liebe Kolleginnen/Kollegen,\n\n";
          } 
          {
            trigger = "::sgk"; 
            replace = "Sehr geehrte Kolleginnen/Kollegen,\n\n";
          } 
          {
            trigger = "::kolloq"; 
            replace = "Sehr geehrte Kolleginnen/Kollegen,\n\nkönnten Sie bitte den Termin für das Kolloquium von XXX (Matrikel-Nr. ) auf den X.Y.20XX um hh:mm festsetzen? Könnten Sie bitte auch einen Raum für das Kolloquium am Campus Wilhelminenhofstraße reservieren?\n\nVielen Dank im Voraus,\nViele Grüße\n-Wojtek Dabrowski";
          } 
          {
            trigger = "::kodok"; 
            replace = "Sehr geehrte Kolleginnen/Kollegen,\n\nim Anhang finden Sie die Dokumente zum Kolloquium von XXX. \n\nViele Grüße\n-Wojtek Dabrowski\n";
          } 
          {
            trigger = "::note"; 
            replace = "Guten Tag $vorname $name,\n\nIhre Note wurde in der Prüfung $prfgsName verbucht.\n\nSollten Sie Beanstandungen haben oder eine Rücksprache bezüglich der Note wünschen, melden Sie sich bitte innerhalb der nächsten 7 Tage, danach werde ich die Notenliste abschließen.\n\nViele Grüße\n-Wojtek Dabrowski";
          } 
          {
            trigger = "::urlaub"; 
            replace = "Liebe Kolleginnen/Kollegen,\n\nsehr gerne befürworte ich hiermit den Urlaubsantrag.\n\nViele Grüße\n-Wojtek Dabrowski";
          } 
          {
            trigger = "::prak"; 
            replace = "Liebe Kolleginnen/Kollegen\n\nim Anhang übersende ich Ihnen die Anerkennung des Praktikums von\n\n\naus dem Studiengang Informatik in Kultur und Gesundheit. Ich wäre Ihnen für eine entsprechende Eintragung im LSF dankbar.\n\nVielen Dank im Voraus,\nViele Grüße\nWojtek Dabrowski";
          } 
        ];
      };
      gutachten = {
        matches = [
          {
            trigger = "::g01"; 
            replace = "Aufbau entsprechend den Anforderungen an eine wissenschaftliche Arbeit";
          }
          {
            trigger = "::g02"; 
            replace = "Kapiteleinteilung nach sachlogischen Gesichtspunkten";
          }
          {
            trigger = "::g03"; 
            replace = "Ausgewogenheit der Kapitelumfänge";
          }
          {
            trigger = "::g04"; 
            replace = "Bezug zum Thema";
          }
          {
            trigger = "::g05"; 
            replace = "Technische Tiefe und Korrektheit";
          }
          {
            trigger = "::g06"; 
            replace = "Beherrschung der Fachsprache, fachliches Verständnis";
          }
          {
            trigger = "::g07"; 
            replace = "Logischer Aufbau der Kapitel";
          }
          {
            trigger = "::g08"; 
            replace = "Verständliche Erklärung der Hintergründe";
          }
          {
            trigger = "::g09"; 
            replace = "Abgrenzung des Themas, klare Zielstellung";
          }
          {
            trigger = "::g10"; 
            replace = "Eigeninitiative/Selbstständigkeit";
          }
          {
            trigger = "::g11"; 
            replace = "Einfallsreichtum/Kreativität";
          }
          {
            trigger = "::g12"; 
            replace = "Orthographie und Grammatik";
          }
          {
            trigger = "::g13"; 
            replace = "Verdichtung in Übersichten und Graphiken";
          }
          {
            trigger = "::g14"; 
            replace = "Kritische Auseinandersetzung mit den Ergebnissen in Diskussion/Fazit";
          }
          {
            trigger = "::g15"; 
            replace = "Zitierweise, angebrachte Verwendung von Quellen";
          }
          {
            trigger = "::gab"; 
            replace = "Daher Abzug von  Punkten im Bereich \"\".";
          }
          {
            trigger = "::ga1"; 
            replace = "Daher Abzug von 1 Punkt im Bereich \"\".";
          }
          {
            trigger = "::dokb"; 
            replace = "/home/wojtek/Documents/HTW/Abschlussarbeiten/Bachelor/";
          }
          {
            trigger = "::dokm"; 
            replace = "/home/wojtek/Documents/HTW/Abschlussarbeiten/Master/";
          }
        ];
      };
    };
  };
}
