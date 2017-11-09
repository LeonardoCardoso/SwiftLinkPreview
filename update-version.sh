grep -rl '2\.0\.7' .  --exclude-dir={"Build","libs","Pods",".git"} --exclude={"Podfile.lock","CHANGELOG.md","update-version.sh"} | xargs sed -i.bak 's/2\.0\.7/2\.1\.0/g';

find . -type f -name '*.bak' -delete
