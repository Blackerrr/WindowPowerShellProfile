param(
	[string]$message=$(throw "Parameter missing -message message")
)
cp $PROFILE .
git add .
git commit -m $message
git pull origin main
git push origin main
