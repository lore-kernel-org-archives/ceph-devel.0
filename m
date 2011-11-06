From: Sage Weil <sage@newdream.net>
Subject: Re: BUG at fs/inode.c
Date: Sat, 5 Nov 2011 22:33:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111052207510.22731@cobra.newdream.net>
References: <201110241239.13157.a.ott@m-privacy.de> <201111020953.45095.a.ott@m-privacy.de>
 <Pine.LNX.4.64.1111020713070.2549@cobra.newdream.net> <201111051806.52907.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55861 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1KFFdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Nov 2011 01:33:03 -0400
In-Reply-To: <201111051806.52907.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 5 Nov 2011, Amon Ott wrote:
> On Wednesday 02 November 2011 you wrote:
> > On Wed, 2 Nov 2011, Amon Ott wrote:
> > > On Tuesday 01 November 2011 wrote Sage Weil:
> > > > Can you capture a larger log segment?  The hope is to catch the first
> > > > use-after-free, and not the subsequent side-effects.
> > >
> > > I still have the full kern.log here from boot till BUG, cleaned it up a
> > > bit (no firewall lines, RSBAC stuff) and uploaded to
> > > https://download.m-privacy.de/kern-full.log.bz2
> > >
> > > Full ceph logging had been enabled as soon as possible, after boot and
> > > before mounting ceph fs.
> > >
> > > > Also, the below patch may help us parse the output with multiple
> > > > threads.
> >
> > The following would also help: 4f9ea86237b8d0005f5467fe817b4f1f0955072c,
> > or wip-debug-inode-refs in ceph-client.git.
> 
> The bug had been a lot harder to trigger with all that debugging slowing down 
> the systems, but now I have something. I hope it helps tracking that beast 
> down. 282K compressed size, so I uploaded the full log there:
> 
> https://download.m-privacy.de/kern.log2.bz2

Pretty sure I've found this.  Can you test the patch below?

Thanks!
sage




From 15a2015fbc692e1c97d7ce12d96e077f5ae7ea6d Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Sat, 5 Nov 2011 22:06:31 -0700
Subject: [PATCH] ceph: fix iput race when queueing inode work

If we queue a work item that calls iput(), make sure we ihold() before
attempting to queue work. Otherwise our queued work might miraculously run
before we notice the queue_work() succeeded and call ihold(), allowing the
inode to be destroyed.

That is, instead of

	if (queue_work(...))
		ihold();

we need to do

	ihold();
	if (!queue_work(...))
		iput();

Reported-by: Amon Ott <a.ott@m-privacy.de>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/inode.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e392bfc..116f365 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1328,12 +1328,13 @@ int ceph_inode_set_size(struct inode *inode, loff_t size)
  */
 void ceph_queue_writeback(struct inode *inode)
 {
+	ihold(inode);
 	if (queue_work(ceph_inode_to_client(inode)->wb_wq,
 		       &ceph_inode(inode)->i_wb_work)) {
 		dout("ceph_queue_writeback %p\n", inode);
-		ihold(inode);
 	} else {
 		dout("ceph_queue_writeback %p failed\n", inode);
+		iput(inode);
 	}
 }
 
@@ -1353,12 +1354,13 @@ static void ceph_writeback_work(struct work_struct *work)
  */
 void ceph_queue_invalidate(struct inode *inode)
 {
+	ihold(inode);
 	if (queue_work(ceph_inode_to_client(inode)->pg_inv_wq,
 		       &ceph_inode(inode)->i_pg_inv_work)) {
 		dout("ceph_queue_invalidate %p\n", inode);
-		ihold(inode);
 	} else {
 		dout("ceph_queue_invalidate %p failed\n", inode);
+		iput(inode);
 	}
 }
 
@@ -1434,13 +1436,14 @@ void ceph_queue_vmtruncate(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	ihold(inode);
 	if (queue_work(ceph_sb_to_client(inode->i_sb)->trunc_wq,
 		       &ci->i_vmtruncate_work)) {
 		dout("ceph_queue_vmtruncate %p\n", inode);
-		ihold(inode);
 	} else {
 		dout("ceph_queue_vmtruncate %p failed, pending=%d\n",
 		     inode, ci->i_truncate_pending);
+		iput(inode);
 	}
 }
 
-- 
1.7.2.5

