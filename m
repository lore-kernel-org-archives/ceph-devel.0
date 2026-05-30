Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78783C1963
	for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165755; cv=none; b=DQka31bRBsrA8btQq4p0OYdk+Ykw+0pPBCYSuUliHkBeqY8WdqnyHjfK2YnYDUyD7LbZZyZ7Ih1FOGrX0UOeEfwFW1cMV3StcRI8yn97fKNPIM0VihrNNxNltw8mnVRqsAHvW3xDxwDbl2koFlIO7vsX7ZsuYRuBI3eApJ80v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165755; c=relaxed/simple;
	bh=nH9U4EzZVqS4DzqXKfmpYkiXxa6vC3SGXHGUFWq9d4o=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=LeChhwfItFbdbTNNX5EGR4kDssB4PmICHqpUF3XDBuNYVX5cGSwfrIqGTUKzZnK5LrEKURBAOexUcIIC064fLexImnG4E9h0ZUVXSI6E2rkmlt36TyhCGFDmSVotjEu3GrpOWOKogob5xG19rL/mMtxKKjLx9UMCbNBZwzpA96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhqR9H3D; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhqR9H3D"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so36371856d6.2
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780165753; x=1780770553; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63/uQJAkGCv5lh7In1rATRQm9hjmG/SgklCzCdncK3s=;
        b=PhqR9H3DYr7h1E3bTFTYaYWfH9RqfqLMG/gb4pJK4h68adHPJ7SnnayKAP6pNfbhcK
         ErKwx7FMQl+frsvlN3378U1N3HDdlo8xudczgiSOUGkJ0dcAjPLfEJhfqyWYtlSRHc9E
         G4Q4SJFBxb1+eZ4PlXo1bNbzV57I44mTPiOTIM74wGh6kaMlC/a1rPgFt89sh1neNnCV
         5F3xbtUrdhJwgRmS8WaW646Zq0EYaFdSGikoAsXz6mnlnUK7kKPKN7fOIMMdgvIVZ18u
         nZbeVMUIW13PeBZF43Y47KRYBqzfRAuXAbQX6xZaJNFwlOSAEwp9SSwaIkHl9JgvcXiM
         BGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165753; x=1780770553;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=63/uQJAkGCv5lh7In1rATRQm9hjmG/SgklCzCdncK3s=;
        b=AH8FbnpAW/8VdlPEaG+CixpfbVlgOZ8gLg6n1Wnej8JsJGarAhNUY8NT3FLQUbjjp4
         tLs/yZ52N+xBOr3HeZqtIvTfWoKNu6O8r9lokhxAam2v+qHKjf1pVhgrrD0LuSWgXFcc
         7uepFnSwmL61nHd79h8Xut/sgi8pXX439d14GkvHktvssrVVbOGnJm2TPgZz9OhBG9jZ
         xJgyj510blSwKkiU7JF7sqGTlRHDnyvLrd6ZcIczP3pgn/iTYTH1zdHAUWDWWAf0oDl8
         JZL0PyZ0z3//gmE8Mmnfq4EIT/m605cNK2kP4bNUFfW2ZkzwTlY18IAH7matTy6ytTMH
         Z1jA==
X-Gm-Message-State: AOJu0YzKVUk80+HXkVZGWlCFEuXYnMH/9wa1h0gFkgcrD6RMuKxVRi/t
	xRZBV4a7WXlQCP96e4Z/shptZRBqYfymUMPAH51+nMeCaoWjw61YRntlAYNkK5bb
X-Gm-Gg: Acq92OGn9TNCFnK3rYXQt4hdoSkjsxdwlcyvelsJsVeW5nFCWh8pM5PcX3SWsG/3YOy
	SURdx8jTtgQW1b1+WxMAN1caYiil37xRi5zkLSN2dt15JfSC8DyHnldqK2fGmlD7TmnF80bNBJ/
	sfshd4lmsKvMw1E3YOU+xKg2LDzBOssfjH9NcFlnfEfgpN3OLYGtqAEq9XRigJyakGnXEZ9PtqP
	UaEvXodvakpAoLOVoaEwkbIt4Xrr8JaRH8Khrze66ntx6/hXk3SpMPFiqGZ/6dtRbXYLyORZVlJ
	oEOB14dxAo10Ihxw8jF7blpmYOjEcAIxDX6AHbuwnXz1ldo/OggRZkamfg9Z21uRRfID+90Zp2i
	CtyBxpEo/GIOKnAaYkBD1jY+B4XTzyipU/FeC2bAs86AJ1cVA0YVMeWU3/5ODltEjVpKYesOkOJ
	mf5km5LuVGqevQFPNje/WypZuPY2GgcmPldy9y1+TJfProon53ZbT8B/2A98BmYScsZ19e36FD2
	1fxALqeiISP
X-Received: by 2002:a05:620a:a2c7:20b0:914:ca5a:60ae with SMTP id af79cd13be357-9153d971289mr536669985a.19.1780165752566;
        Sat, 30 May 2026 11:29:12 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:cdfe:d7c1:8ac:52ab])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915326503d2sm550543185a.44.2026.05.30.11.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2026 11:29:12 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] KASAN: slab-use-after-free Read in _copy_from_iter (stale ceph
 authorizer buffer)
Message-Id: <E378850E-106C-427B-A241-970EB2D054D7@gmail.com>
Date: Sat, 30 May 2026 14:29:01 -0400
Cc: ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: idryomov@gmail.com,
 amarkuze@redhat.com,
 slava@dubeyko.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: slab-use-after-free Read in _copy_from_iter (stale ceph =
authorizer buffer)

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/29ec9b673b7900323b13aaa4da24f12c

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>


[  433.707435][ T8124] libceph: mon0 (1)127.0.0.1:6789 session =
established
[  433.807720][ T8151] libceph: client1 fsid =
00000000-0000-0000-0000-000000000000
[  434.815976][ T8124] libceph: mds0 (1)127.0.0.1:6800 socket closed =
(con state OPEN)
[  439.280532][ T8124] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  439.282826][ T8124] BUG: KASAN: slab-use-after-free in =
_copy_from_iter (lib/iov_iter.c:85 ./include/linux/iov_iter.h:86 =
./include/linux/iov_iter.h:308 ./include/linux/iov_iter.h:330 =
lib/iov_iter.c:261 lib/iov_iter.c:272)
[  439.284900][ T8124] Read of size 59 at addr ffff888117e07380 by task =
kworker/0:0/8124
[  439.286923][ T8124]
[  439.287228][ T8124] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  439.287232][ T8124] Workqueue: ceph-msgr ceph_con_workfn
[  439.287248][ T8124] Call Trace:
[  439.287252][ T8124]  <TASK>
[  439.287256][ T8124]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[  439.287262][ T8124]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[  439.287279][ T8124]  kasan_report (mm/kasan/report.c:595)
[  439.287292][ T8124]  kasan_check_range (mm/kasan/generic.c:? =
mm/kasan/generic.c:200)
[  439.287301][ T8124]  __asan_memcpy (mm/kasan/shadow.c:105)
[  439.287307][ T8124]  _copy_from_iter (lib/iov_iter.c:85 =
./include/linux/iov_iter.h:86 ./include/linux/iov_iter.h:308 =
./include/linux/iov_iter.h:330 lib/iov_iter.c:261 lib/iov_iter.c:272)
[  439.287341][ T8124]  tcp_sendmsg_locked (./include/linux/uio.h:228 =
./include/linux/uio.h:245 ./include/net/sock.h:2303 =
./include/net/sock.h:2329 net/ipv4/tcp.c:1311)
[  439.287379][ T8124]  tcp_sendmsg (net/ipv4/tcp.c:1452)
[  439.287388][ T8124]  __sock_sendmsg (net/socket.c:787 =
net/socket.c:802)
[  439.287395][ T8124]  kernel_sendmsg (net/socket.c:825 =
net/socket.c:849)
[  439.287416][ T8124]  ceph_con_v1_try_write =
(net/ceph/messenger_v1.c:71 net/ceph/messenger_v1.c:423 =
net/ceph/messenger_v1.c:1507)
[  439.287463][ T8124]  ceph_con_workfn (net/ceph/messenger.c:1590)
[  439.287468][ T8124]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[  439.287476][ T8124]  worker_thread (kernel/workqueue.c:3478)
[  439.287487][ T8124]  kthread (kernel/kthread.c:436)
[  439.287502][ T8124]  ret_from_fork (arch/x86/kernel/process.c:158)
[  439.287520][ T8124]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  439.287527][ T8124]  </TASK>
[  439.287529][ T8124]
[  439.309701][ T8124] Freed by task 8124 on cpu 0 at 439.279926s:
[  439.310137][ T8124]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[  439.310481][ T8124]  kasan_save_free_info (mm/kasan/generic.c:584)
[  439.310845][ T8124]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[  439.311180][ T8124]  kfree (./include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[  439.311455][ T8124]  ceph_buffer_release (net/ceph/buffer.c:39)
[  439.311801][ T8124]  ceph_x_build_authorizer =
(./include/linux/kref.h:65 ./include/linux/ceph/buffer.h:34 =
net/ceph/auth_x.c:426)
[  439.312215][ T8124]  __ceph_auth_get_authorizer (net/ceph/auth.c:?)
[  439.312756][ T8124]  mds_get_authorizer (fs/ceph/mds_client.c:6427)
[  439.313134][ T8124]  prepare_write_connect =
(net/ceph/messenger_v1.c:336 net/ceph/messenger_v1.c:403)
[  439.313631][ T8124]  ceph_con_v1_try_read =
(net/ceph/messenger_v1.c:1353)
[  439.314100][ T8124]  ceph_con_workfn (net/ceph/messenger.c:1577)
[  439.314433][ T8124]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[  439.314810][ T8124]  worker_thread (kernel/workqueue.c:3478)
[  439.315140][ T8124]  kthread (kernel/kthread.c:436)
[  439.315435][ T8124]  ret_from_fork (arch/x86/kernel/process.c:158)
[  439.315757][ T8124]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  439.316101][ T8124]
[  439.316269][ T8124] The buggy address belongs to the object at =
ffff888117e07380
[  439.316269][ T8124]  which belongs to the cache kmalloc-64 of size 64
[  439.317221][ T8124] The buggy address is located 0 bytes inside of
[  439.317221][ T8124]  freed 64-byte region [ffff888117e07380, =
ffff888117e073c0)
[  439.318158][ T8124]
[  439.318326][ T8124] The buggy address belongs to the physical page:
[  439.318767][ T8124] page: refcount:0 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:0x117e07
[  439.319384][ T8124] flags: =
0x17ff00000000000(node=3D0|zone=3D2|lastcpupid=3D0x7ff)
[  439.319892][ T8124] page_type: f5(slab)
[  439.320173][ T8124] raw: 017ff00000000000 ffff8881000418c0 =
dead000000000100 dead000000000122
[  439.320768][ T8124] raw: 0000000000000000 0000000800200020 =
00000000f5000000 0000000000000000
[  439.321479][ T8124] page dumped because: kasan: bad access detected
[  439.321935][ T8124] page_owner tracks the page as allocated
[  439.322334][ T8124] page last allocated via order 0, migratetype =
Unmovable, gfp_mask =
0xd2c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM0
[  439.323843][ T8124]  post_alloc_hook (./include/linux/page_owner.h:32 =
mm/page_alloc.c:1858)
[  439.324260][ T8124]  get_page_from_freelist (mm/page_alloc.c:1866 =
mm/page_alloc.c:3946)
[  439.324647][ T8124]  __alloc_frozen_pages_noprof =
(mm/page_alloc.c:5226)
[  439.325062][ T8124]  allocate_slab (mm/slub.c:3278 mm/slub.c:3467)
[  439.325385][ T8124]  refill_objects (mm/slub.c:3525 mm/slub.c:7272)
[  439.325813][ T8124]  __pcs_replace_empty_main (mm/slub.c:2816 =
mm/slub.c:4652)
[  439.326315][ T8124]  __kmalloc_noprof (mm/slub.c:4750 mm/slub.c:4884 =
mm/slub.c:5295 mm/slub.c:5308)
[  439.326741][ T8124]  security_inode_init_security =
(./include/linux/slab.h:954 ./include/linux/slab.h:1097 =
security/security.c:1347)
[  439.327158][ T8124]  shmem_mknod (mm/shmem.c:3868)
[  439.327496][ T8124]  vfs_mknod (fs/namei.c:5120)
[  439.327918][ T8124]  devtmpfs_work_loop (drivers/base/devtmpfs.c:232 =
drivers/base/devtmpfs.c:384 drivers/base/devtmpfs.c:399)
[  439.328284][ T8124]  devtmpfsd (drivers/base/devtmpfs.c:441)
[  439.328573][ T8124]  kthread (kernel/kthread.c:436)
[  439.328867][ T8124]  ret_from_fork (arch/x86/kernel/process.c:158)
[  439.329193][ T8124]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  439.329531][ T8124] page_owner free stack trace missing
[  439.329913][ T8124]
[  439.330082][ T8124] Memory state around the buggy address:
[  439.330475][ T8124]  ffff888117e07280: 00 00 00 00 00 00 00 00 fc fc =
fc fc fc fc fc fc
[  439.331041][ T8124]  ffff888117e07300: fa fb fb fb fb fb fb fb fc fc =
fc fc fc fc fc fc
[  439.331600][ T8124] >ffff888117e07380: fa fb fb fb fb fb fb fb fc fc =
fc fc fc fc fc fc
[  439.332163][ T8124]                    ^
[  439.332450][ T8124]  ffff888117e07400: 00 00 00 00 00 00 00 00 fc fc =
fc fc fc fc fc fc
[  439.333021][ T8124]  ffff888117e07480: 00 00 00 00 00 00 00 00 fc fc =
fc fc fc fc fc fc
[  439.333580][ T8124] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  439.335827][ T8124] Kernel panic - not syncing: KASAN: panic_on_warn =
set ...
[  439.337156][ T8124] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  439.338021][ T8124] Workqueue: ceph-msgr ceph_con_workfn
[  439.338411][ T8124] Call Trace:
[  439.338650][ T8124]  <TASK>
[  439.338870][ T8124]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[  439.339194][ T8124]  vpanic (kernel/panic.c:650)
[  439.340114][ T8124]  panic (kernel/panic.c:787)
[  439.341884][ T8124]  check_panic_on_warn (kernel/panic.c:524)
[  439.342590][ T8124]  end_report (mm/kasan/report.c:227)
[  439.343246][ T8124]  kasan_report (mm/kasan/report.c:597)
[  439.344245][ T8124]  kasan_check_range (mm/kasan/generic.c:? =
mm/kasan/generic.c:200)
[  439.344956][ T8124]  __asan_memcpy (mm/kasan/shadow.c:105)
[  439.345274][ T8124]  _copy_from_iter (lib/iov_iter.c:85 =
./include/linux/iov_iter.h:86 ./include/linux/iov_iter.h:308 =
./include/linux/iov_iter.h:330 lib/iov_iter.c:261 lib/iov_iter.c:272)
[  439.347793][ T8124]  tcp_sendmsg_locked (./include/linux/uio.h:228 =
./include/linux/uio.h:245 ./include/net/sock.h:2303 =
./include/net/sock.h:2329 net/ipv4/tcp.c:1311)
[  439.349645][ T8124]  tcp_sendmsg (net/ipv4/tcp.c:1452)
[  439.350303][ T8124]  __sock_sendmsg (net/socket.c:787 =
net/socket.c:802)
[  439.350636][ T8124]  kernel_sendmsg (net/socket.c:825 =
net/socket.c:849)
[  439.352112][ T8124]  ceph_con_v1_try_write =
(net/ceph/messenger_v1.c:71 net/ceph/messenger_v1.c:423 =
net/ceph/messenger_v1.c:1507)
[  439.355167][ T8124]  ceph_con_workfn (net/ceph/messenger.c:1590)
[  439.355504][ T8124]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[  439.355889][ T8124]  worker_thread (kernel/workqueue.c:3478)
[  439.356570][ T8124]  kthread (kernel/kthread.c:436)
[  439.357542][ T8124]  ret_from_fork (arch/x86/kernel/process.c:158)
[  439.358873][ T8124]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  439.359208][ T8124]  </TASK>
[  439.359607][ T8124] Kernel Offset: disabled
[  439.359917][ T8124] ---[ end Kernel panic - not syncing: KASAN: =
panic_on_warn set ... ]---


Best,
Shuangpeng

