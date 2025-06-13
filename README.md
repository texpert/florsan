[![Maintainability](https://api.codeclimate.com/v1/badges/0c4a2c179abd96826e02/maintainability)](https://codeclimate.com/github/texpert/florsan/maintainability)

# README

* Ruby version: 3.4.4

* Rails version: 8.0.1

* Only for running ESLint and stylelint
  * Node JS (used only for running ESLint and stylelint) version: 22.16.0
  * Yarn 4.9.2

* System dependencies

* Configuration

> ### 💡 Note: Multi environment credentials

To edit the credentials file, run `EDITOR="nano" rails credentials:edit`. This command will create the credentials file
the `config/master.key` if there is no such file, and, also, the `config/credentials.yml.enc`if it does not exist. 

The `master.key` should be provisioned to the Rails app as the `RAILS_MASTER_KEY` environment variable by the hosting 
platform (Heroku).

Other credentials, including the `secret_key_base`, are typically stored in the encrypted files  per environment in the 
`config/credentials` folder. These encrypted files could be edited, running in the terminal the following command:

```shell
$ EDITOR="nano" rails credentials:edit --environment=development
```

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

## Testing and profiling

The `derailed_benchmarks` gem is running performance test in `production` environment, so the `production` DB in the `config/database.yml` is pointing to the development DB.

The following specs could be run:

### Static memory reports:

```bash
bundle exec derailed bundle:mem # Memory used at Require time

bundle exec derailed bundle:mem development # Memory used at Require time in `development` environment

bundle exec derailed bundle:objects # Objects created at Require time

bundle exec derailed bundle:objects development # Objects created at Require time in `development` environment

```

### Dynamic profiling

```bash
$ bundle exec derailed exec --help
  $ derailed exec perf:allocated_objects  # outputs allocated object diff after app is called TEST_COUNT times
  $ derailed exec perf:app  # runs the performance test against two most recent commits of the current app
  $ derailed exec perf:gc  # outputs GC::Profiler.report data while app is called TEST_COUNT times
  $ derailed exec perf:heap  # heap analyzer
  $ derailed exec perf:ips  # iterations per second
  $ derailed exec perf:library  # runs the same test against two different branches for statistical comparison
  $ derailed exec perf:mem  # show memory usage caused by invoking require per gem
  $ derailed exec perf:mem_over_time  # outputs memory usage over time
  $ derailed exec perf:objects  # profiles ruby allocation
  $ derailed exec perf:stackprof  # stackprof
  $ derailed exec perf:test  # hits the url TEST_COUNT times
  $ derailed exec perf:heap_diff  # three heaps generation for comparison
```

### ESLint

Run the following command:

```bash
yarn eslint
```

### Stylelint

Run the following command:

```bash
yarn stylelint "**/*.{css,js,scss}"
```
