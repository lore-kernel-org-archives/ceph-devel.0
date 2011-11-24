From: Christian Brunner <chb@muc.de>
Subject: pginfo updates
Date: Thu, 24 Nov 2011 12:33:24 +0100
Message-ID: <CAO47_-_WLRby4m9rAvdUyCJu+_+33uHp90XPOnRJ0M=0JohouQ@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39100 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1KXLdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Nov 2011 06:33:25 -0500
Received: by vbbfc26 with SMTP id fc26so1404660vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Nov 2011 03:33:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm running a btrfs-debug patch on one of our nodes. This patch prints
calls to btrfs_orphan_add. I'm still waiting for the problem the patch
was intended to trace, but in the logs I found something ceph related
I don't understand:

When I look at the btrfs_orphan_add messages there is one inode that
is updated over and over again. When I count the inodes in my log, I
can see the following distribution (only inodes with more than 500
btrfs_orphan_add calls listed):

   #cnt     Inode
   1117  7403
  17218  7457
    848  7484
    539  7984
   1446  9098
    635  9346

When I look at the filesysteme, I can see that inode 7457 belongs to:

current/meta/DIR_8/DIR_A/pginfo\u2.8d__0_28D2BFA8

I don't know how the pginfo stuff works, but I really wonder why the
distribution is so uneven.

"strace -f | grep 28D2BFA8" is giving me the this output:

[...]
[pid  3840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=8, ...}) = 0
[pid  3840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=8, ...}) = 0
[pid  3840] truncate("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
0) = 0
[pid  3840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=0, ...}) = 0
[pid  3840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=0, ...}) = 0
[pid  3840] open("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
O_WRONLY|O_CREAT, 0644) = 64
[pid  3841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=8, ...}) = 0
[pid  3841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=8, ...}) = 0
[pid  3841] truncate("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
0) = 0
[pid  3841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=0, ...}) = 0
[pid  3841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
{st_mode=S_IFREG|0644, st_size=0, ...}) = 0
[pid  3841] open("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__0_28D16932",
O_WRONLY|O_CREAT, 0644) = 64
[...]

Regards,
Christian
