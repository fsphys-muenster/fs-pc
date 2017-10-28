# fs-pc
Der Fachschafts-PC stellt den Büroarbeitsplatz des Fachschaftsrats Physik der [Westfälischen Wilhelms-Universität Münster](https://www.uni-muenster.de/) dar.

## Hinweise zu den Unterordnern
### Zum Unterordner [`puppet_modules`](puppet_modules/)
Alle eigenen Puppet-Module sind in diesem Ordner veröffentlicht.
Es wird, wenn nicht anders geschrieben, weder empfolen, noch Haftung dafür übernommen, diese unbedacht auf dritten Rechnern einzusetzen.

### Zum Unterordner [`foreman_config`](foreman_config/)
Alle komplexeren Einstellungen, die in der Administrationsoberfläche von [Foreman](https://theforeman.org/) insb. zu Puppet-Modulen getroffen wurden, sind hier nachgehalten.

## Hinweise zu Backups
Backups können von sudoern über folgenden Befehl erstellt werden:
```
sudo rsync -avz --exclude=Fachschaftsplatte --exclude=IVV4_I-Laufwerk --exclude=.cache --exclude=ybbier --exclude=ysmay --exclude=b_bier05 --exclude=s_may006 /home/* ~/IVV4_I-Laufwerk/fspcbackup/
```
