From: Nick Bartos <nick@pistoncloud.com>
Subject: Ignoresync hack no longer applies on 3.6.5
Date: Fri, 2 Nov 2012 17:33:54 -0700
Message-ID: <CAPud5_5Gv7_-6cuk+ZND3hUtoqvvjq7VhTe4tQstcYqBtwrDDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:48121 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab2KCAdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 20:33:55 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3045604iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 17:33:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage,

A while back you gave us a small kernel hack which allowed us to mount
the underlying OSD xfs filesystems in a way that they would ignore
system wide syncs (kernel hack + mounting with the reused "mand"
option), to workaround a deadlock problem when mounting an rbd on the
same node that holds osds and monitors.  Somewhere between 3.5.6 and
3.6.5, things changed enough that the patch no longer applies.

Looking into it a bit more, sync_one_sb and sync_supers no longer
exist.  In commit f0cd2dbb6cf387c11f87265462e370bb5469299e which
removes sync_supers:

    vfs: kill write_super and sync_supers

    Finally we can kill the 'sync_supers' kernel thread along with the
    '->write_super()' superblock operation because all the users are gone.
    Now every file-system is supposed to self-manage own superblock and
    its dirty state.

    The nice thing about killing this thread is that it improves power
management.
    Indeed, 'sync_supers' is a source of monotonic system wake-ups - it woke up
    every 5 seconds no matter what - even if there were no dirty superblocks and
    even if there were no file-systems using this service (e.g., btrfs and
    journalled ext4 do not need it). So it was wasting power most of
the time. And
    because the thread was in the core of the kernel, all systems had
to have it.
    So I am quite happy to make it go away.

    Interestingly, this thread is a left-over from the pdflush kernel
thread which
    was a self-forking kernel thread responsible for all the write-back in old
    Linux kernels. It was turned into per-block device BDI threads, and
    'sync_supers' was a left-over. Thus, R.I.P, pdflush as well.

Also commit b3de653105180b57af90ef2f5b8441f085f4ff56 renames
sync_inodes_one_sb to sync_inodes_one_sb along with some other
changes.

Assuming that the deadlock problem is still present in 3.6.5, could we
trouble you for an updated patch?  Here's the original patch you gave
us for reference:

diff -U3 -r linux-3.4.4.orig/fs/super.c linux-3.4.4/fs/super.c
--- linux-3.4.4.orig/fs/super.c 2012-06-22 11:37:50.000000000 -0700
+++ linux-3.4.4/fs/super.c      2012-06-26 13:40:36.773535450 -0700
@@ -508,8 +508,12 @@
                        spin_unlock(&sb_lock);

                        down_read(&sb->s_umount);
-                       if (sb->s_root && sb->s_dirt && (sb->s_flags & MS_BORN))
-                               sb->s_op->write_super(sb);
+                       if (sb->s_root && sb->s_dirt && (sb->s_flags &
MS_BORN)) {
+                               if (sb->s_flags & MS_MANDLOCK)
+                                       printk("sync_supers skipping %p\n", sb);
+                               else
+                                       sb->s_op->write_super(sb);
+                       }
                        up_read(&sb->s_umount);

                        spin_lock(&sb_lock);
diff -U3 -r linux-3.4.4.orig/fs/sync.c linux-3.4.4/fs/sync.c
--- linux-3.4.4.orig/fs/sync.c  2012-06-22 11:37:50.000000000 -0700
+++ linux-3.4.4/fs/sync.c       2012-06-26 13:40:36.773535450 -0700
@@ -79,8 +79,12 @@

 static void sync_one_sb(struct super_block *sb, void *arg)
 {
-       if (!(sb->s_flags & MS_RDONLY))
-               __sync_filesystem(sb, *(int *)arg);
+       if (!(sb->s_flags & MS_RDONLY)) {
+               if (sb->s_flags & MS_MANDLOCK)
+                       printk("sync_one_sb skipping %p\n", sb);
+               else
+                       __sync_filesystem(sb, *(int *)arg);
+       }
 }
 /*
  * Sync all the data for all the filesystems (called by sys_sync() and
