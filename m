Received: from mail.chaospixel.com (mail.chaospixel.com [78.46.244.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5A43CEF7
	for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.244.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916916; cv=none; b=gJi8k7vgZtVhih2cBW5wKEkk1ZMjOx/u7cGx+s8ag3nSt/+mIgVop9Pzttju378904ZJR/w7sGu1Sjw0GDaZUIBv1WDf2Vydr1wxy0x/MNMnJ1bHU4c7RIe9PJv1bybKkESlrRqdEWe+S+46WgJuleALD+0AdigFcO4X0owr1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916916; c=relaxed/simple;
	bh=hVhoe9iGYV0v2uoUH+RgLvDvVkg72xQU39Hr5Jez020=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGD/QH0rGmtHRL1Ok9zzrILBmM5mO09YUOtlbfh7o0nCTL0Ypa1hneOgpBKqaKH6xUPah8EgK6VrNHfAXT5Buccn1E1oYcfVPVmeUb3swLsTlL8ICOyHoFGJzTCpJRcin//KgtVgXUA6x2rzL8msc+zUmWXCvZuTuQLSzssZzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chaospixel.com; spf=pass smtp.mailfrom=chaospixel.com; dkim=pass (2048-bit key) header.d=chaospixel.com header.i=@chaospixel.com header.b=xhuRSzEG; arc=none smtp.client-ip=78.46.244.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chaospixel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaospixel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaospixel.com header.i=@chaospixel.com header.b="xhuRSzEG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chaospixel.com;
	s=201811; t=1768916526;
	bh=hVhoe9iGYV0v2uoUH+RgLvDvVkg72xQU39Hr5Jez020=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xhuRSzEGtzOr1gTXlLsD0XN/bBEpfNcNQmVIrqrxR5bDgJfsuDjWUf/vX5JCzjrzO
	 PtCXiC0divUZAXtmxxEi6134NCX6u676TdjDv/lrTwfJW99P/Iv2OVfzeQ8rcgoIiD
	 BzTKOk/fcNScL1V30upda6RZyNR/uehohgw+bPCEPKk4fUIurVk0XYI+N/noqa/Nin
	 45aZsNFsnjyFsNwJZ7Not4q8e9/o6Y6AVe2nJGXVNpZ4jzJPpjXtIXGuWEUl7LXsiS
	 djjGaDfzChQRlIjGVJqHCjzOU9SKUgN7POkjWPKHgphnEJyGxoablb8cNcH6rFOTw5
	 St9rRWb+WDt+w==
Received: from antares.home.lan (unknown [IPv6:2a01:5c0:5:3c6:4498:99f:16b9:fb01])
	by mail.chaospixel.com (Postfix) with ESMTPSA id 32477649D30C;
	Tue, 20 Jan 2026 14:42:06 +0100 (CET)
Date: Tue, 20 Jan 2026 14:42:04 +0100
From: Daniel Vogelbacher <daniel@chaospixel.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>
Subject: Re: [PATCH] fs/ceph: Fix kernel oops due invalid pointer for kfree()
 in parse_longname()
Message-ID: <4ubz2itqxjbq4ubpqcwgv6hsaszbxo5tqjjucfpfrpkho4gc5a@xhzucdi5eepg>
References: <20251220140153.1523907-1-daniel@chaospixel.com>
 <62924ea8997fb174034e6333db3a52b2f30f0e68.camel@ibm.com>
 <95555273-fa9a-48fa-855e-ca1e71f4c903@chaospixel.com>
 <180a7f3f6965b69298fbfd90806aee3102c5abb8.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <180a7f3f6965b69298fbfd90806aee3102c5abb8.camel@ibm.com>

On Tue, Dec 23, 2025 at 10:49:36PM +0000, Viacheslav Dubeyko wrote:
> On Mon, 2025-12-22 at 22:26 +0100, Daniel Vogelbacher wrote:
> > On 12/22/25 21:08, Viacheslav Dubeyko wrote:
> > > On Sat, 2025-12-20 at 15:01 +0100, Daniel Vogelbacher wrote:
> > > > This fixes a kernel oops when reading ceph snapshot directories (.snap),
> > > > for example by simply run `ls /mnt/my_ceph/.snap`.
> > > > 
> > > 
> > > Frankly speaking, it's completely not clear how this kernel oops can happen.
> > > Could you please explain in more details how it can happen and what is the
> > > nature of the issue? How the issue can be reproduced?
> > 
> > All I need to reproduce the issue is to run `ls .snap/` on any mounted 
> > cephfs mountpoint that contains scheduled snapshots. I've one prod VM 
> > (KVM) where I hit the issue after a Debian Trixie upgrade. To isolate 
> > it, I've created a fresh Trixie VM, dropped the distribution kernel and 
> > built a vanilla kernel to isolate the buggy commit by using git-bisect - 
> > and to ensure the bug was not introduced by any Debian patches. If that 
> > helps, it's a Squid 19.2.3 cluster.
> > 
> > So basically the steps are:
> > 
> >   * Setup a Ceph cluster with 19.2.3
> >   * Create a pool and cephfs
> >   * Create schedule snapshots for the fs
> >   * Mount the fs and populate it with a few files on any kernel version 
> > that contains bb80f7618832, that is >=6.12.41
> >   * Wait until there are scheduled snapshots created
> >   * run `ls /mnt/my/cephfs/.snap`
> 
> It will be good to see the particular command that everyone can run to reproduce
> the issue. You don't need to share the command for setup Ceph cluster, creating
> pool and CephFS instance. But the rest steps are really important because mount
> options and details of command that you run can change everything.

These are the steps to reproduce on a new VM:

# echo "samba-fileserver@.files=/volumes/datapool/stuff/3461082b-ecc9-4e82-8549-3fd2590d3fb6      /mnt/test/stuff   ceph     acl,noatime,_netdev    0       0" >> /etc/fstab

Reboot the system
# systemctl reboot

Check if it's really mounted
# mount | grep stuff

List snapshots (expected 63 snapshots)
# ls /mnt/test/stuff/.snap

Now ls hangs forever and the kernel log shows the oops.

> 
> > 
> > This should result in a kernel oops like:
> 
> The commit message could include oops details.
> 
> > 
> > [   53.703013] Oops: general protection fault, probably for 
> > non-canonical address 0xd0c22857c0000000: 0000 [#1] SMP PTI
> > [   53.703201] CPU: 11 UID: 0 PID: 360 Comm: kworker/11:2 Not tainted 
> > 6.18.0-rc7 #41 PREEMPT(voluntary)
> > [   53.703281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> > 1.16.2-debian-1.16.2-1 04/01/2014
> > [   53.703317] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> > [   53.703424] RIP: 0010:rb_insert_color 
> > (/usr/src/linux/lib/rbtree.c:185 (discriminator 1) 
> > /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
> > [   53.704503] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 48 
> > 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 74 
> > 05 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
> > All code
> > ========
> >     0:	76 17                	jbe    0x19
> >     2:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
> >     6:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
> >     a:	0f 84 b7 00 00 00    	je     0xc7
> >    10:	48 89 41 08          	mov    %rax,0x8(%rcx)
> >    14:	c3                   	ret
> >    15:	cc                   	int3
> >    16:	cc                   	int3
> >    17:	cc                   	int3
> >    18:	cc                   	int3
> >    19:	48 89 06             	mov    %rax,(%rsi)
> >    1c:	c3                   	ret
> >    1d:	cc                   	int3
> >    1e:	cc                   	int3
> >    1f:	cc                   	int3
> >    20:	cc                   	int3
> >    21:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
> >    25:	48 85 c9             	test   %rcx,%rcx
> >    28:	74 05                	je     0x2f
> >    2a:*	f6 01 01             	testb  $0x1,(%rcx)		<-- trapping instruction
> >    2d:	74 1b                	je     0x4a
> >    2f:	48 8b 48 10          	mov    0x10(%rax),%rcx
> >    33:	48 39 f9             	cmp    %rdi,%rcx
> >    36:	74 68                	je     0xa0
> >    38:	48 89 c7             	mov    %rax,%rdi
> >    3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> >    3f:	48                   	rex.W
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >     0:	f6 01 01             	testb  $0x1,(%rcx)
> >     3:	74 1b                	je     0x20
> >     5:	48 8b 48 10          	mov    0x10(%rax),%rcx
> >     9:	48 39 f9             	cmp    %rdi,%rcx
> >     c:	74 68                	je     0x76
> >     e:	48 89 c7             	mov    %rax,%rdi
> >    11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> >    15:	48                   	rex.W
> > [   53.704559] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
> > [   53.704591] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX: 
> > d0c22857c0000000
> > [   53.704616] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI: 
> > ffff8bd0c22855c0
> > [   53.704645] RBP: 0000000000002139 R08: 0000000000000000 R09: 
> > 0000000000000000
> > [   53.704668] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12: 
> > ffff8bd0c3e695b8
> > [   53.704691] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15: 
> > ffff8bd0c3e695c0
> > [   53.704714] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000) 
> > knlGS:0000000000000000
> > [   53.704741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   53.704762] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4: 
> > 0000000000772ef0
> > [   53.704790] PKRU: 55555554
> > [   53.704803] Call Trace:
> > [   53.704844]  <TASK>
> > [   53.704862] ceph_get_snapid_map 
> > (/usr/src/linux/./include/linux/spinlock.h:391 
> > /usr/src/linux/fs/ceph/snap.c:1255) ceph
> > [   53.704957] ceph_fill_inode (/usr/src/linux/fs/ceph/inode.c:1062 
> > (discriminator 2)) ceph
> > [   53.705019]  ? __pfx_ceph_set_ino_cb 
> > (/usr/src/linux/fs/ceph/inode.c:46) ceph
> > [   53.705074]  ? __pfx_ceph_ino_compare 
> > (/usr/src/linux/fs/ceph/super.h:595) ceph
> > [   53.705132] ceph_readdir_prepopulate 
> > (/usr/src/linux/fs/ceph/inode.c:2113) ceph
> > [   53.705191] mds_dispatch (/usr/src/linux/fs/ceph/mds_client.c:3993 
> > /usr/src/linux/fs/ceph/mds_client.c:6299) ceph
> > [   53.705253]  ? sock_recvmsg (/usr/src/linux/net/socket.c:1078 
> > (discriminator 1) /usr/src/linux/net/socket.c:1100 (discriminator 1))
> > [   53.705279] ceph_con_process_message 
> > (/usr/src/linux/net/ceph/messenger.c:1427) libceph
> > [   53.705347] process_message 
> > (/usr/src/linux/net/ceph/messenger_v2.c:2879) libceph
> > [   53.705406] ceph_con_v2_try_read 
> > (/usr/src/linux/net/ceph/messenger_v2.c:3043 
> > /usr/src/linux/net/ceph/messenger_v2.c:3099 
> > /usr/src/linux/net/ceph/messenger_v2.c:3148) libceph
> > [   53.705467]  ? psi_group_change (/usr/src/linux/kernel/sched/psi.c:876)
> > [   53.705488]  ? sched_balance_newidle 
> > (/usr/src/linux/kernel/sched/fair.c:12902 (discriminator 2))
> > [   53.705512]  ? psi_task_switch (/usr/src/linux/kernel/sched/psi.c:984 
> > (discriminator 2))
> > [   53.705532]  ? _raw_spin_unlock 
> > (/usr/src/linux/./arch/x86/include/asm/paravirt.h:562 
> > /usr/src/linux/./arch/x86/include/asm/qspinlock.h:57 
> > /usr/src/linux/./include/linux/spinlock.h:204 
> > /usr/src/linux/./include/linux/spinlock_api_smp.h:142 
> > /usr/src/linux/kernel/locking/spinlock.c:186)
> > [   53.705550]  ? finish_task_switch.isra.0 
> > (/usr/src/linux/./arch/x86/include/asm/paravirt.h:671 
> > /usr/src/linux/kernel/sched/sched.h:1559 
> > /usr/src/linux/kernel/sched/core.c:5073 
> > /usr/src/linux/kernel/sched/core.c:5191)
> > [   53.705575] ceph_con_workfn 
> > (/usr/src/linux/net/ceph/messenger.c:1578) libceph
> > [   53.705627]  process_one_work 
> > (/usr/src/linux/./arch/x86/include/asm/jump_label.h:36 
> > /usr/src/linux/./include/trace/events/workqueue.h:110 
> > /usr/src/linux/kernel/workqueue.c:3268)
> > [   53.705657]  worker_thread (/usr/src/linux/kernel/workqueue.c:3340 
> > (discriminator 2) /usr/src/linux/kernel/workqueue.c:3427 (discriminator 2))
> > [   53.705679]  ? __pfx_worker_thread 
> > (/usr/src/linux/kernel/workqueue.c:3373)
> > [   53.705700]  kthread (/usr/src/linux/kernel/kthread.c:463)
> > [   53.705717]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > [   53.705734]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > [   53.705752]  ret_from_fork (/usr/src/linux/arch/x86/kernel/process.c:164)
> > [   53.705776]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > [   53.705793]  ret_from_fork_asm 
> > (/usr/src/linux/arch/x86/entry/entry_64.S:255)
> > [   53.705826]  </TASK>
> > [   53.705842] Modules linked in: ceph netfs libceph cfg80211 rfkill 
> > 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common 
> > intel_uncore_frequency_common kvm_intel virtio_gpu joydev kvm 
> > drm_client_lib virtio_dma_buf evdev drm_shmem_helper sg drm_kms_helper 
> > virtio_balloon button irqbypass ghash_clmulni_intel aesni_intel rapl 
> > pcspkr drm configfs efi_pstore nfnetlink vsock_loopback 
> > vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci 
> > vsock qemu_fw_cfg virtio_rng autofs4 ext4 crc16 mbcache jbd2 hid_generic 
> > usbhid hid sr_mod cdrom dm_mod ahci libahci libata xhci_pci iTCO_wdt 
> > intel_pmc_bxt xhci_hcd iTCO_vendor_support scsi_mod psmouse virtio_net 
> > i2c_i801 watchdog serio_raw i2c_smbus lpc_ich scsi_common usbcore 
> > net_failover failover virtio_blk usb_common
> > [   53.708740] ---[ end trace 0000000000000000 ]---
> > [   53.709462] RIP: 0010:rb_insert_color 
> > (/usr/src/linux/lib/rbtree.c:185 (discriminator 1) 
> > /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
> > [   53.710118] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 48 
> > 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 74 
> > 05 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
> > All code
> > ========
> >     0:	76 17                	jbe    0x19
> >     2:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
> >     6:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
> >     a:	0f 84 b7 00 00 00    	je     0xc7
> >    10:	48 89 41 08          	mov    %rax,0x8(%rcx)
> >    14:	c3                   	ret
> >    15:	cc                   	int3
> >    16:	cc                   	int3
> >    17:	cc                   	int3
> >    18:	cc                   	int3
> >    19:	48 89 06             	mov    %rax,(%rsi)
> >    1c:	c3                   	ret
> >    1d:	cc                   	int3
> >    1e:	cc                   	int3
> >    1f:	cc                   	int3
> >    20:	cc                   	int3
> >    21:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
> >    25:	48 85 c9             	test   %rcx,%rcx
> >    28:	74 05                	je     0x2f
> >    2a:*	f6 01 01             	testb  $0x1,(%rcx)		<-- trapping instruction
> >    2d:	74 1b                	je     0x4a
> >    2f:	48 8b 48 10          	mov    0x10(%rax),%rcx
> >    33:	48 39 f9             	cmp    %rdi,%rcx
> >    36:	74 68                	je     0xa0
> >    38:	48 89 c7             	mov    %rax,%rdi
> >    3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> >    3f:	48                   	rex.W
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >     0:	f6 01 01             	testb  $0x1,(%rcx)
> >     3:	74 1b                	je     0x20
> >     5:	48 8b 48 10          	mov    0x10(%rax),%rcx
> >     9:	48 39 f9             	cmp    %rdi,%rcx
> >     c:	74 68                	je     0x76
> >     e:	48 89 c7             	mov    %rax,%rdi
> >    11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> >    15:	48                   	rex.W
> > [   53.711453] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
> > [   53.712112] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX: 
> > d0c22857c0000000
> > [   53.712798] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI: 
> > ffff8bd0c22855c0
> > [   53.713423] RBP: 0000000000002139 R08: 0000000000000000 R09: 
> > 0000000000000000
> > [   53.714061] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12: 
> > ffff8bd0c3e695b8
> > [   53.714696] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15: 
> > ffff8bd0c3e695c0
> > [   53.715321] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000) 
> > knlGS:0000000000000000
> > [   53.715956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   53.716651] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4: 
> > 0000000000772ef0
> > [   53.717295] PKRU: 55555554
> > [   53.717918] note: kworker/11:2[360] exited with preempt_count 1
> > 
> > 
> > > > The bug was introduced in commit:
> > > > 
> > > > bb80f7618832 - parse_longname(): strrchr() expects NUL-terminated string
> > > > 
> > > > str is guarded by __free(kfree), but advanced later for skipping
> > > > the initial '_' in snapshot names.
> > > > This patch removes the need for advancing the pointer so kfree()
> > > > could do proper memory cleanup.
> > > > 
> > > 
> > > I cannot follow of this explanation. What is the wrong? Why should we fix
> > > something here?
> > 
> > In bb80f7618832, the pointer in variable "str" is guarded by 
> > __free(kfree), which means the pointer returned by kmemdup_nul() is 
> > automatically freed. kfree() should receive the same pointer as returned 
> > by kmemdump_nul(), but this is not the case, as the pointer is advanced 
> > by one. kmemdup_nul() may return for example 0x1234000, but kfree() is 
> > called with 0x1234001. I don't know the exact behavior of kfree(), but I 
> > assume calling kfree() with random pointers leads to UB?
> 
> Please, see my comments below.
> 
> > 
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220807  
> > > > 
> > > 
> > > Why the issue had not been reported to CephFS community through email or by
> > > means of https://tracker.ceph.com?  
> > It's a kernel bug and not related to any ceph packages, so I've reported 
> > it to the kernel issue tracking system.
> > 
> > > Have you run xfstests for your patch?
> > No, not aware of it. How is xfs related to cephfs?
> 
> The xfstests is the regression testing suite that is used for testing all of
> Linux file systems (and CephFS too). But if you are not file system guy, then
> it's OK that you didn't run the xfstests.
> 
> > 
> > 
> > > > Fixes: bb80f7618832 - parse_longname(): strrchr() expects NUL-terminated string
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Helge Deller <deller@gmx.de>
> > > > Signed-off-by: Daniel Vogelbacher <daniel@chaospixel.com>
> > > > ---
> > > >   fs/ceph/crypto.c | 8 ++++----
> > > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > > index 0ea4db650f85..3e051972e49d 100644
> > > > --- a/fs/ceph/crypto.c
> > > > +++ b/fs/ceph/crypto.c
> > > > @@ -166,12 +166,12 @@ static struct inode *parse_longname(const struct inode *parent,
> > > >   	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
> > > >   	char *name_end, *inode_number;
> > > >   	int ret = -EIO;
> > > > -	/* NUL-terminate */
> > > > -	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
> > > > +	if (*name_len <= 1)
> > > 
> > > I believe that even if we have *name_len <= 1, then current logic can manage it.
> > > Why do we need this fix? The commit message sounds really unclear for my taste.
> > > Could you prove that we really need this fix?
> > 
> > I've added this protection because otherwise I do pointer arithmetic 
> > without checking bounds. I couldn't give you a better excuse :) I could
> > simply remove it on your request.
> > 
> 
> OK. Let's analyze the code again.
> 
> 	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
> 	if (!str)
> 		return ERR_PTR(-ENOMEM);
> 	/* Skip initial '_' */
> 	str++;
> 	name_end = strrchr(str, '_');
> 	if (!name_end) {
> 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> 		return ERR_PTR(-EIO);
> 	}
> 	*name_len = (name_end - str);
> 	if (*name_len <= 0) {
> 		pr_err_client(cl, "failed to parse long snapshot name\n");
> 		return ERR_PTR(-EIO);
> 	}
> 
> First of all, we try to create a NULL-terminated string from unterminated data.
> If we provide name_len == 0, then we should allocate 1 byte/symbol string that
> contains only termination symbol. Potentially, we could not allocate memory at
> all if we are under memory pressure (this situation is managed by !str check).
> However, it doesn't make sense to try to allocate memory at that case. So, the
> length check at the beginning makes sense:
> 
> 	if (*name_len <= 0)
> 		return ERR_PTR(-EIO);
> 
> Next, we expect to have '_' at the beginning. Let's imagine that we don't have
> any '_' in the provided string, then it make sense to try to allocate memory. I
> suggest to call this next:
> 
>         name_end = strnchr(name, *name_len, '_');
>         if (!name_end) {
> 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> 		return ERR_PTR(-EIO);
> 	} else if (name != name_end) {
>                 /* we expect '_' at the beginning */
> 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> 		return ERR_PTR(-EIO);
>         }

We don't have the `str` variable here yet. I suggest I can simplify this all by:

@ -166,7 +166,8 @@ static struct inode *parse_longname(const struct inode *parent,
        struct ceph_vino vino = { .snap = CEPH_NOSNAP };
        char *name_end, *inode_number;
        int ret = -EIO;
-       if (*name_len <= 1)
+       /* Snapshot name must start with an underscore */
+       if (*name_len <= 0 || name[0] != '_')
                return ERR_PTR(-EIO);
        /* Skip initial '_' and NUL-terminate */
        char *str __free(kfree) = kmemdup_nul(name + 1, *name_len - 1, GFP_KERNEL);



> If we have found the first instance of '_' at the beginning of name, then it
> makes sense to continue logic.
> 
>         if (*name_len <= 1)
> 		return ERR_PTR(-EIO);

See my comment above.

> And here we can continue the existing logic:
> 
> 	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
> 	if (!str)
> 		return ERR_PTR(-ENOMEM);
> 	/* Skip initial '_' */
> 	str++;
> 	name_end = strrchr(str, '_');
> 	if (!name_end) {
> 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> 		return ERR_PTR(-EIO);
> 	}
> 	*name_len = (name_end - str);
> 	if (*name_len <= 0) {
> 		pr_err_client(cl, "failed to parse long snapshot name\n");
> 		return ERR_PTR(-EIO);
> 	}
> 
> Does this logic make sense to you?

My simplified logic comes with the cost of potentially allocating memory for a
snapshot name that has no second underscore. But from my understanding, this
naming scheme is by convention for Ceph snapshot names, so this should not
happen in practice.

> 
> However, I have started to think... Could we completely remove the kmemdup_nul()
> and to operate with the initial name only? I think it's possible, we simply need
> to use much smarter technique of string analysis. What do you think? It will be
> good to exclude the memory allocation here.

I'm not a kernel nor ceph developer and it seems that most functions used here
don't have a variant for non null terminated strings. I assume it would be much extra
work just to remove the allocation entirely.

--
Best regards / Mit freundlichen Grüßen
Daniel Vogelbacher
