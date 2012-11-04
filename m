From: Sage Weil <sage@inktank.com>
Subject: Re: Ignoresync hack no longer applies on 3.6.5
Date: Sun, 4 Nov 2012 05:50:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211040536210.30792@cobra.newdream.net>
References: <CAPud5_5Gv7_-6cuk+ZND3hUtoqvvjq7VhTe4tQstcYqBtwrDDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42566 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab2KDNuV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 08:50:21 -0500
In-Reply-To: <CAPud5_5Gv7_-6cuk+ZND3hUtoqvvjq7VhTe4tQstcYqBtwrDDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 2 Nov 2012, Nick Bartos wrote:
> Sage,
> 
> A while back you gave us a small kernel hack which allowed us to mount
> the underlying OSD xfs filesystems in a way that they would ignore
> system wide syncs (kernel hack + mounting with the reused "mand"
> option), to workaround a deadlock problem when mounting an rbd on the
> same node that holds osds and monitors.  Somewhere between 3.5.6 and
> 3.6.5, things changed enough that the patch no longer applies.
> 
> Looking into it a bit more, sync_one_sb and sync_supers no longer
> exist.  In commit f0cd2dbb6cf387c11f87265462e370bb5469299e which
> removes sync_supers:
> 
>     vfs: kill write_super and sync_supers
> 
>     Finally we can kill the 'sync_supers' kernel thread along with the
>     '->write_super()' superblock operation because all the users are gone.
>     Now every file-system is supposed to self-manage own superblock and
>     its dirty state.
> 
>     The nice thing about killing this thread is that it improves power
> management.
>     Indeed, 'sync_supers' is a source of monotonic system wake-ups - it woke up
>     every 5 seconds no matter what - even if there were no dirty superblocks and
>     even if there were no file-systems using this service (e.g., btrfs and
>     journalled ext4 do not need it). So it was wasting power most of
> the time. And
>     because the thread was in the core of the kernel, all systems had
> to have it.
>     So I am quite happy to make it go away.
> 
>     Interestingly, this thread is a left-over from the pdflush kernel
> thread which
>     was a self-forking kernel thread responsible for all the write-back in old
>     Linux kernels. It was turned into per-block device BDI threads, and
>     'sync_supers' was a left-over. Thus, R.I.P, pdflush as well.
> 
> Also commit b3de653105180b57af90ef2f5b8441f085f4ff56 renames
> sync_inodes_one_sb to sync_inodes_one_sb along with some other
> changes.
> 
> Assuming that the deadlock problem is still present in 3.6.5, could we
> trouble you for an updated patch?  Here's the original patch you gave
> us for reference:

Below.  Compile-tested only!

However, looking over the code, I'm not sure that the deadlock potential 
still exists.  Looking over the stack traces you sent way back when, I'm 
not sure exactly which lock it was blocked on.  If this was easily 
reproducible before, you might try running without the patch to see if 
this is still a problem for your configuration.  And if it does happen, 
capture a fresh dump (echo t > /proc/sysrq-trigger).

Thanks!
sage



From 6cbfe169ece1943fee1159dd78c202e613098715 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@inktank.com>
Date: Sun, 4 Nov 2012 05:34:40 -0800
Subject: [PATCH] vfs hack: make sync skip supers with MS_MANDLOCK

This is an ugly hack to skip certain mounts when there is a sync(2) system
call.

A less ugly version would create a new mount flag for this, but it would
require modifying mount(8) too, and that's too much work.

A curious person would ask WTF this is for.  It is a kludge to avoid a 
deadlock induced when an RBD or Ceph mount is backed by a local ceph-osd 
on a local fs.  An ill-timed sync(2) call by whoever can leave a 
ceph-dependent mount waiting on writeback, while something would prevent 
the ceph-osd from doing its own sync(2) on its backing fs.

---
 fs/sync.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index eb8722d..ab474a0 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -75,8 +75,12 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 
 static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
-	if (!(sb->s_flags & MS_RDONLY) && sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, *(int *)arg);
+	if (!(sb->s_flags & MS_RDONLY) && sb->s_op->sync_fs) {
+		if (sb->s_flags & MS_MANDLOCK)
+			pr_debug("sync_fs_one_sb skipping %p\n", sb);
+		else
+			sb->s_op->sync_fs(sb, *(int *)arg);
+	}
 }
 
 static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
-- 
1.7.9.5

