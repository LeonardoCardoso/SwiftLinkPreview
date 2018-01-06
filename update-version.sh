grep -rl '2\.1\.0' .  --exclude-dir={"Build","libs","Pods",".git"} --exclude={"Podfile.lock","CHANGELOG.md","update-version.sh"} | xargs sed -i.bak 's/2\.1\.0/2\.2\.0/g';

find . -type f -name '*.bak' -delete
