Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AF369983
	for <ceph-devel@vger.kernel.org>; Tue,  3 Feb 2026 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150157; cv=pass; b=CZOe+M8YNCHygEBtehnaWikfqIlidAkgBqhdW8hkut224T8PL6qUtcAcg4UHNmgAZmrcsJZxzjYgmnwVHyYmnnUCLIBSwZax5v6TCuzD2xnUAk4vPcVcAiCcjIKcLMIu+Lw7ne5YrHNsnx5HY8hnoj2riatV1zhpeWRygwP5who=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150157; c=relaxed/simple;
	bh=hoeG6ezJG46G81Ldus6BbKECSApV/mBK585rYAMKW8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyrhBFHApDJNqHiiNZi4bEHSgi3QXBcO+oNEi5zKY1HXpeEzhvSLCkBDnsJxGmDBe5yMyB74Zv9VnKHpK87jQxSv8HnCmJIv9ibYdnF/vtuYdXwRlL40YC2OcYbabeOZLUvYusfQUBBBNCIcls+EIObAqWXFjZQvSdcxcW8eF7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYbAfb2W; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYbAfb2W"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f2b9so7538549c88.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2026 12:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770150155; cv=none;
        d=google.com; s=arc-20240605;
        b=BWCiHDfPDIq+KSVghiD+Uuu6dqeMrtzZG9w2uwKaodb/TUtj1p7OSGz4bSZOf3ekqC
         tKBWrkaiqm4XM0SD0N/RnvqulBspksEcVxknfJgSOhU0Em8Q0q9CycJ70GCnlcjpWrRB
         rZYEUqTeuaeff2i4U/MF/XmAjJNVV6pyzJ0Xp8DmpXnnB7q1SkCjCcPHXq8yTWEXDo2k
         b0ByK1BzIFaPM/oL/Ish5UkYv8KkxHRQJMCOTs09zvfwX4QZ6wbzbPKcLviH/DYojZcu
         kGePyIWl9+ZFQOMgzUMTt63Fcg8UfHZk1g4b/UAC+O4F+qvj7i/q2QCPdxEZMzeq4PlF
         W5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fua09KTV6B350HMjEeoRZq4bAjib2n4gOjsZyPHGzjI=;
        fh=JeSAR9Dz0PTVaX+hNev/583BEAUyRGyXn/G1wWwm3+M=;
        b=VJx0WUiBNn6Mipx4OCnLr65DM3f67FEFlL3/QRUxYQaugJq9jt20PDT9dpyaB4TuBh
         sW0KhYgmt96xPwMCx4HbywfR7gZI6ifQnpJFJK+R0JYGM5M5xP4O/Ye45au6Dbkyyh4s
         9D1pSWCiDehxPGblC9uqZ+zs3JdczyGdpeyFdbbmJHsu4ikbihmlseeLIoXOO1aQ/41P
         QGKzyPtcjyDykYk9O4unlY26Vq+d+6TwQn3pR3wPWgghkc++UqdedpTOK00DbgDfH9sD
         MckJ084xZrYpdKma1Wa+6TP8uTqlZ+SaBs6niMlg3qa3zNi0UOEwUlJkr7GWeVBeRm5b
         /zvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770150155; x=1770754955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fua09KTV6B350HMjEeoRZq4bAjib2n4gOjsZyPHGzjI=;
        b=JYbAfb2WKuRW4KyScM00NfDdPC45aCNX8vUp+bfx6OxB7CO3vXLxbcR6Psk73bUV5y
         pIyZFnEaMLvYGr6IvXa94lD1e8Ara/plwqksZXU+nsyXYX5Ci9vtSBDcFNELpJdce0xa
         cLu2On7DA/RwN4tkahak32+N+Po0z4+5H/owpZNtWBqzjGpo76JukgvUmVkpj42rDO5c
         nuKWNZXZKBkf5je6IC53KastjQ2Xg2jKlMYI2065oDUGpLF+CHEXvhOXAwv0/vtAHSu8
         440Fq10fSVXMq4hxk0Yv4pS2OAinqF3Dhll15khWdZndtfwt+RzENt9lWEwelkhuxrvD
         07eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770150155; x=1770754955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fua09KTV6B350HMjEeoRZq4bAjib2n4gOjsZyPHGzjI=;
        b=NoAGp+EQf7L1R4AlmaBRoiWUbUoemzXIVd+aOG5eUEHw7gzt7mhRqGoESnoEaVD8i7
         4WJptpouNOhIQhtOXkNqhlkhyJmcw7mXt/UQWUraZ+HoKhpkj0U7aXP3No6NVgVoxhWm
         eEN9t30vYYw/ecmtukF5Yl4TtiG1gAFZo/yOoQ92WBJ7F12f3R4QfUaPcyUAJ9PmRQp0
         4mtvihfCEFsCX9TN3co/5CrpsXuHdM0p7zOtixlpROtbpOMgqOdnM7aDY7MKAtGvbum8
         TvME5MQBLibsZXlJje/ZMY0HdSlzPL24z9J5dRfO4l510JMHXp6s3V7v8XiVH5NfAvxN
         iugg==
X-Forwarded-Encrypted: i=1; AJvYcCUNkll2U+pFHzVLui1j5ZfQaw0S3wNs0/kJsICgqWN356DrNPOmeC2B+79Usd0xJnEMio3dxOLR2BHg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz829ibY6OVf0QdgyP67MTZNOsZayfLh7LcC06aHN95g/S2K1lF
	nDQ2Ma3FfH+D+YRuaiWxXTq6WsSrS3t+Ob62RsKUyqC4gP/NhvQipJB6mZPsNc3Gunc/Leoor7N
	yAZ8f1IRUD+BgWUmaP7mYrk5tIPcvnME=
X-Gm-Gg: AZuq6aIj3DG96oycTdpxGqEqy54FQmA8XM0+IWU2lGvXJpntffeZjF9dFwG59A69Y6D
	ln7TTHdDlGZHdubJXtDqOpg6H1bc0JkzvvMilw69yODEsmX8Jm1dLfM/h8U8589GDjBEuDenQav
	PHhHlVcLwy4QslUeDw81pG91Gwd5A4jK9sTtZEaDMFHQXTfgAdLWZv0YTmSbexLWwjPXoQtbtKf
	t+ILZWfxoR1/5XFC++qIKrW05gx6U+GyUhdRuSb5noMf5ttIh0vT7La8U9dcHf3vdIuhvw=
X-Received: by 2002:a05:7022:4396:b0:123:3461:99a4 with SMTP id
 a92af1059eb24-126f477dfb6mr330170c88.17.1770150155063; Tue, 03 Feb 2026
 12:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220140153.1523907-1-daniel@chaospixel.com>
 <20260203194039.2098776-1-daniel@chaospixel.com> <b02a0595c9a84ee2abdf9d0d9d05c8cfeaa92180.camel@ibm.com>
In-Reply-To: <b02a0595c9a84ee2abdf9d0d9d05c8cfeaa92180.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 3 Feb 2026 21:22:23 +0100
X-Gm-Features: AZwV_QixaEAheyJ4KtGxO3emuD05FsOkt59szMExg_tcoH0zglHGo17G8vWrBp0
Message-ID: <CAOi1vP8w1si2kdL7jY3LOh35k6H9JQU6ck0B81OQFJt6eFV6qQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs/ceph: Fix kernel oops due invalid pointer for
 kfree() in parse_longname()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "daniel@chaospixel.com" <daniel@chaospixel.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 9:16=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Tue, 2026-02-03 at 20:40 +0100, Daniel Vogelbacher wrote:
> > This fixes a kernel oops when reading ceph snapshot directories (.snap)=
,
> > for example by simply run `ls /mnt/my_ceph/.snap`.
> >
> > The bug was introduced in commit:
> >
> > bb80f7618832 - parse_longname(): strrchr() expects NUL-terminated strin=
g
> >
> > The variable str is guarded by __free(kfree), but advanced by one for
> > skipping the initial '_' in snapshot names. Thus, kfree() is called
> > with an invalid pointer.
> > This patch removes the need for advancing the pointer so kfree()
> > is called with correct memory pointer.
> >
> > Steps to reproduce:
> >
> > 1. Create snapshots on a cephfs volume (I've 63 snaps in my testcase)
> >
> > 2. Add cephfs mount to fstab
> > $ echo "samba-fileserver@.files=3D/volumes/datapool/stuff/3461082b-ecc9=
-4e82-8549-3fd2590d3fb6      /mnt/test/stuff   ceph     acl,noatime,_netdev=
    0       0" >> /etc/fstab
> >
> > 3. Reboot the system
> > $ systemctl reboot
> >
> > 4. Check if it's really mounted
> > $ mount | grep stuff
> >
> > 5. List snapshots (expected 63 snapshots on my system)
> > $ ls /mnt/test/stuff/.snap
> >
> > Now ls hangs forever and the kernel log shows the oops.
> >
> > The full trace is:
> >
> > [   53.703013] Oops: general protection fault, probably for non-canonic=
al address 0xd0c22857c0000000: 0000 [#1] SMP PTI
> > [   53.703201] CPU: 11 UID: 0 PID: 360 Comm: kworker/11:2 Not tainted 6=
.18.0-rc7 #41 PREEMPT(voluntary)
> > [   53.703281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
> > [   53.703317] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> > [   53.703424] RIP: 0010:rb_insert_color (/usr/src/linux/lib/rbtree.c:1=
85 (discriminator 1) /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
> > [   53.704503] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 48=
 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 74 05=
 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 76 17                   jbe    0x19
> >    2: 48 83 e1 fc             and    $0xfffffffffffffffc,%rcx
> >    6: 48 3b 51 10             cmp    0x10(%rcx),%rdx
> >    a: 0f 84 b7 00 00 00       je     0xc7
> >   10: 48 89 41 08             mov    %rax,0x8(%rcx)
> >   14: c3                      ret
> >   15: cc                      int3
> >   16: cc                      int3
> >   17: cc                      int3
> >   18: cc                      int3
> >   19: 48 89 06                mov    %rax,(%rsi)
> >   1c: c3                      ret
> >   1d: cc                      int3
> >   1e: cc                      int3
> >   1f: cc                      int3
> >   20: cc                      int3
> >   21: 48 8b 4a 10             mov    0x10(%rdx),%rcx
> >   25: 48 85 c9                test   %rcx,%rcx
> >   28: 74 05                   je     0x2f
> >   2a:*        f6 01 01                testb  $0x1,(%rcx)              <=
-- trapping instruction
> >   2d: 74 1b                   je     0x4a
> >   2f: 48 8b 48 10             mov    0x10(%rax),%rcx
> >   33: 48 39 f9                cmp    %rdi,%rcx
> >   36: 74 68                   je     0xa0
> >   38: 48 89 c7                mov    %rax,%rdi
> >   3b: 48 89 4a 08             mov    %rcx,0x8(%rdx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: f6 01 01                testb  $0x1,(%rcx)
> >    3: 74 1b                   je     0x20
> >    5: 48 8b 48 10             mov    0x10(%rax),%rcx
> >    9: 48 39 f9                cmp    %rdi,%rcx
> >    c: 74 68                   je     0x76
> >    e: 48 89 c7                mov    %rax,%rdi
> >   11: 48 89 4a 08             mov    %rcx,0x8(%rdx)
> >   15: 48                      rex.W
> > [   53.704559] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
> > [   53.704591] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX: d0c2285=
7c0000000
> > [   53.704616] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI: ffff8bd=
0c22855c0
> > [   53.704645] RBP: 0000000000002139 R08: 0000000000000000 R09: 0000000=
000000000
> > [   53.704668] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12: ffff8bd=
0c3e695b8
> > [   53.704691] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15: ffff8bd=
0c3e695c0
> > [   53.704714] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000) kn=
lGS:0000000000000000
> > [   53.704741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   53.704762] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4: 0000000=
000772ef0
> > [   53.704790] PKRU: 55555554
> > [   53.704803] Call Trace:
> > [   53.704844]  <TASK>
> > [   53.704862] ceph_get_snapid_map (/usr/src/linux/./include/linux/spin=
lock.h:391 /usr/src/linux/fs/ceph/snap.c:1255) ceph
> > [   53.704957] ceph_fill_inode (/usr/src/linux/fs/ceph/inode.c:1062 (di=
scriminator 2)) ceph
> > [   53.705019]  ? __pfx_ceph_set_ino_cb (/usr/src/linux/fs/ceph/inode.c=
:46) ceph
> > [   53.705074]  ? __pfx_ceph_ino_compare (/usr/src/linux/fs/ceph/super.=
h:595) ceph
> > [   53.705132] ceph_readdir_prepopulate (/usr/src/linux/fs/ceph/inode.c=
:2113) ceph
> > [   53.705191] mds_dispatch (/usr/src/linux/fs/ceph/mds_client.c:3993 /=
usr/src/linux/fs/ceph/mds_client.c:6299) ceph
> > [   53.705253]  ? sock_recvmsg (/usr/src/linux/net/socket.c:1078 (discr=
iminator 1) /usr/src/linux/net/socket.c:1100 (discriminator 1))
> > [   53.705279] ceph_con_process_message (/usr/src/linux/net/ceph/messen=
ger.c:1427) libceph
> > [   53.705347] process_message (/usr/src/linux/net/ceph/messenger_v2.c:=
2879) libceph
> > [   53.705406] ceph_con_v2_try_read (/usr/src/linux/net/ceph/messenger_=
v2.c:3043 /usr/src/linux/net/ceph/messenger_v2.c:3099 /usr/src/linux/net/ce=
ph/messenger_v2.c:3148) libceph
> > [   53.705467]  ? psi_group_change (/usr/src/linux/kernel/sched/psi.c:8=
76)
> > [   53.705488]  ? sched_balance_newidle (/usr/src/linux/kernel/sched/fa=
ir.c:12902 (discriminator 2))
> > [   53.705512]  ? psi_task_switch (/usr/src/linux/kernel/sched/psi.c:98=
4 (discriminator 2))
> > [   53.705532]  ? _raw_spin_unlock (/usr/src/linux/./arch/x86/include/a=
sm/paravirt.h:562 /usr/src/linux/./arch/x86/include/asm/qspinlock.h:57 /usr=
/src/linux/./include/linux/spinlock.h:204 /usr/src/linux/./include/linux/sp=
inlock_api_smp.h:142 /usr/src/linux/kernel/locking/spinlock.c:186)
> > [   53.705550]  ? finish_task_switch.isra.0 (/usr/src/linux/./arch/x86/=
include/asm/paravirt.h:671 /usr/src/linux/kernel/sched/sched.h:1559 /usr/sr=
c/linux/kernel/sched/core.c:5073 /usr/src/linux/kernel/sched/core.c:5191)
> > [   53.705575] ceph_con_workfn (/usr/src/linux/net/ceph/messenger.c:157=
8) libceph
> > [   53.705627]  process_one_work (/usr/src/linux/./arch/x86/include/asm=
/jump_label.h:36 /usr/src/linux/./include/trace/events/workqueue.h:110 /usr=
/src/linux/kernel/workqueue.c:3268)
> > [   53.705657]  worker_thread (/usr/src/linux/kernel/workqueue.c:3340 (=
discriminator 2) /usr/src/linux/kernel/workqueue.c:3427 (discriminator 2))
> > [   53.705679]  ? __pfx_worker_thread (/usr/src/linux/kernel/workqueue.=
c:3373)
> > [   53.705700]  kthread (/usr/src/linux/kernel/kthread.c:463)
> > [   53.705717]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > [   53.705734]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > [   53.705752]  ret_from_fork (/usr/src/linux/arch/x86/kernel/process.c=
:164)
> > [   53.705776]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > [   53.705793]  ret_from_fork_asm (/usr/src/linux/arch/x86/entry/entry_=
64.S:255)
> > [   53.705826]  </TASK>
> > [   53.705842] Modules linked in: ceph netfs libceph cfg80211 rfkill 80=
21q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common intel_unc=
ore_frequency_common kvm_intel virtio_gpu joydev kvm drm_client_lib virtio_=
dma_buf evdev drm_shmem_helper sg drm_kms_helper virtio_balloon button irqb=
ypass ghash_clmulni_intel aesni_intel rapl pcspkr drm configfs efi_pstore n=
fnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_tr=
ansport vmw_vmci vsock qemu_fw_cfg virtio_rng autofs4 ext4 crc16 mbcache jb=
d2 hid_generic usbhid hid sr_mod cdrom dm_mod ahci libahci libata xhci_pci =
iTCO_wdt intel_pmc_bxt xhci_hcd iTCO_vendor_support scsi_mod psmouse virtio=
_net i2c_i801 watchdog serio_raw i2c_smbus lpc_ich scsi_common usbcore net_=
failover failover virtio_blk usb_common
> > [   53.708740] ---[ end trace 0000000000000000 ]---
> > [   53.709462] RIP: 0010:rb_insert_color (/usr/src/linux/lib/rbtree.c:1=
85 (discriminator 1) /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
> > [   53.710118] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 48=
 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 74 05=
 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 76 17                   jbe    0x19
> >    2: 48 83 e1 fc             and    $0xfffffffffffffffc,%rcx
> >    6: 48 3b 51 10             cmp    0x10(%rcx),%rdx
> >    a: 0f 84 b7 00 00 00       je     0xc7
> >   10: 48 89 41 08             mov    %rax,0x8(%rcx)
> >   14: c3                      ret
> >   15: cc                      int3
> >   16: cc                      int3
> >   17: cc                      int3
> >   18: cc                      int3
> >   19: 48 89 06                mov    %rax,(%rsi)
> >   1c: c3                      ret
> >   1d: cc                      int3
> >   1e: cc                      int3
> >   1f: cc                      int3
> >   20: cc                      int3
> >   21: 48 8b 4a 10             mov    0x10(%rdx),%rcx
> >   25: 48 85 c9                test   %rcx,%rcx
> >   28: 74 05                   je     0x2f
> >   2a:*        f6 01 01                testb  $0x1,(%rcx)              <=
-- trapping instruction
> >   2d: 74 1b                   je     0x4a
> >   2f: 48 8b 48 10             mov    0x10(%rax),%rcx
> >   33: 48 39 f9                cmp    %rdi,%rcx
> >   36: 74 68                   je     0xa0
> >   38: 48 89 c7                mov    %rax,%rdi
> >   3b: 48 89 4a 08             mov    %rcx,0x8(%rdx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: f6 01 01                testb  $0x1,(%rcx)
> >    3: 74 1b                   je     0x20
> >    5: 48 8b 48 10             mov    0x10(%rax),%rcx
> >    9: 48 39 f9                cmp    %rdi,%rcx
> >    c: 74 68                   je     0x76
> >    e: 48 89 c7                mov    %rax,%rdi
> >   11: 48 89 4a 08             mov    %rcx,0x8(%rdx)
> >   15: 48                      rex.W
> > [   53.711453] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
> > [   53.712112] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX: d0c2285=
7c0000000
> > [   53.712798] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI: ffff8bd=
0c22855c0
> > [   53.713423] RBP: 0000000000002139 R08: 0000000000000000 R09: 0000000=
000000000
> > [   53.714061] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12: ffff8bd=
0c3e695b8
> > [   53.714696] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15: ffff8bd=
0c3e695c0
> > [   53.715321] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000) kn=
lGS:0000000000000000
> > [   53.715956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   53.716651] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4: 0000000=
000772ef0
> > [   53.717295] PKRU: 55555554
> > [   53.717918] note: kworker/11:2[360] exited with preempt_count 1
> >
> >
> > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla=
.kernel.org_show-5Fbug.cgi-3Fid-3D220807&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyT=
cHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3D9uYAi-tacLykatKmRl3=
LQ-OSQx74kkNg-1jsH1vnLekoVAt2IW2alYrd5HYGhsZK&s=3DmH4zSOBAE-0mk_Os9bf16JcPk=
k0k2BmY82O8_DfbZw0&e=3D
> > Fixes: bb80f7618832 - parse_longname(): strrchr() expects NUL-terminate=
d string
> >
> > Cc: stable@vger.kernel.org
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Daniel Vogelbacher <daniel@chaospixel.com>
> > ---
> >  fs/ceph/crypto.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 0ea4db650f85..9a115282f67d 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -166,12 +166,13 @@ static struct inode *parse_longname(const struct =
inode *parent,
> >       struct ceph_vino vino =3D { .snap =3D CEPH_NOSNAP };
> >       char *name_end, *inode_number;
> >       int ret =3D -EIO;
> > -     /* NUL-terminate */
> > -     char *str __free(kfree) =3D kmemdup_nul(name, *name_len, GFP_KERN=
EL);
> > +     /* Snapshot name must start with an underscore */
> > +     if (*name_len <=3D 0 || name[0] !=3D '_')
> > +             return ERR_PTR(-EIO);
> > +     /* Skip initial '_' and NUL-terminate */
> > +     char *str __free(kfree) =3D kmemdup_nul(name + 1, *name_len - 1, =
GFP_KERNEL);
> >       if (!str)
> >               return ERR_PTR(-ENOMEM);
> > -     /* Skip initial '_' */
> > -     str++;
> >       name_end =3D strrchr(str, '_');
> >       if (!name_end) {
> >               doutc(cl, "failed to parse long snapshot name: %s\n", str=
);
>
> Looks good.
>
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Applied.

Thanks,

                Ilya
