From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 16:07:44 -0700
Message-ID: <20110421230744.GC26545@dreamer>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
 <20110421185606.GC9431@dreamer>
 <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
 <20110421193240.GA26545@dreamer>
 <99672323C62444DFA181A0659E4D37FC@gmail.com>
 <20110421220044.GB26545@dreamer>
 <BANLkTikCG487GB=n+9eT+66hxBVk_gfwqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34525 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1DUXHm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 19:07:42 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikCG487GB=n+9eT+66hxBVk_gfwqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 03:25:35PM -0700, Yehuda Sadeh Weinraub wrote:
> Yeah, we're well aware of those races. Note that splitting to
> subdirectories is racey too. Imagine one thread/process creating an
> object, while the other one removing a similar object with the same
> prefix. The first one tries to create a subtree, while the other is
> trying to remove the same subtree. I've seen these issues before,
> they're real.

Yup, that's why I said there's a rmdir/mkdir race. You can fix that
two ways:

1. Don't rmdir; there's not going to be that much junk there
   (punting it, but not badly; no harm done, just littering).

2. Make the mkdir & create file case just handle the race; all you
   need is a simple retry loop, there's no problems and the races
   can't cause actual harm.

   And more to the point, this is the only kind of race there is.
   If FileStore needs to support arbitrary rename etc operations,
   they all need this same retry loop, but it's still just the
   same retry loop, and can probably put in a nice utility function.

   *There are no other kinds of races*, and it seems FileStore doesn't
   really do renames etc anyway.



// try to create a file, using the dynamic dirs trick for long
// filenames. note that this is only needed for file creation; opening
// an existing file needs no mkdir trickery. overwrites pathname,
// returns fd or <0 on errors. pathname is relative to dirfd.
int really_create(int dirfd, char *pathname, int flags, mode_t mode) {
  int ret;

  // split into leading path and base filename
  const char *filename = strrchr(pathname, '/');

  if (!filename) {
    // pathname has no slashes, safe to just open
    return openat(dirfd, pathname, flags, mode);
  }

  // nul terminate leading path
  filename = '\0';
  // move from slash to actual filename
  filename++;

  // go through leading prefixes and mkdir them
 retry:
  char *cursor = pathname;
  while (1) {
    printf("cursor=%p %s\n", cursor, cursor);
    cursor = strchr(cursor, '/');
    if (!cursor)
      break;
    // terminate the string here temporarily, mkdir that
    *cursor = '\0';
    ret = mkdirat(dirfd, pathname, 0755);
    // restore the slash so we don't forget
    *cursor = '/';
    // and nudge us past the slash
    cursor++;
    if (ret < 0) {
      switch (errno) {
      case EEXIST:
	// it already exists; ignore
	break;
      case ENOENT:
	// somebody rmdir'd a parent path; retry from the top
	goto retry;
      default:
	return -errno;
      }
    }
    // loop back to find the next slash and mkdir that
  }

  // leading path is created (unless we lost a race just now); now do
  // the file operation
  ret = openat(dirfd, pathname, flags, mode);
  if (ret<0) {
    switch (errno) {
    case ENOENT:
      // it seems we lost a race at the last second; do mkdirs again
      goto retry;
    default:
      return -errno;
    }
  }
  return ret;
}


-- 
:(){ :|:&};:
