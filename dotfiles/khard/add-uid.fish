set -l dirs HTW-collected HTW-global

for d in $dirs
  rm -rf $d
  mkdir $d
  cd $d
  split.bash ../$d.vcf
  for f in (ls)
    set -l uid (md5sum $f | cut -d " " -f 1)
    head -n 2 $f > $uid.vcf
    echo "UID:$uid" >> $uid.vcf
    tail -n +3 $f >> $uid.vcf
    rm $f
  end
  cd ..
end

