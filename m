From: Milosz Tanski <milosz@adfin.com>
Subject: hung task on page invalidate
Date: Sun, 29 Sep 2013 13:04:44 -0400
Message-ID: <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33872 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab3I2REp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Sep 2013 13:04:45 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so4530596wgh.4
        for <ceph-devel@vger.kernel.org>; Sun, 29 Sep 2013 10:04:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>

David,

In my test cluster I started seeing an issue when the fscache get
stuck waiting on pending writes when doing page invalidate. The
problem happens because it looks like the page never leaves the
cookie->store page tree.

I've been reading the different code paths in fscache/page.c to
understand why this could be the case, but on first look it looks like
it does the correct thing. Do you have any ideas what could be causing
this / where to look for the smoking gun.

I've only begun to see this recently, I think our work load on the
test cluster changed a bit and it's been showing up more.

Here's the backtrace:

INFO: task petabucket:5889 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
petabucket      D ffff880443513fc0     0  5889      1 0x00000000
 ffff8804239c3978 0000000000000282 0000000000000002 0000000000000000
 ffff880424f50000 ffff8804239c3fd8 ffff8804239c3fd8 ffff8804239c3fd8
 ffff88042c518000 ffff880424f50000 ffff8804239c3988 ffff88042aa5f4b0
Call Trace:
 [<ffffffff81568d09>] schedule+0x29/0x70
 [<ffffffffa01d4cbd>] __fscache_wait_on_page_write+0x6d/0xb0 [fscache]
 [<ffffffff81083520>] ? add_wait_queue+0x60/0x60
 [<ffffffffa02cd3f1>] ceph_invalidate_fscache_page+0x31/0x50 [ceph]
 [<ffffffffa02b0f00>] ceph_invalidatepage+0x70/0x190 [ceph]
 [<ffffffff8112656f>] ? delete_from_page_cache+0x5f/0x70
 [<ffffffff81133cab>] truncate_inode_page+0x8b/0x90
 [<ffffffff81133ded>] truncate_inode_pages_range.part.12+0x13d/0x620
 [<ffffffffa02b7b7a>] ? __ceph_caps_issued_mask+0xda/0x2b0 [ceph]
 [<ffffffff8119c338>] ? iput+0x48/0x190
 [<ffffffff811a9735>] ? __inode_wait_for_writeback+0x65/0xc0
 [<ffffffff8113431d>] truncate_inode_pages_range+0x4d/0x60
 [<ffffffff811343b5>] truncate_inode_pages+0x15/0x20
 [<ffffffff8119bbf6>] evict+0x1a6/0x1b0
 [<ffffffff8119c3f3>] iput+0x103/0x190
 [<ffffffff81196d88>] dentry_iput+0x98/0xe0
 [<ffffffff81198a4c>] dput+0x12c/0x1e0
 [<ffffffff8118d4b0>] lookup_fast+0x2a0/0x2f0
 [<ffffffff8118e700>] path_lookupat+0x100/0x7a0
 [<ffffffff81132c4f>] ? release_pages+0x1af/0x200
 [<ffffffff8118edd4>] filename_lookup+0x34/0xc0
 [<ffffffff81192139>] user_path_at_empty+0x59/0xa0
 [<ffffffffa02a9f36>] ? ceph_getattr+0x46/0x100 [ceph]
 [<ffffffff811a0199>] ? mntput_no_expire+0x49/0x160
 [<ffffffff81187127>] ? cp_new_stat+0x107/0x120
 [<ffffffff81192191>] user_path_at+0x11/0x20
 [<ffffffff811873a1>] vfs_fstatat+0x51/0xb0
 [<ffffffff811874cb>] vfs_stat+0x1b/0x20
 [<ffffffff811874e5>] SYSC_newstat+0x15/0x30
 [<ffffffff8118763e>] SyS_newstat+0xe/0x10
 [<ffffffff81572d99>] system_call_fastpath+0x16/0x1b
