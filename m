From: Sage Weil <sage@newdream.net>
Subject: Re: [fuse-devel] fuse_lowlevel_notify_inval_inode deadlock
Date: Wed, 24 Aug 2011 12:33:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net>
References: <Pine.LNX.4.64.1108171208490.11873@cobra.newdream.net>
 <878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59343 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1HXT2P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 15:28:15 -0400
In-Reply-To: <878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org

On Fri, 19 Aug 2011, Miklos Szeredi wrote:
> Sage Weil <sage@newdream.net> writes:
> 
> > Hi,
> >
> > I just tried using fuse_lowlevel_notify_inval_inode for the ceph fuse 
> > client and ran into a deadlock.  This translates into a call to 
> > invalidate_inode_pages2(), which will lock each page in the address_space.  
> > I end up with a process stuck on
> >
> > [<ffffffff81106a9e>] sleep_on_page+0xe/0x20
> > [<ffffffff81106a87>] __lock_page+0x67/0x70
> > [<ffffffff81114023>] invalidate_inode_pages2_range+0x373/0x390
> > [<ffffffff81260815>] fuse_reverse_inval_inode+0x75/0x90
> > [<ffffffff812589c3>] fuse_dev_do_write+0x8d3/0xae0
> > [<ffffffff81258c3c>] fuse_dev_write+0x6c/0x70
> > [<ffffffff8115d563>] do_sync_readv_writev+0xd3/0x110
> > [<ffffffff8115e3c4>] do_readv_writev+0xd4/0x1e0
> > [<ffffffff8115e518>] vfs_writev+0x48/0x60
> > [<ffffffff8115e651>] sys_writev+0x51/0xc0
> > [<ffffffff815cae02>] system_call_fastpath+0x16/0x1b
> >
> > I assume this is due to a racing write(2) or something.  Has anyone else 
> > seen this?
> 
> Fuse's write function locks the pages being written to.  So yes, doing a
> fuse_lowlevel_notify_inval_inode() on the same file from the write call
> will reliably deadlock.
> 
> > Would invalidate_mapping_pages() make more sense here?  Locked pages (due 
> > to writers) would be skipped, but that seems sane enough to me for a 
> > concurrent write(2) and invalidate callback. 
> 
> What exactly is the purpuse of invalidating the page cache in write?

I took a closer look at my logs and it looks this is what's happening:

 - cfuse: we get a server callback message, take a mutex
 - kernel/fuse: a write starts, locks pages
 - cfuse: we call fuse_lowlevel_notify_inval_inode()
 - cfuse: the write call (or something that preceeds it in the queue) 
   blocks on the mutex
 -> deadlock.. neither the write nor invalidate can complete.

So basically I can't hold any locks during the invalidate call, so that I 
can be sure that the write will complete and we don't deadlock.  That's a 
little inconvenient: I can't use the lock to order the invalidation with 
respect to any other operations (say, a subsequent read(2) that shouldn't 
see stale data) because I have no idea whether a write(2) may have been 
started on the kernel side and may be working it's way through the fuse 
channel.

On the other hand, doing invalidate_mapping_pages() means I may leave 
partially stale data in the page cache that is still marked Uptodate if 
a racing write only overwrites part of a page.

Anyway, clearly fuse is doing the right thing here.  I just need to push 
this to another thread to do it properly from my end.  That complicates 
things a bit, but it's doable.

Thanks!
sage
