Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [162.219.34.252])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE59271A71
	for <ceph-devel@vger.kernel.org>; Sat, 18 Apr 2026 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.219.34.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485972; cv=none; b=fI3hQ5RJ1unzGL2VB4yNJJnc9S1VIwRul0p6DDvm/UT0jKST6Kjci2+8ItkMDa+zTvZ0mVzryTCaAm2dxCcMLpcxlYXTeMZebDoSRJzMhq1bKLFLOL4rshlZSps89/+a03P8OwJI2IVJ1PFhTo08AZiwc03m/VHGCwQiFf0G0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485972; c=relaxed/simple;
	bh=ZOFtmde80Vm0D+X+463lLcyf38eSrIEidpkIWIGatJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bleo3McwOxYGh1S+7eyOTbfSOLsvmCLoXDy8q5LLYKuYMGLcBfktyZ5yVehRJJ7wwZ7Vv893evfrJZJQdcZWFRsHQONrQ9dJPIXFurf3vRIqknaV8PYKOCk5CnXh6wQvxFbvhFYl8iuI5l4huc3DZX/GtOt81u6h93bKL5W7ZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=V43IqYzj; arc=none smtp.client-ip=162.219.34.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="V43IqYzj"
Received: from m7-spam01.kuaishou.com (unknown [172.28.1.161])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id 1BC172263;
	Sat, 18 Apr 2026 12:10:21 +0800 (CST)
Received: from bjxm-pm-mail03.kuaishou.com (unknown [172.28.128.3])
	by m7-spam01.kuaishou.com (Postfix) with ESMTPS id 4fyJF45ZgBz1XLg2F;
	Sat, 18 Apr 2026 12:10:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1776485416; h=from:subject:to:date:message-id;
	bh=TNB7LScT/Y6Fs8gfXfonsSdA9X00cOGev3H5xXA071c=;
	b=V43IqYzjOEBVufNBKy4m4tU+/Vfjpjsr4+SdOjyG6RSlkKqXEVJfGFBztgxycgNKuPvxxy3mjyb
	6h35Lp2BYZXwiobf2uPIsAI88gbJdbtEWLzt4vFumhQxtELZNVol+VxX1bNvdTqgX03iQexwoKLgb
	OpZaH6a2WVFPB/6pTiI=
Received: from localhost.localdomain (172.28.1.32) by
 bjxm-pm-mail03.kuaishou.com (172.28.128.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Sat, 18 Apr 2026 12:10:16 +0800
From: Li Lei <lilei24@kuaishou.com>
To: <idryomov@gmail.com>, <amarkuze@redhat.com>, <slava@dubeyko.com>,
	<mchangir@redhat.com>, <xiubli@redhat.com>
CC: <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lilei24@kuaishou.com>
Subject: [PATCH] ceph: fix potential stray locked folios during umount
Date: Sat, 18 Apr 2026 12:10:08 +0800
Message-ID: <20260418041008.16294-1-lilei24@kuaishou.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjm7-pm-mail05.kuaishou.com (172.28.1.5) To
 bjxm-pm-mail03.kuaishou.com (172.28.128.3)

During umount, we only wait for stopping_blockers to drop to zero for
a certain time specified by mount_timeout, and continue the rest of
the procedure even if there are inflight requests. This behavior may
leave some folios locked even after the cephfs umounted, which causes
other kernel threads to hung.

Buffered read process calls filemap_update_page() and waits on
folio_put_wait_locked() with TASK_KILLABLE flag set, which means this
process could be killed and the filesystem could be umount successfully
(no file opened in it). Umount calls truncate_inode_pages() and waits
on locked pages for those inodes whose i_count == 0. In these way,
there would be no locked folios for this filesystem left in system
after umount exits.

However, things are different for cephfs. Cephfs calls ihold() and
submits osd request for buffered read and gets folio locked. Once the
buffered read process is killed, the inode will be skipped in
evict_inodes(), because its i_count > 0. Forthemore, the folios are
still locked. It can only be unlocked in netfs_unlock_read_folio().

stopping_blocks should block umount from proceeding, but it only waits
for mount_timeout (default 60s) even if there are still flying request
out there, leaving stray locked folios. Other kthread, like kcompactd
, could be stuck on those locked folioes forever.

Steps to Reproduce:
1. echo 3 > /proc/sys/vm/drop_caches.
2. dd if=cephfs/xxx.img of=/dev/null
    Make sure cephfs/xxx.img is big enough to make time for us to do the
    following command
3. execute 'systemctl stop ceph-osd@*' on the osd nodes
    It would be great if you have a tiny cluster. Stopping all the osds
    would be much easier.
4. kill -9 `pidof dd`.
    Buffered read process must be killed at that moment. But inflight
    read requests can be observed in the /sys/kernel/debug/ceph/xxxx/osdc
5. umount cephfs
    Wait for 60s if you mount cephfs by using the default mount option.

We got the warning:
ceph: [b2c9a006-9ad8-48e9-8257-6fb1e1b91014 66562]: umount timed out, 0
VFS: Busy inodes after unmount of ceph (ceph)

if check_data_corruption option disable, kcompactd may stuck in the
future. If it is eanbled, we catch the bug immediately.

[94543.042953] ------------[ cut here ]------------
[94543.049391] kernel BUG at fs/super.c:654!
[94543.054171] Oops: invalid opcode: 0000 [#1] SMP PTI
[94543.059881] CPU: 25 UID: 0 PID: 3451674 Comm: umount Kdump: loaded Tainted: G S         OE       7.0.0-dirty #2 PREEMPTLAZY
[94543.072678] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[94543.080918] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
[94543.089755] RIP: 0010:generic_shutdown_super+0x111/0x120
[94543.095982] Code: cc cc e8 c2 1f ef ff 48 8b bb d0 00 00 00 eb db 48 8b 43 28 48 8d b3 98 03 00 00 48 c7 c7 90 09 55 8c 48 8b 10 e8 0f c3 cc ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
[94543.117607] RSP: 0018:ffffce35f8c53d40 EFLAGS: 00010246
[94543.123793] RAX: 000000000000002d RBX: ffff8ba94d0d9000 RCX: 0000000000000000
[94543.132125] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8bc0df91c600
[94543.140460] RBP: ffffffffc13b52c0 R08: 0000000000000000 R09: ffffce35f8c53be0
[94543.148801] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8ba94af0e000
[94543.157150] R13: ffff8ba94d0d9000 R14: 0000000000000004 R15: ffff8ba946d9a000
[94543.165505] FS:  00007fb1c607c840(0000) GS:ffff8bc1520e4000(0000) knlGS:0000000000000000
[94543.174943] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[94543.181769] CR2: 00000000d64e5000 CR3: 000000189c9f2002 CR4: 00000000003726f0
[94543.190160] Call Trace:
[94543.193317]  <TASK>
[94543.196088]  kill_anon_super+0x12/0x40
[94543.200719]  ceph_kill_sb+0xda/0x2c0 [ceph]
[94543.205877]  ? radix_tree_delete_item+0x68/0xd0
[94543.211395]  deactivate_locked_super+0x31/0xb0
[94543.216815]  cleanup_mnt+0xcb/0x110
[94543.221169]  task_work_run+0x58/0x80
[94543.225629]  exit_to_user_mode_loop+0x13f/0x4d0
[94543.231163]  do_syscall_64+0x1ef/0x840
[94543.235827]  ? do_syscall_64+0x101/0x840
[94543.240687]  ? do_user_addr_fault+0x20e/0x6b0
[94543.246036]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[94543.252166] RIP: 0033:0x7fb1c5f0ccab
[94543.256650] Code: 73 31 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 39 31 0e 00 f7 d8
[94543.278690] RSP: 002b:00007ffe96f80ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[94543.287710] RAX: 0000000000000000 RBX: 00007fb1c61fb264 RCX: 00007fb1c5f0ccab
[94543.296251] RDX: fffffffffffffe88 RSI: 0000000000000000 RDI: 000055ae9dcc6ec0
[94543.304801] RBP: 000055ae9dcc6c90 R08: 0000000000000000 R09: 00007ffe96f7fc50
[94543.313358] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[94543.321922] R13: 000055ae9dcc6ec0 R14: 000055ae9dcc6da0 R15: 0000000000000000

So make it wait until all the flying requests returns for clean and safe
umount.

Fixes: 1464de9f813e ("ceph: wait for OSD requests' callbacks to finish when unmounting")
Signed-off-by: Li Lei <lilei24@kuaishou.com>
---
 fs/ceph/super.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2aed6b3..48e63c1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1569,13 +1569,10 @@ static void ceph_kill_sb(struct super_block *s)
 	spin_unlock(&mdsc->stopping_lock);
 
 	if (wait && atomic_read(&mdsc->stopping_blockers)) {
-		long timeleft = wait_for_completion_killable_timeout(
-					&mdsc->stopping_waiter,
-					fsc->client->options->mount_timeout);
-		if (!timeleft) /* timed out */
-			pr_warn_client(cl, "umount timed out, %ld\n", timeleft);
-		else if (timeleft < 0) /* killed */
-			pr_warn_client(cl, "umount was killed, %ld\n", timeleft);
+		int rc = wait_for_completion_killable(
+					&mdsc->stopping_waiter);
+		if (rc < 0) /* killed */
+			pr_warn_client(cl, "umount was killed\n");
 	}
 
 	mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
-- 
1.8.3.1

