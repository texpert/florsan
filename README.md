[![Maintainability](https://api.codeclimate.com/v1/badges/0c4a2c179abd96826e02/maintainability)](https://codeclimate.com/github/texpert/florsan/maintainability)

# README

* Ruby version: 2.6.6

* Rails version: 6.1.3.1

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions: `git push heroku main` or `git push heroku branchname:main`

## TODO: remove public read access

AWS bucket policy is `public read` until [the issue in Camaleon CMS will get solved](https://github.
com/owen2345/camaleon-cms/issues/955)

Current bucket policy:

```
{
    "Version": "2012-10-17",
    "Id": "Policy1590871751896",
    "Statement": [
        {
            "Sid": "Stmt1590871689636",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::Account-ID:user/username"
            },
            "Action": [
                "s3:DeleteObject",
                "s3:DeleteObjectTagging",
                "s3:DeleteObjectVersion",
                "s3:DeleteObjectVersionTagging",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetObjectTagging",
                "s3:GetObjectVersion",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectVersionForReplication",
                "s3:GetObjectVersionTagging",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:PutObjectTagging",
                "s3:PutObjectVersionAcl",
                "s3:PutObjectVersionTagging",
                "s3:PutReplicationConfiguration",
                "s3:ReplicateDelete",
                "s3:ReplicateObject",
                "s3:ReplicateTags",
                "s3:RestoreObject"
            ],
            "Resource": [
                "arn:aws:s3:::bucketname",
                "arn:aws:s3:::bucketname/*"
            ]
        },
        {
            "Sid": "Stmt1590871689636",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::bucketname/*"
        }
    ]
}
```
