From: Sage Weil <sage@newdream.net>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 21:54:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net>
References: <4E33D101.1050504@ufm.su> <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
 <4E3432FC.9030204@ufm.su> <20110730165001.GI7361@thunk.org>
 <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net> <20110730221900.GK7361@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58932 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab1GaEuR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Jul 2011 00:50:17 -0400
In-Reply-To: <20110730221900.GK7361@thunk.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Sat, 30 Jul 2011, Ted Ts'o wrote:
> On Sat, Jul 30, 2011 at 10:21:13AM -0700, Sage Weil wrote:
> > 
> > We do use xattrs extensively, though; that was the last extN bug we 
> > uncovered.  That's where my money is.
> 
> Hmm, yes.  That could very well be.  How big are the xattrs, and are
> there cases where you:
> 
> a) start with a small xattr (where the total size is less than 128
> bytes, so it can be stored in the inode table), and then increase it
> something where it needs to be stored in an external block?
> 
> b) start with enough xattrs so it's large, and then delete all or most
> of them?
> 
> I could easily believe we might have some bugs as we transition from
> in-inode to external block storage, or vice versa.  I'll take a look
> at the code and try to create some reproduction cases, but if you
> could give me a handle on workload patterns of ceph around xattrs,
> that would be interesting.

I would guess a, but it could also be a+b. 

Fyodor, can you take some of the corrupt inos that fsck complained about 
and see what files/directories they are?  find /osd.0 -inum NNN.  (I'm 
guessing the largest xattrs are on the collection directories, like 
/osd.0/current/something_head/.)  Then grep that filename out of the log 
to see exactly which operations took place.  The setattr log normally 
includes xattr size.

> Another thing to try might be to format the disk with 128 byte inodes
> (mke2fs -t ext4 -I 128 /dev/hdXX) and see if you can reproduce the
> problem that way.  The support for in-inode xattrs is a new feature
> (to ext4), and so it's a bit more likely that if there is a bug, it's
> related to our in-inode xattr handling --- and using a 128 byte inode
> would suppress that feature.  I don't recommend running that way, of
> course, but it might help tell us if that's where we should be looking
> for a bug.
>
> > (BTW we'll be really happy if/when the large xattr patches from the Lustre 
> > guys make it into mainline!  The (4k?) limit on total xattrs is a problem 
> > for us.)
> 
> OK, good to know.  It hadn't been high priority for the ext4 team
> (since I thought it was only the Lustre folks that really needed it),
> but I'll escalate the priority of that on our todo list.

Wonderful.

Thanks, Ted!
sage
