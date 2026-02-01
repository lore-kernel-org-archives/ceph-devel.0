Received: from mail.chaospixel.com (mail.chaospixel.com [78.46.244.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B452E11BC
	for <ceph-devel@vger.kernel.org>; Sun,  1 Feb 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.244.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769935364; cv=none; b=I+eoPxr6zb5N0wudU1JNLZDFuZvCUe9cZX7I0DMJ5ruYN1vepFLIB3rpXVlW5jqkwK3btCaFxM8Do7uiNLrZRjMk2Gy+whJSCYplbQD4rpJlcKQ/7jTw+Mu/NwdAUqRM/WdV0OcQbcbnNc+xSHA0MoZAnC+/USRNWzGOJUcYZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769935364; c=relaxed/simple;
	bh=bSzJUgQisliCaNGD+SzeyjLlAcsArgrSb7cYOfbmHWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5BK0+2Z4YAV1ywE4/77QVRLp8vxXWjTJo/4YDrXdRNImq9ehDBtt2NJWgzy1zefrA+iG5tOntwbTVB9Ncob6t9wEMDMZihTW0tQpFBAiHAYzfF8ZaEV9B+5z/fPd6JU9J6b/SpKYH7ZzZk6feoomfYPNkLQIJMFUOjYQ3mj7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chaospixel.com; spf=pass smtp.mailfrom=chaospixel.com; dkim=pass (2048-bit key) header.d=chaospixel.com header.i=@chaospixel.com header.b=o9nu1HxL; arc=none smtp.client-ip=78.46.244.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chaospixel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaospixel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaospixel.com header.i=@chaospixel.com header.b="o9nu1HxL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chaospixel.com;
	s=201811; t=1769934995;
	bh=bSzJUgQisliCaNGD+SzeyjLlAcsArgrSb7cYOfbmHWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9nu1HxLqxsC3aYtQ1spocqihgPYcaLphXNjiBuQlCicFTRdLvx9bHcy3t9dnjt0v
	 KaWfYhVaCFdNzc2wEoWHuU0hBzKhyo0zSAHBFeC3AtiqK+g5eML6b8wJZf57A7weWP
	 GCS5NljhHU777EY5zSZZlmj4UvQedVoIm3kzSO0IffQb+EOVOqzosp/fXlV4ZjkfMx
	 A7K1FwZxo7TxzS44aJ0SKxHHWJLjouYJOCxNvWagYU0GVRrVCh868TN0qJsxAICPvu
	 S5+7XehkOAW+tXGQBG6gk/rV0QiK3bB+X/zHDcrOGcQsRgpqskvGpvN94j4KVZKaWQ
	 7LY2MRlI6JoIg==
Received: from pollux.home.lan (unknown [IPv6:2a02:8071:b8a:89e1:8b54:26ca:bca8:19fb])
	by mail.chaospixel.com (Postfix) with ESMTPSA id BD9F664D29AA;
	Sun,  1 Feb 2026 09:36:35 +0100 (CET)
From: Daniel Vogelbacher <daniel@chaospixel.com>
To: ceph-devel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com
Subject: [PATCH v2] fs/ceph: Fix kernel oops due invalid pointer for kfree() in parse_longname()
Date: Sun,  1 Feb 2026 09:34:01 +0100
Message-ID: <20260201083624.2093540-1-daniel@chaospixel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251220140153.1523907-1-daniel@chaospixel.com>
References: <20251220140153.1523907-1-daniel@chaospixel.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a kernel oops when reading ceph snapshot directories (.snap),
for example by simply run `ls /mnt/my_ceph/.snap`.

The bug was introduced in commit:

bb80f7618832 - parse_longname(): strrchr() expects NUL-terminated string

The variable str is guarded by __free(kfree), but advanced by one for
skipping the initial '_' in snapshot names. Thus, kfree() is called
with an invalid pointer.
This patch removes the need for advancing the pointer so kfree()
is called with correct memory pointer.

The full trace is:

[   53.703013] Oops: general protection fault, probably for non-canonical address 0xd0c22857c0000000: 0000 [#1] SMP PTI
[   53.703201] CPU: 11 UID: 0 PID: 360 Comm: kworker/11:2 Not tainted 6.18.0-rc7 #41 PREEMPT(voluntary)
[   53.703281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   53.703317] Workqueue: ceph-msgr ceph_con_workfn [libceph]
[   53.703424] RIP: 0010:rb_insert_color (/usr/src/linux/lib/rbtree.c:185 (discriminator 1) /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
[   53.704503] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 48 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 74 05 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
All code
========
   0:	76 17                	jbe    0x19
   2:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
   6:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
   a:	0f 84 b7 00 00 00    	je     0xc7
  10:	48 89 41 08          	mov    %rax,0x8(%rcx)
  14:	c3                   	ret
  15:	cc                   	int3
  16:	cc                   	int3
  17:	cc                   	int3
  18:	cc                   	int3
  19:	48 89 06             	mov    %rax,(%rsi)
  1c:	c3                   	ret
  1d:	cc                   	int3
  1e:	cc                   	int3
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  25:	48 85 c9             	test   %rcx,%rcx
  28:	74 05                	je     0x2f
  2a:*	f6 01 01             	testb  $0x1,(%rcx)		<-- trapping instruction
  2d:	74 1b                	je     0x4a
  2f:	48 8b 48 10          	mov    0x10(%rax),%rcx
  33:	48 39 f9             	cmp    %rdi,%rcx
  36:	74 68                	je     0xa0
  38:	48 89 c7             	mov    %rax,%rdi
  3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	f6 01 01             	testb  $0x1,(%rcx)
   3:	74 1b                	je     0x20
   5:	48 8b 48 10          	mov    0x10(%rax),%rcx
   9:	48 39 f9             	cmp    %rdi,%rcx
   c:	74 68                	je     0x76
   e:	48 89 c7             	mov    %rax,%rdi
  11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  15:	48                   	rex.W
[   53.704559] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
[   53.704591] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX: d0c22857c0000000
[   53.704616] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI: ffff8bd0c22855c0
[   53.704645] RBP: 0000000000002139 R08: 0000000000000000 R09: 0000000000000000
[   53.704668] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12: ffff8bd0c3e695b8
[   53.704691] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15: ffff8bd0c3e695c0
[   53.704714] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000) knlGS:0000000000000000
[   53.704741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.704762] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4: 0000000000772ef0
[   53.704790] PKRU: 55555554
[   53.704803] Call Trace:
[   53.704844]  <TASK>
[   53.704862] ceph_get_snapid_map (/usr/src/linux/./include/linux/spinlock.h:391 /usr/src/linux/fs/ceph/snap.c:1255) ceph
[   53.704957] ceph_fill_inode (/usr/src/linux/fs/ceph/inode.c:1062 (discriminator 2)) ceph
[   53.705019]  ? __pfx_ceph_set_ino_cb (/usr/src/linux/fs/ceph/inode.c:46) ceph
[   53.705074]  ? __pfx_ceph_ino_compare (/usr/src/linux/fs/ceph/super.h:595) ceph
[   53.705132] ceph_readdir_prepopulate (/usr/src/linux/fs/ceph/inode.c:2113) ceph
[   53.705191] mds_dispatch (/usr/src/linux/fs/ceph/mds_client.c:3993 /usr/src/linux/fs/ceph/mds_client.c:6299) ceph
[   53.705253]  ? sock_recvmsg (/usr/src/linux/net/socket.c:1078 (discriminator 1) /usr/src/linux/net/socket.c:1100 (discriminator 1))
[   53.705279] ceph_con_process_message (/usr/src/linux/net/ceph/messenger.c:1427) libceph
[   53.705347] process_message (/usr/src/linux/net/ceph/messenger_v2.c:2879) libceph
[   53.705406] ceph_con_v2_try_read (/usr/src/linux/net/ceph/messenger_v2.c:3043 /usr/src/linux/net/ceph/messenger_v2.c:3099 /usr/src/linux/net/ceph/messenger_v2.c:3148) libceph
[   53.705467]  ? psi_group_change (/usr/src/linux/kernel/sched/psi.c:876)
[   53.705488]  ? sched_balance_newidle (/usr/src/linux/kernel/sched/fair.c:12902 (discriminator 2))
[   53.705512]  ? psi_task_switch (/usr/src/linux/kernel/sched/psi.c:984 (discriminator 2))
[   53.705532]  ? _raw_spin_unlock (/usr/src/linux/./arch/x86/include/asm/paravirt.h:562 /usr/src/linux/./arch/x86/include/asm/qspinlock.h:57 /usr/src/linux/./include/linux/spinlock.h:204 /usr/src/linux/./include/linux/spinlock_api_smp.h:142 /usr/src/linux/kernel/locking/spinlock.c:186)
[   53.705550]  ? finish_task_switch.isra.0 (/usr/src/linux/./arch/x86/include/asm/paravirt.h:671 /usr/src/linux/kernel/sched/sched.h:1559 /usr/src/linux/kernel/sched/core.c:5073 /usr/src/linux/kernel/sched/core.c:5191)
[   53.705575] ceph_con_workfn (/usr/src/linux/net/ceph/messenger.c:1578) libceph
[   53.705627]  process_one_work (/usr/src/linux/./arch/x86/include/asm/jump_label.h:36 /usr/src/linux/./include/trace/events/workqueue.h:110 /usr/src/linux/kernel/workqueue.c:3268)
[   53.705657]  worker_thread (/usr/src/linux/kernel/workqueue.c:3340 (discriminator 2) /usr/src/linux/kernel/workqueue.c:3427 (discriminator 2))
[   53.705679]  ? __pfx_worker_thread (/usr/src/linux/kernel/workqueue.c:3373)
[   53.705700]  kthread (/usr/src/linux/kernel/kthread.c:463)
[   53.705717]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
[   53.705734]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
[   53.705752]  ret_from_fork (/usr/src/linux/arch/x86/kernel/process.c:164)
[   53.705776]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
[   53.705793]  ret_from_fork_asm (/usr/src/linux/arch/x86/entry/entry_64.S:255)
[   53.705826]  </TASK>
[   53.705842] Modules linked in: ceph netfs libceph cfg80211 rfkill 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common kvm_intel virtio_gpu joydev kvm drm_client_lib virtio_dma_buf evdev drm_shmem_helper sg drm_kms_helper virtio_balloon button irqbypass ghash_clmulni_intel aesni_intel rapl pcspkr drm configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock qemu_fw_cfg virtio_rng autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid hid sr_mod cdrom dm_mod ahci libahci libata xhci_pci iTCO_wdt intel_pmc_bxt xhci_hcd iTCO_vendor_support scsi_mod psmouse virtio_net i2c_i801 watchdog serio_raw i2c_smbus lpc_ich scsi_common usbcore net_failover failover virtio_blk usb_common
[   53.708740] ---[ end trace 0000000000000000 ]---
[   53.709462] RIP: 0010:rb_insert_color (/usr/src/linux/lib/rbtree.c:185 (discriminator 1) /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
[   53.710118] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 48 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 74 05 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
All code
========
   0:	76 17                	jbe    0x19
   2:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
   6:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
   a:	0f 84 b7 00 00 00    	je     0xc7
  10:	48 89 41 08          	mov    %rax,0x8(%rcx)
  14:	c3                   	ret
  15:	cc                   	int3
  16:	cc                   	int3
  17:	cc                   	int3
  18:	cc                   	int3
  19:	48 89 06             	mov    %rax,(%rsi)
  1c:	c3                   	ret
  1d:	cc                   	int3
  1e:	cc                   	int3
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  25:	48 85 c9             	test   %rcx,%rcx
  28:	74 05                	je     0x2f
  2a:*	f6 01 01             	testb  $0x1,(%rcx)		<-- trapping instruction
  2d:	74 1b                	je     0x4a
  2f:	48 8b 48 10          	mov    0x10(%rax),%rcx
  33:	48 39 f9             	cmp    %rdi,%rcx
  36:	74 68                	je     0xa0
  38:	48 89 c7             	mov    %rax,%rdi
  3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	f6 01 01             	testb  $0x1,(%rcx)
   3:	74 1b                	je     0x20
   5:	48 8b 48 10          	mov    0x10(%rax),%rcx
   9:	48 39 f9             	cmp    %rdi,%rcx
   c:	74 68                	je     0x76
   e:	48 89 c7             	mov    %rax,%rdi
  11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  15:	48                   	rex.W
[   53.711453] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
[   53.712112] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX: d0c22857c0000000
[   53.712798] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI: ffff8bd0c22855c0
[   53.713423] RBP: 0000000000002139 R08: 0000000000000000 R09: 0000000000000000
[   53.714061] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12: ffff8bd0c3e695b8
[   53.714696] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15: ffff8bd0c3e695c0
[   53.715321] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000) knlGS:0000000000000000
[   53.715956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.716651] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4: 0000000000772ef0
[   53.717295] PKRU: 55555554
[   53.717918] note: kworker/11:2[360] exited with preempt_count 1


Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220807
Fixes: bb80f7618832 - parse_longname(): strrchr() expects NUL-terminated string

Cc: stable@vger.kernel.org
Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Daniel Vogelbacher <daniel@chaospixel.com>
---
 fs/ceph/crypto.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 0ea4db650f85..9a115282f67d 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -166,12 +166,13 @@ static struct inode *parse_longname(const struct inode *parent,
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
 	char *name_end, *inode_number;
 	int ret = -EIO;
-	/* NUL-terminate */
-	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
+	/* Snapshot name must start with an underscore */
+	if (*name_len <= 0 || name[0] != '_')
+		return ERR_PTR(-EIO);
+	/* Skip initial '_' and NUL-terminate */
+	char *str __free(kfree) = kmemdup_nul(name + 1, *name_len - 1, GFP_KERNEL);
 	if (!str)
 		return ERR_PTR(-ENOMEM);
-	/* Skip initial '_' */
-	str++;
 	name_end = strrchr(str, '_');
 	if (!name_end) {
 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
-- 
2.47.3

