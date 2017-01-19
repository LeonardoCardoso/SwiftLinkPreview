grep -rl '1\.0\.1' .  --exclude-dir={"Build","libs","Pods",".git"} --exclude={"Podfile.lock","CHANGELOG.md","update-version.sh"} | xargs sed -i.bak 's/1\.0\.1/2\.0\.0/g';

find . -type f -name '*.bak' -delete