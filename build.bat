where node >nul 2>&1 && echo node.js is installed || echo node.js is not installed, aborting && EXIT /b
where npm >nul 2>&1 && echo npm is installed || echo npm is not installed, aborting && EXIT /b
where gitbook >nul 2>&1 && echo gitbook is installed || echo gitbook is not installed, aborting && EXIT /b

echo building gitbook
gitbook install
gitbook build

echo pushing to s3
