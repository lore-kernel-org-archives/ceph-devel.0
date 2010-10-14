From: Ted Ts'o <tytso@mit.edu>
Subject: Re: OOM's on the Ceph client machine
Date: Wed, 13 Oct 2010 20:03:06 -0400
Message-ID: <20101014000306.GB11103@thunk.org>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
 <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
 <20101013033406.GD4833@thunk.org>
 <Pine.LNX.4.64.1010130917210.7988@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:35218 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0JNADQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Oct 2010 20:03:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1010130917210.7988@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org, mrubin@google.com

On Wed, Oct 13, 2010 at 10:29:43AM -0700, Sage Weil wrote:
> There have been a number of memory leak fixes since then, at least one of 
> which may be causing your problem (it was caused by an uninitialized 
> variable and didn't usually trigger for us, but may in your environment).  
> Can you retry with the latest mainline?  The benchmark completes without 
> problems in my test environment.

Sure.  This may have to wait until early next week for me to retry
with the latest mainline, but I'll definitely move to 2.6.36 in the
near future.

> If fsync on a single file in journal-less ext4 doesn't do any extra work, 
> I would just put the (preallocated) journal file together with the data on 
> each disk.  Usually that's bad news because of the journal flushing, but 
> you shouldn't have that problem.  Alternatively, you could use a small 
> separate partition on the same spindle.

I'm currently reformatting the Ceph cluster to put the journal for
/dev/sdX3 on /disk/sdX3/ceph.journal, so I'll try that test first, and
see what difference that makes.  That way I can make one change at a
time and see what difference each change in my cluster configuration
actually gives me.

BTW, this might be a good time to report a tiny little problem which I
found.  If the journal file doesn't exist, then when you run mkcephfs,
cosd will attempt to create the file for you.  But it creates it as a
4k file, and then it loops forever in FileJournal::wrap_read_bl() on
line 808, because get_top() and and header.max_size are both 4096, and
it results in it being an expensive while (1) loop.  This completely
stalls the mkcephfs operation, and it took me a while to debug.

It might be nice if cosd either (a) failed completely if the journal
file is missing, or too small, or (b) if cosd is started in mkfs mode,
and the journal file does not exist, perhaps it should create a
journal file with some suitable default size.

For stuff like this, I assume the right thing to do is to just open a
bug in tracker.newdream.net?  Is there any project-specific customs I
should be aware of?

Thanks,

						- Ted
