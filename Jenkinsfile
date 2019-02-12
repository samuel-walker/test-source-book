pipeline {
    agent {
        docker {
            label "docker-xsmall"
            image 'nikolaik/python-nodejs'
        }
    }
    stages {
        stage('Prepare') {
            environment {
                DEBIAN_FRONTEND = 'noninteractive'
            }
            steps {
                // install npm, gitbook, calibre, awscli
                sh 'apt-get -qq update && apt-get -qq install -y calibre awscli'
                sh 'npm install -q'
                sh 'npm install -g gitbook-cli'
                sh 'gitbook install'
            }
        }
        stage('Build') {
            steps {
                echo "Building GitBook"
                sh "gitbook build"

                echo "Generating PDF"
                sh "gitbook pdf ./ ${env.BRANCH_NAME}.pdf"

                // stash book for use in deploy stage
                //echo "Stashing book"
                //stash includes: '_book/**', name: 'book'
            }
        }
        /* stage('Deploy') {
            steps {
                echo "Unstashing book"
                unstash('book')
                echo "Starting S3 upload"
                withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                    // Copy book directory to S3
                    sh "aws s3 cp _book s3://gitbook-testing/${env.BRANCH_NAME} --acl public-read --recursive"
                }
            }
        } */
    }
}
