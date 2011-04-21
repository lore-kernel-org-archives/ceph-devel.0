From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 15:23:50 -0700
Message-ID: <DA39DF2CF0184548A4887A8BD8123275@gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
 <20110421185606.GC9431@dreamer>
 <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
 <20110421193240.GA26545@dreamer>
 <99672323C62444DFA181A0659E4D37FC@gmail.com>
 <20110421220044.GB26545@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44503 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab1DUWXy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 18:23:54 -0400
Received: by pwi15 with SMTP id 15so89145pwi.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 15:23:54 -0700 (PDT)
In-Reply-To: <20110421220044.GB26545@dreamer>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thursday, April 21, 2011 at 3:00 PM, Tommi Virtanen wrote:
On Thu, Apr 21, 2011 at 01:03:57PM -0700, Gregory Farnum wrote:
> > I like what Yehuda has here for its relative simplicity
> 
> It's far from simple.
> 
> Let's look at the unlink path:
> 
> 
> static int lfn_unlink(const char *pathname)
> {
>  const char *filename;
>  char short_fn[PATH_MAX];
>  char short_fn2[PATH_MAX];
>  int r, i, exist, err;
>  int path_len;
>  int is_lfn;
> 
> ** helper function to split the path to dir and file, figure out a
> ** short name for this longname, count the lenght of the directory
> ** part of the path and other things; loops through the candidates,
> ** comparing against the xattr
>  r = lfn_get(pathname, short_fn, sizeof(short_fn), &filename, &exist, &is_lfn);
>  if (r < 0)
>  return r;
> ** if the filename wasn't actually too long, take the easy way out
>  if (!is_lfn)
>  return unlink(pathname);
>  if (!exist) {
>  errno = ENOENT;
>  return -1;
>  }
> 
> ** actual file unlink here
>  err = unlink(short_fn);
>  if (err < 0)
>  return err;
> 
> ** and then, rename all the collisions, one by one, because they have
> ** a sequential number in them!
>  path_len = filename - pathname;
>  memcpy(short_fn2, pathname, path_len);
> 
> ** this loop finds the highest sequential number in this hash
> ** collision bucket, saves it in i
>  for (i = r + 1; ; i++) {
>  struct stat buf;
>  int ret;
> 
>  build_filename(&short_fn2[path_len], sizeof(short_fn2) - path_len, filename, i);
>  ret = stat(short_fn2, &buf);
>  if (ret < 0) {
>  if (i == r + 1)
>  return 0;
> 
>  break;
>  }
>  }
> 
> ** and then the highest seq number munged filename gets renamed to
> ** fill the gap we left behind
>  build_filename(&short_fn2[path_len], sizeof(short_fn2) - path_len, filename, i - 1);
>  generic_dout(0) << "renaming " << short_fn2 << " -> " << short_fn << dendl;
> 
>  if (rename(short_fn2, short_fn) < 0) {
>  generic_derr << "ERROR: could not rename " << short_fn2 << " -> " << short_fn << dendl;
>  assert(0);
>  }
> 
>  return 0;
> }
> 
> 
> Now, imagine a colliding file create between the stat and the rename
> -> boom. This is not the only race in there.
> 
> The underlying problem is that you're constructing an atomic operation
> out of multiple underlying operations, and you're not obsessively
> careful about ordering them. Once you get obsessive about ordering
> them, the extra directory my scheme creates will seem very cheap.
> 
> If you say that's not relevant because of some locking that the OSD
> does, then 1) you're building a lot of assumptions on the locking
> never changing 2) I can construct similar bugs with a single actor,
> with a crash at the wrong moment.
> 
> Simple code makes Tv happy. You don't want an unhappy Tv all up in
> your codebase.
> 

I said "relatively simple". In fact I also suggested just ditching the collision handling precisely because of issues like this -- keep in mind that we have 200+ characters to make a hash out of[1] and PGs really shouldn't ever grow big enough for collisions to happen -- and if we instead make a folder structure out of long names that's not exactly going to remove any races.
I understand that Colin likes making folders so as to speed up the prefix searches but I don't think we should optimize for RGW -- if we're going to do that we should (God help us) implement multiple ObjectStore classes and choose the appropriate one to use based on what kind of data the cluster is serving.
I think that you're inflating the cost of doing hashing and an xattr, especially in btrfs where we get the xattrs on lookup anyway, when compared to deep dir lookups. I'm also concerned about issues that may crop up when we take a 4k object name and translate it directly into a path of 4k + slashes, since at that point we're not going to be able to address it all in one go and will need to pull tricks like moving in and out of directories, which endlessly complicates your simple little loops. :(
-Greg

[1]: The current code has short hashes precisely because Yehuda wants to test his collision-handling, and it is a work in progress as you can see by the random "fix blah" patches at the end. :) 
