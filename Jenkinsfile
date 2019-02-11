pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    label "docker-xsmall"
                    image 'nikolaik/python-nodejs'
                    args '-u root:root'
                }
            }
            steps {
                // install npm, gitbook, build book
                // ideally  config step should be removed
                echo "Building GitBook"
                sh '''
                    npm install
                    npm config set unsafe-perm true
                    npm install -g gitbook-cli
                    gitbook install
                    gitbook build
                    npm config set unsafe-perm false
                    ls
                '''.trim()
                // grab Calibre ebook-convert util and use it to generate pdf
                echo "Generating PDF"
                sh '''
                    wget https://s3.amazonaws.com/gitbook-testing/ebook-convert
                    chmod +x ebook-convert
                    ls -l ebook-convert
                    apt-get install sudo
                    sudo ln -s ebook-convert /usr/bin
                    gitbook pdf ./ ${env.BRANCH_NAME}.pdf
                '''.trim()
                // stash book for use in deploy stage
                echo "Stashing book"
                stash includes: '_book/**', name: 'book'
            }
        }
        stage('Deploy') {
            agent {
                docker {
                    label "docker-xsmall"
                    image 'nikolaik/python-nodejs'
                    reuseNode true
                }
            }
            steps {
                echo "Unstashing book"
                unstash('book')
                echo "Starting S3 upload"
                withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                    // Copy book directory to S3
                    sh "aws s3 cp _book s3://gitbook-testing/${env.BRANCH_NAME} --acl public-read --recursive"
                }
            }
        }
    }
}
