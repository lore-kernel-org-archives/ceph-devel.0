From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 11:56:06 -0700
Message-ID: <20110421185606.GC9431@dreamer>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48903 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1DUS4F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 14:56:05 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 20, 2011 at 09:42:48PM -0700, Sage Weil wrote:
> I think the lfn_open/_get type interface below all of the operation 
> methods will allow all of those things.  I think it'll be simpler to push 
> as much of the filename rendering into that layer as possible, though 
> (possibly including the sobject_t mangling).  Having all the 
> mangling/rendering done in one place will also make it easy to extend 
> without making multiple passes in different layers...

So apparently, this email confused many. Let's try to clarify, to the
best of my understanding:

- Yehuda's code would currently write this:

  ./rados mkpool kitties
  ./rados create --pool=foo "longcatisl$(python -c 'print 300*"o"')ng"

  >>> FILENAME_SHORT_LEN=16
  >>> FILENAME_HASH_LEN=3
  >>> FILENAME_COOKIE="cLFN"
  >>> FILENAME_PREFIX_LEN = (FILENAME_SHORT_LEN - FILENAME_HASH_LEN - 1 - (len(FILENAME_COOKIE) - 1) - 1)
  >>> orig = "longcatisl"+300*"o"+"ng"
  >>> storable = orig + "_head"  # plus backslash escaping, but let's ignore that now
  >>> munged = orig[:FILENAME_PREFIX_LEN] + "_" + FILENAME_COOKIE + "_%s_%d" % ("zzz", 42)
  >>> munged
  'longcati_cLFN_zzz_42'

  So it loses the _head suffix, and all such things.

- Sage wanted (as far as I understand) to have the munging be where
  the backslash escaping is, so the end result would look like
  'longcati_cLFN_zzz_42_head'. Note the suffix.

  I hope I got that right.



As for Yehuda's approach, I'm not very happy to see layers upon layers
of rewriting the filenames.. It just seems more brittle. So Sage's
version looks nicer to me, can do all the work it needs to do in a
single pass, and lets us see the _head etc suffixes without reading
xattrs, which might be useful for fsck-style things.

As for both, I'm especially not fond of the very limited hashing, and
the loops that keep calling build_filename. I fear collisions and
races. Bumping up the hash size significantly will help the common
case, but I still fear the races.

I also think that Ceph, and especially the RGW bits, needs to be
written to be fairly robust against DoS attacks. Nasty things happen
out there, and having somebody able to trigger a "slow mode" on your
server with fairly cheap operations is bad.


Here's a concrete proposal: split the filename into subdirs if needed,
and map the names 1:1, just to avoid the unpredictability of the above
approach. And to get significantly less code and branching in the fast
path. That is, I think I'd go for something like (Python written in C
style to make it more direct to translate):

	# how much overhead to reserve in filenames to always have
	# prefix/suffix not split by slashes
	LONGEST_PREFIX_SUFFIX_LEN = len("_head")
	SAFE_FILENAME_LEN = 255 - LONGEST_PREFIX_SUFFIX_LEN

	def munge(path):
	    dirprefix = None
	    while len(path) > SAFE_FILENAME_LEN:
	        head = path[:SAFE_FILENAME_LEN]
	        if dirprefix is None:
	            dirprefix = head
	        else:
	            dirprefix = dirprefix + '/' + head
	        path = path[SAFE_FILENAME_LEN:]
	    return dirprefix + '/' + path

and now

>>> munged = munge(orig)
>>> munged
'longcatisloooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo/oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong'
>>> munged + '_head'
'longcatisloooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo/oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_head'

And the caller would just mkdir all the leading dirs (ignore EEXIST
errors). They can either be left around, or with a small loop handling
a race between mkdir & rmdir, can be cleaned up either on unlink or in
fsck/scrub/etc.




Also, I'm not thrilled to have something this core, *and* being string
manipulation in C, go without unit tests that exercise the corner
cases.



Finally, here's some misc notes on the existing code that are probably
obvious, I just wanted to make sure:

- hash is always "zzz"
- xattr user.ceph._lfn conflicts with actual end-user xattrs "_lfn"?
- escaping can lengthen the filename, does it handle that (I guess yes
  because this is a layer after that, but I can't tell without reading
  a lot of code)

-- 
:(){ :|:&};:
