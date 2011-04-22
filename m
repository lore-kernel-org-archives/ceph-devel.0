From: Sage Weil <sage@newdream.net>
Subject: Re: long object names
Date: Fri, 22 Apr 2011 08:44:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104220818210.15351@cobra.newdream.net>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
 <20110421185606.GC9431@dreamer> <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
 <20110421193240.GA26545@dreamer> <99672323C62444DFA181A0659E4D37FC@gmail.com>
 <20110421220044.GB26545@dreamer> <BANLkTikCG487GB=n+9eT+66hxBVk_gfwqw@mail.gmail.com>
 <20110421230744.GC26545@dreamer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59635 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab1DVPoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2011 11:44:46 -0400
In-Reply-To: <20110421230744.GC26545@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Few things:

- I think the xattr approach is always going to be faster.  xattrs are 
stored adjacent to the inode in the btree, while creating intervening 
directories means a new inode is allocated, seeked to, and loaded, and 
_then_ the directory content is looked up in another part of the btree 
before the final inode is located.  For each level you add two seeks 
(although in the common case, at least, those inodes will be close by).

- They may make it harder to inspect things out of band (need to peek at 
xattrs instead of subdirectories).  OTOH, it's a 1:1 mapping of dirent to 
object, while subdirs are not.

- You can't make intervening directories both rare (long) and useful for 
prefix search (short) unless you really think people will be searching on 
100+ character prefixes.

- Hash collisions will be rare for all but our test cases.  If we only 
hash for long filenames (say, 200+ characters) that means someone has to 
find a SHA-256 collision (has anybody??).  And even then they only turn 1 
stat into 2.  Only if someone can generate an arbitrary number of inputs 
that hash to the same value do they get anywhere.  I don't think that's 
something we should worry about.  If someone breaks a crypto hash there 
are much bigger things to worry about.  (Even if we are super paranoid, 
then just sha(name + sha(name)).

- We can easily wrap the non-fast past with a mutex to avoid the races 
(because, again, collisions are vanishingly rare except in our test 
cases).

- I'm somewhat attracted to the idea of not escaping / and creating 
intervening directories because that's how people frequently use it.  
It's worth noting though that S3 at least doesn't treat / as anything 
special (you can delimit using anything) so we'd only optimize for the 
common case here.  And it will slow down _everything_else_ besides prefix 
search.  So... bleh.

- Those mkdir helpers may be useful for the prehashing.  Or we can just 
precreate the hash dirs (there'll be a fixed power-of-two number of them).

- For simplicity, I still think the simplest thing will be to push all the 
escaping/mangling into one layer.  Once place to audit and unit test.

sage





On Thu, 21 Apr 2011, Tommi Virtanen wrote:

> On Thu, Apr 21, 2011 at 03:25:35PM -0700, Yehuda Sadeh Weinraub wrote:
> > Yeah, we're well aware of those races. Note that splitting to
> > subdirectories is racey too. Imagine one thread/process creating an
> > object, while the other one removing a similar object with the same
> > prefix. The first one tries to create a subtree, while the other is
> > trying to remove the same subtree. I've seen these issues before,
> > they're real.
> 
> Yup, that's why I said there's a rmdir/mkdir race. You can fix that
> two ways:
> 
> 1. Don't rmdir; there's not going to be that much junk there
>    (punting it, but not badly; no harm done, just littering).
> 
> 2. Make the mkdir & create file case just handle the race; all you
>    need is a simple retry loop, there's no problems and the races
>    can't cause actual harm.
> 
>    And more to the point, this is the only kind of race there is.
>    If FileStore needs to support arbitrary rename etc operations,
>    they all need this same retry loop, but it's still just the
>    same retry loop, and can probably put in a nice utility function.
> 
>    *There are no other kinds of races*, and it seems FileStore doesn't
>    really do renames etc anyway.
> 
> 
> 
> // try to create a file, using the dynamic dirs trick for long
> // filenames. note that this is only needed for file creation; opening
> // an existing file needs no mkdir trickery. overwrites pathname,
> // returns fd or <0 on errors. pathname is relative to dirfd.
> int really_create(int dirfd, char *pathname, int flags, mode_t mode) {
>   int ret;
> 
>   // split into leading path and base filename
>   const char *filename = strrchr(pathname, '/');
> 
>   if (!filename) {
>     // pathname has no slashes, safe to just open
>     return openat(dirfd, pathname, flags, mode);
>   }
> 
>   // nul terminate leading path
>   filename = '\0';
>   // move from slash to actual filename
>   filename++;
> 
>   // go through leading prefixes and mkdir them
>  retry:
>   char *cursor = pathname;
>   while (1) {
>     printf("cursor=%p %s\n", cursor, cursor);
>     cursor = strchr(cursor, '/');
>     if (!cursor)
>       break;
>     // terminate the string here temporarily, mkdir that
>     *cursor = '\0';
>     ret = mkdirat(dirfd, pathname, 0755);
>     // restore the slash so we don't forget
>     *cursor = '/';
>     // and nudge us past the slash
>     cursor++;
>     if (ret < 0) {
>       switch (errno) {
>       case EEXIST:
> 	// it already exists; ignore
> 	break;
>       case ENOENT:
> 	// somebody rmdir'd a parent path; retry from the top
> 	goto retry;
>       default:
> 	return -errno;
>       }
>     }
>     // loop back to find the next slash and mkdir that
>   }
> 
>   // leading path is created (unless we lost a race just now); now do
>   // the file operation
>   ret = openat(dirfd, pathname, flags, mode);
>   if (ret<0) {
>     switch (errno) {
>     case ENOENT:
>       // it seems we lost a race at the last second; do mkdirs again
>       goto retry;
>     default:
>       return -errno;
>     }
>   }
>   return ret;
> }
> 
> 
> -- 
> :(){ :|:&};:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
