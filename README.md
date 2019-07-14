
# Twit-commit, a Git Commit-based Social Network

This is a concept and implementation for a git commit-based social network,
inspired by Twitter.  An account is represented by a git repository.  Posts are
made by creating an empty commit where the message is the content of the post.
Following someone is done by cloning their repository.  Additional assets can
be attached to a post by `add`ing files to the commit.

## How to Use

### Creating an Account

Before anything, I recommend you create a directory in which you'll put your
repo-account, as well as the repo-account of every person you follow.  This
will make it easier to list all your followees' posts (when, uh, I figure out a
way to do so!).  Even better: you can clone this repository and use it as the
directory containing your repo-account and followees.  That way, this README is
always just one `cd ..` away!

```bash
git clone git@github.com:xlambein/twit-commit.git
cd twit-commit
```

To create a repo-account, simply create a subdirectory in `twit-commit` and
initialize a git repository there.  I recommend you give this repository a name
like `_me`, instead of your own (user)name.  That way it'll be easier to find
among all your followees.

```bash
mkdir _me
cd _me
git init
```

In addition, you should synchronize your repo-account somewhere (e.g., GitHub,
Git Lab, or host it yourself), so that people can follow you.

### Making a Post

Posts are represented by commits.  Normal commits require you to have at least
one file change, but the `--allow-empty` flag can bypass this restriction.

`cd` into your repo-account and make a new post with the following:

```bash
git commit --allow-empty -m "[post content]"
git push
```

Of course, since we're using the command line, we can do fancier things, like
`cat` a file into a post:

```bash
cat my_post.txt | xargs -0 git commit --allow-empty -m
```

That being said, I'd recommend you keep the length of a commit message
relatively short, e.g., in the order of 100-200 characters.  For long-form
content, or to include things like images, consider `add`ing files to the
commit.

### Following Someone

Following someone is as simple as cloning their repo-account:

```bash
cd twit-commit
git clone [url-of-repo-account]
```

### Listing Posts Made by Someone

To get and display a person's posts, simply `pull` and `log` in their
repo-account:

```bash
cd twit-commit/[repo-account]
git pull  # or `git fetch`, see "Listing New Posts Only"
git log
```

The default output works well, but contains a lot of unnecessary information,
like the commit hash, the `HEAD` and `master` markers, the author's e-mail
address, etc.  Thankfully, `git log` comes with a wide variety of formatting
options that will help you display posts in friendlier ways.  Here are a few
examples:

- Single-line listing of posts, with summary of files, human-friendly dates and
  colors:

  ```bash
  $ git log --pretty=format:"%Cblue%ad %Cgreen%aN %Creset%s" --date=human --compact-summary
  3 minutes ago Marty McFly I guess you guys aren't ready for that yet...
  5 minutes ago Marty McFly All right. This is an oldie, but, uh... well, it's an oldie where I come from. I attached the lyrics to this post.
   johnny_b_goode.txt (new) | 12 ++++++++++++
   1 file changed, 12 insertions(+)
  
  7 minutes ago Marty McFly @docbrown, you don't just walk into a store and buy... plutonium. Did you rip that off?
  8 minutes ago Marty McFly Damn, I'm late for school!
	```

- Multiple-lines, with summary of files, single-line header, short commit hash,
  human-friendly dates and colors:

  ```bash
  $ git log --pretty=format:"%C(yellow)%h %Cgreen%aN%Creset (%Cblue%ad%Creset)%n%Creset%n%w(0,4,4)%B" --date=human --compact-summary
  83bd374 Marty McFly (3 minutes ago)
  
      I guess you guys aren't ready for that yet...
  
      But your kids are gonna love it.
  
  85af1b1 Marty McFly (5 minutes ago)
  
      All right. This is an oldie, but, uh... well, it's an oldie where I come from.
      I attached the lyrics to this post.
  
   johnny_b_goode.txt (new) | 12 ++++++++++++
   1 file changed, 12 insertions(+)
  
  b0881e6 Marty McFly (7 minutes ago)
  
      @docbrown, you don't just walk into a store and buy... plutonium. Did you rip that off?
  
  74d3661 Marty McFly (8 minutes ago)
  
      Damn, I'm late for school!
  ```

The option `--compact-summary` is one of the few options `git log` offers to
display files that were changed in a specific commit.  For a shorter output,
you may want to try `--name-only`.

You can change the format of dates to your liking by changing the `--date=`
option.  A few interesting values are:

- `rfc` gives you RFC 2822-formatted dates, typically found in e-mails, such as
  `Sun, 14 Jul 2019 14:49:29 +0200`.
- `human` produces a human-friendly output, giving relative time or day of the
  week for recent commits, showing the timezone if it doesn't match the local
  one, etc.
- `short` only outputs the date, in `YYYY-MM-DD` format.

For more information about formatting, check the `git-log` man pages (sections
`Commit Formatting` and `PRETTY FORMATS`):

```bash
man git-log
```

## Advanced Usage

### Listing New Posts Only

The `HEAD` pointer can be used to remember which posts you already read, and
which posts are new.  When synchronizing another repo-account, instead of using
`git pull`, try using `git fetch`, which pulls the changes without merging and
moving `HEAD`.  Then, you can list only new posts with the following:

```bash
git log HEAD..origin/master
```

To display additional posts (e.g., to give some context), use `HEAD~N..origin/master`
where `N` is the number of older commits to show (starting from `HEAD` itself).

Mark all new commits as read with:

```bash
git merge
```

You can also decide to set your HEAD pointer to a specific commit hash, e.g., if you
haven't yet caught up with everything.

### Several Blogs on a Single Repo-account

You can host more than one blog on a single repo-account by creating branches.
Use `git checkout` to switch from one blog to another, or clone the repository
twice to make it less cumbersome :-)

## Command-line Tool

In order to make some tasks easier, I made a command-line tool called `twit`,
which you'll find in this repository.

A typical `twit` workflow would be:

```bash
# Follow someone
twit clone <some repo-account> <username of the person>

# List their twit-commits
twit log <username>

# Some time has passed...

# List their new twit-commits
twit log <username> --new

# Mark new twit-commits as read
twit merge <username>

# Create my own account
twit init

# Post a twit-commit myself
twit commit "Hello World!"

# Post a twit-commit with files
twit add ~/Documents/novel/chapter05.md
twit commit "Check out the new chapter of my novel (attached)"
```

Use `twit` without a command to display the help, and `twit help <command>` to
display the help for a specific command.

## Further Improvements

Here are a bunch of other ideas to improve this project:

- Use commit hooks to maintain an up-to-date RSS feed of your posts.
- Find a way to list posts from multiple repo-accounts in chronological order

If you have any suggestion for improvements, I'd be very happy to hear them!
Get in touch with me at: `xlambein [AT] gmail [DOT] com`.

You can also follow my twit-commits here: https://github.com/xlambein/commits

## So, Um, Why????

Sometimes an idea pops in my brain and I just.....need....to do it......

