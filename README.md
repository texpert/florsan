# README

* Ruby version: 3.4.13
* Rails version: 8.1.3

* Only for running ESLint and stylelint
  * Node JS (used only for running ESLint and stylelint) version: 26.4.0
  * Yarn 4.17.0

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

## What CI runs

Three sets of checks test this app. Two run on the events of this repository. One runs on the
events of camaleon_cms.

| Event | Check | Workflow | What it tests |
|---|---|---|---|
| A push to a branch of this repository | `test-on-push / rspec (camaleon_cms <version>)`, and the lint and audit checks | `ci.yml` | The pushed commit of this app, against the released camaleon_cms gem that `Gemfile.lock` pins |
| A push to a branch of this repository | `Camaleon master / Suite / RSpec` | `camaleon_master.yml`, which calls `core_compat.yml` | The pushed commit of this app, against the `master` branch of camaleon_cms |
| A pull request or a `master` push in camaleon_cms | `florsan / RSpec`, on the camaleon_cms commit | `ecosystem.yml` of camaleon_cms, which calls `core_compat.yml` of this repository | The `main` branch of this app, against the camaleon_cms commit |

`core_compat.yml` holds the steps that run the suite against a camaleon_cms commit. It never starts
alone: one of the two callers in the table starts it.

The two checks against Camaleon code that is not released are advisory: no rule requires them. In
this repository, the job `Is master ahead of the release?` skips the suite when Camaleon `master`
has no commit after the release that `Gemfile.lock` pins.

### The suite against Camaleon `master`, locally

Point `CAMALEON_CMS_PATH` at a checkout of the `master` branch of camaleon_cms:

```bash
export RAILS_ENV=test CAMALEON_CMS_PATH=../camaleon-cms
bundle lock && bundle install
bin/rails railties:install:migrations && bin/rails db:test:prepare && bin/rails db:migrate
bin/rspec
unset CAMALEON_CMS_PATH && git checkout Gemfile.lock db/schema.rb && bundle install
```

The last line restores the lock and the schema of the released gem. Also delete each migration
that the `railties:install:migrations` command copied into `db/migrate`.

## Running in development

### Starting with Puma in single mode

```bash
bundle exec rails s
```

or, given that the `rails` binstub is not broken or removed, just
```bash
rails s
```

### Starting with Puma in clustered mode with 2 workers

```bash
WEB_CONCURRENCY=2 rails s
```

macOS, though, doesn't allow the above, so:

```bash
OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES WEB_CONCURRENCY=2 rails s
```

Why is the above workaround necessary on macOS?
- It is a known conflict on macOS where the system's security features crash any process that attempts to initialize 
  Objective-C libraries (like those used by the pg gem for database connections or system SSL libraries) after a fork()
  has already occurred
