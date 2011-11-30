From: Amon Ott <a.ott@m-privacy.de>
Subject: Circular lock / deadlock in kernel client
Date: Wed, 30 Nov 2011 13:21:46 +0100
Message-ID: <201111301321.47514.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b/h1OqP25zu6ObH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:53440 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755019Ab1K3MWA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Nov 2011 07:22:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id D2D4485EFD
	for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2011 13:21:58 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 13285-05 for <ceph-devel@vger.kernel.org>;
 Wed, 30 Nov 2011 13:21:49 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 20D6C85ED0
	for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2011 13:21:49 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 872AD26D7E
	for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2011 13:21:48 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--Boundary-00=_b/h1OqP25zu6ObH
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

With some kernel debug options for soft and hard lockup detection, I got so=
me=20
fine traces. My kernel is a 3.1.4 to which I have ported from ceph-client=20
for-linus branch what is suitable for 3.1. If needed, I can make my exact=20
ceph code available.

Traces are attached. It seems that two depending locks can be acquired in=20
different order at different parts of the code, and thus lead to a deadlock=
=2E=20
Additionally, I am still trying to reproduce a partial lockup of single dir=
s=20
with this debugging. Those are likely to be related to mutex locking dirs=20
without unlocking properly.

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_b/h1OqP25zu6ObH
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="circ1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="circ1.log"

Nov 30 10:40:21 tgpro1 kernel: =======================================================
Nov 30 10:40:21 tgpro1 kernel: [ INFO: possible circular locking dependency detected ]
Nov 30 10:40:21 tgpro1 kernel: 3.1.3-rsbac #1
Nov 30 10:40:21 tgpro1 kernel: -------------------------------------------------------
Nov 30 10:40:21 tgpro1 kernel: kworker/0:0/8787 is trying to acquire lock:
Nov 30 10:40:21 tgpro1 kernel:  (&sb->s_type->i_lock_key#16){+.+...}, at: [<000f7176>] igrab+0x11/0x41
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: but task is already holding lock:
Nov 30 10:40:21 tgpro1 kernel:  (&(&s->s_cap_lock)->rlock){+.+...}, at: [<006e0de4>] iterate_session_caps+0x40/0x17d [ceph]
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: which lock already depends on the new lock.
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: the existing dependency chain (in reverse order) is:
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: -> #1 (&(&s->s_cap_lock)->rlock){+.+...}:
Nov 30 10:40:21 tgpro1 kernel:        [<0009038d>] lock_acquire+0x42/0x59
Nov 30 10:40:21 tgpro1 kernel:        [<0052f167>] _raw_spin_lock+0x24/0x33
Nov 30 10:40:21 tgpro1 kernel:        [<006dc0bc>] ceph_add_cap+0x302/0x551 [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006cfbfd>] fill_inode+0x5ef/0x72e [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006d0d6b>] ceph_fill_trace+0x663/0x6c5 [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006e4c6e>] dispatch+0xafe/0x10e7 [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006a444d>] con_work+0x14f7/0x16c6 [libceph]
Nov 30 10:40:21 tgpro1 kernel:        [<0007a24b>] process_one_work+0x223/0x391
Nov 30 10:40:21 tgpro1 kernel:        [<0007a747>] worker_thread+0x182/0x2d7
Nov 30 10:40:21 tgpro1 kernel:        [<0007d767>] kthread+0x62/0x67
Nov 30 10:40:21 tgpro1 kernel:        [<00530b26>] kernel_thread_helper+0x6/0xd
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: -> #0 (&sb->s_type->i_lock_key#16){+.+...}:
Nov 30 10:40:21 tgpro1 kernel:        [<0008fa3e>] __lock_acquire+0xe79/0x1425
Nov 30 10:40:21 tgpro1 kernel:        [<0009038d>] lock_acquire+0x42/0x59
Nov 30 10:40:21 tgpro1 kernel:        [<0052f167>] _raw_spin_lock+0x24/0x33
Nov 30 10:40:21 tgpro1 kernel:        [<000f7176>] igrab+0x11/0x41
Nov 30 10:40:21 tgpro1 kernel:        [<006e0e14>] iterate_session_caps+0x70/0x17d [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006e3bca>] send_mds_reconnect+0x319/0x46a [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006e4035>] ceph_mdsc_handle_map+0x2f2/0x42d [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006ce00d>] extra_mon_dispatch+0x18/0x1f [ceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006a63dd>] dispatch+0x4f7/0x52a [libceph]
Nov 30 10:40:21 tgpro1 kernel:        [<006a444d>] con_work+0x14f7/0x16c6 [libceph]
Nov 30 10:40:21 tgpro1 kernel:        [<0007a24b>] process_one_work+0x223/0x391
Nov 30 10:40:21 tgpro1 kernel:        [<0007a747>] worker_thread+0x182/0x2d7
Nov 30 10:40:21 tgpro1 kernel:        [<0007d767>] kthread+0x62/0x67
Nov 30 10:40:21 tgpro1 kernel:        [<00530b26>] kernel_thread_helper+0x6/0xd
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: other info that might help us debug this:
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel:  Possible unsafe locking scenario:
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel:        CPU0                    CPU1
Nov 30 10:40:21 tgpro1 kernel:        ----                    ----
Nov 30 10:40:21 tgpro1 kernel:   lock(&(&s->s_cap_lock)->rlock);
Nov 30 10:40:21 tgpro1 kernel:                                lock(&sb->s_type->i_lock_key);
Nov 30 10:40:21 tgpro1 kernel:                                lock(&(&s->s_cap_lock)->rlock);
Nov 30 10:40:21 tgpro1 kernel:   lock(&sb->s_type->i_lock_key);
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel:  *** DEADLOCK ***
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: 5 locks held by kworker/0:0/8787:
Nov 30 10:40:21 tgpro1 kernel:  #0:  (ceph-msgr){.+.+.+}, at: [<0007a1ff>] process_one_work+0x1d7/0x391
Nov 30 10:40:21 tgpro1 kernel:  #1:  ((&(&con->work)->work)){+.+.+.}, at: [<0007a1ff>] process_one_work+0x1d7/0x391
Nov 30 10:40:21 tgpro1 kernel:  #2:  (&s->s_mutex){+.+.+.}, at: [<006e3954>] send_mds_reconnect+0xa3/0x46a [ceph]
Nov 30 10:40:21 tgpro1 kernel:  #3:  (&mdsc->snap_rwsem){+++++.}, at: [<006e3a4c>] send_mds_reconnect+0x19b/0x46a [ceph]
Nov 30 10:40:21 tgpro1 kernel:  #4:  (&(&s->s_cap_lock)->rlock){+.+...}, at: [<006e0de4>] iterate_session_caps+0x40/0x17d [ceph]
Nov 30 10:40:21 tgpro1 kernel: 
Nov 30 10:40:21 tgpro1 kernel: stack backtrace:
Nov 30 10:40:21 tgpro1 kernel: Pid: 8787, comm: kworker/0:0 Tainted: G        W   3.1.3-rsbac #1
Nov 30 10:40:21 tgpro1 kernel: Call Trace:
Nov 30 10:40:21 tgpro1 kernel:  [<0008e776>] print_circular_bug+0x21a/0x227
Nov 30 10:40:21 tgpro1 kernel:  [<0008fa3e>] __lock_acquire+0xe79/0x1425
Nov 30 10:40:21 tgpro1 kernel:  [<0009038d>] lock_acquire+0x42/0x59
Nov 30 10:40:21 tgpro1 kernel:  [<000f7176>] ? igrab+0x11/0x41
Nov 30 10:40:21 tgpro1 kernel:  [<0052f167>] _raw_spin_lock+0x24/0x33
Nov 30 10:40:21 tgpro1 kernel:  [<000f7176>] ? igrab+0x11/0x41
Nov 30 10:40:21 tgpro1 kernel:  [<000f7176>] igrab+0x11/0x41
Nov 30 10:40:21 tgpro1 kernel:  [<006e0e14>] iterate_session_caps+0x70/0x17d [ceph]
Nov 30 10:40:21 tgpro1 kernel:  [<006e5488>] ? ceph_mdsc_submit_request+0x55/0x55 [ceph]
Nov 30 10:40:21 tgpro1 kernel:  [<006a4d03>] ? ceph_pagelist_append+0xbc/0xf9 [libceph]
Nov 30 10:40:21 tgpro1 kernel:  [<006e3bca>] send_mds_reconnect+0x319/0x46a [ceph]
Nov 30 10:40:21 tgpro1 kernel:  [<0008daa1>] ? trace_hardirqs_on_caller+0x10b/0x13c
Nov 30 10:40:21 tgpro1 kernel:  [<0008dadd>] ? trace_hardirqs_on+0xb/0xd
Nov 30 10:40:21 tgpro1 kernel:  [<006e4035>] ceph_mdsc_handle_map+0x2f2/0x42d [ceph]
Nov 30 10:40:21 tgpro1 kernel:  [<000d7cd3>] ? __kmalloc+0x10d/0x137
Nov 30 10:40:21 tgpro1 kernel:  [<00c40015>] ? 0xc40014
Nov 30 10:40:21 tgpro1 kernel:  [<006ce00d>] extra_mon_dispatch+0x18/0x1f [ceph]
Nov 30 10:40:21 tgpro1 kernel:  [<006a63dd>] dispatch+0x4f7/0x52a [libceph]
Nov 30 10:40:21 tgpro1 kernel:  [<0008dadd>] ? trace_hardirqs_on+0xb/0xd
Nov 30 10:40:21 tgpro1 kernel:  [<006a444d>] con_work+0x14f7/0x16c6 [libceph]
Nov 30 10:40:21 tgpro1 kernel:  [<0007a24b>] process_one_work+0x223/0x391
Nov 30 10:40:21 tgpro1 kernel:  [<0007a1ff>] ? process_one_work+0x1d7/0x391
Nov 30 10:40:21 tgpro1 kernel:  [<006a2f56>] ? ceph_fault+0x262/0x262 [libceph]
Nov 30 10:40:21 tgpro1 kernel:  [<0007a747>] worker_thread+0x182/0x2d7
Nov 30 10:40:21 tgpro1 kernel:  [<00002a00>] ? __show_regs+0x6f/0x6f
Nov 30 10:40:21 tgpro1 kernel:  [<00002a00>] ? __show_regs+0x6f/0x6f
Nov 30 10:40:21 tgpro1 kernel:  [<0007a5c5>] ? rescuer_thread+0x20c/0x20c
Nov 30 10:40:21 tgpro1 kernel:  [<0007d767>] kthread+0x62/0x67
Nov 30 10:40:21 tgpro1 kernel:  [<0007d705>] ? __init_kthread_worker+0x42/0x42
Nov 30 10:40:21 tgpro1 kernel:  [<00530b26>] kernel_thread_helper+0x6/0xd
Nov 30 10:40:26 tgpro1 kernel: ceph: mds0 reconnect success
Nov 30 10:40:40 tgpro1 kernel: ceph: mds0 recovery completed

--Boundary-00=_b/h1OqP25zu6ObH
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="circ2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="circ2.log"

Nov 30 10:50:53 tgpro1 kernel: libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
Nov 30 10:50:53 tgpro1 kernel: ceph: loaded (mds proto 32)
Nov 30 10:50:53 tgpro1 kernel: libceph: client6597 fsid 520649ba-50cc-2c58-7db3-4b30d3bb97d3
Nov 30 10:50:53 tgpro1 kernel: libceph: mon0 192.168.111.1:6789 session established
Nov 30 10:56:43 tgpro1 kernel: ceph: mds0 caps stale
Nov 30 10:57:03 tgpro1 kernel: ceph: mds0 caps stale
Nov 30 10:58:24 tgpro1 kernel: ceph: mds0 reconnect start
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: =======================================================
Nov 30 10:58:24 tgpro1 kernel: [ INFO: possible circular locking dependency detected ]
Nov 30 10:58:24 tgpro1 kernel: 3.1.4-rsbac #1
Nov 30 10:58:24 tgpro1 kernel: -------------------------------------------------------
Nov 30 10:58:24 tgpro1 kernel: kworker/0:0/4 is trying to acquire lock:
Nov 30 10:58:24 tgpro1 kernel:  (&sb->s_type->i_lock_key#16){+.+...}, at: [<000f7166>] igrab+0x11/0x41
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: but task is already holding lock:
Nov 30 10:58:24 tgpro1 kernel:  (&(&s->s_cap_lock)->rlock){+.+...}, at: [<006b2de4>] iterate_session_caps+0x40/0x17d [ceph]
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: which lock already depends on the new lock.
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: the existing dependency chain (in reverse order) is:
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: -> #1 (&(&s->s_cap_lock)->rlock){+.+...}:
Nov 30 10:58:24 tgpro1 kernel:        [<0009038d>] lock_acquire+0x42/0x59
Nov 30 10:58:24 tgpro1 kernel:        [<0052f147>] _raw_spin_lock+0x24/0x33
Nov 30 10:58:24 tgpro1 kernel:        [<006ae0bc>] ceph_add_cap+0x302/0x551 [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006a1bfd>] fill_inode+0x5ef/0x72e [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006a2d6b>] ceph_fill_trace+0x663/0x6c5 [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006b6c6e>] dispatch+0xafe/0x10e7 [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<0067644d>] con_work+0x14f7/0x16c6 [libceph]
Nov 30 10:58:24 tgpro1 kernel:        [<0007a24b>] process_one_work+0x223/0x391
Nov 30 10:58:24 tgpro1 kernel:        [<0007a747>] worker_thread+0x182/0x2d7
Nov 30 10:58:24 tgpro1 kernel:        [<0007d767>] kthread+0x62/0x67
Nov 30 10:58:24 tgpro1 kernel:        [<00530b06>] kernel_thread_helper+0x6/0xd
Nov 30 10:58:24 tgpro1 kernel: 
Nov 30 10:58:24 tgpro1 kernel: -> #0 (&sb->s_type->i_lock_key#16){+.+...}:
Nov 30 10:58:24 tgpro1 kernel:        [<0008fa3e>] __lock_acquire+0xe79/0x1425
Nov 30 10:58:24 tgpro1 kernel:        [<0009038d>] lock_acquire+0x42/0x59
Nov 30 10:58:24 tgpro1 kernel:        [<0052f147>] _raw_spin_lock+0x24/0x33
Nov 30 10:58:24 tgpro1 kernel:        [<000f7166>] igrab+0x11/0x41
Nov 30 10:58:24 tgpro1 kernel:        [<006b2e14>] iterate_session_caps+0x70/0x17d [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006b5bca>] send_mds_reconnect+0x319/0x46a [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006b6035>] ceph_mdsc_handle_map+0x2f2/0x42d [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006a000d>] extra_mon_dispatch+0x18/0x1f [ceph]
Nov 30 10:58:24 tgpro1 kernel:        [<006783dd>] dispatch+0x4f7/0x52a [libceph]
Nov 30 10:58:24 tgpro1 kernel:        [<0067644d>] con_work+0x14f7/0x16c6 [libceph]
Nov 30 10:58:24 tgpro1 kernel:        [<0007a24b>] process_one_work+0x223/0x391
Nov 30 10:58:24 tgpro1 kernel:        [<0007a747>] worker_thread+0x182/0x2d7
Nov 30 10:58:25 tgpro1 kernel:        [<0007d767>] kthread+0x62/0x67
Nov 30 10:58:25 tgpro1 kernel:        [<00530b06>] kernel_thread_helper+0x6/0xd
Nov 30 10:58:25 tgpro1 kernel: 
Nov 30 10:58:25 tgpro1 kernel: other info that might help us debug this:
Nov 30 10:58:25 tgpro1 kernel: 
Nov 30 10:58:25 tgpro1 kernel:  Possible unsafe locking scenario:
Nov 30 10:58:25 tgpro1 kernel: 
Nov 30 10:58:25 tgpro1 kernel:        CPU0                    CPU1
Nov 30 10:58:25 tgpro1 kernel:        ----                    ----
Nov 30 10:58:25 tgpro1 kernel:   lock(&(&s->s_cap_lock)->rlock);
Nov 30 10:58:25 tgpro1 kernel:                                lock(&sb->s_type->i_lock_key);
Nov 30 10:58:25 tgpro1 kernel:                                lock(&(&s->s_cap_lock)->rlock);
Nov 30 10:58:25 tgpro1 kernel:   lock(&sb->s_type->i_lock_key);
Nov 30 10:58:25 tgpro1 kernel: 
Nov 30 10:58:25 tgpro1 kernel:  *** DEADLOCK ***
Nov 30 10:58:25 tgpro1 kernel: 
Nov 30 10:58:25 tgpro1 kernel: 5 locks held by kworker/0:0/4:
Nov 30 10:58:25 tgpro1 kernel:  #0:  (ceph-msgr){.+.+.+}, at: [<0007a1ff>] process_one_work+0x1d7/0x391
Nov 30 10:58:25 tgpro1 kernel:  #1:  ((&(&con->work)->work)){+.+.+.}, at: [<0007a1ff>] process_one_work+0x1d7/0x391
Nov 30 10:58:25 tgpro1 kernel:  #2:  (&s->s_mutex){+.+.+.}, at: [<006b5954>] send_mds_reconnect+0xa3/0x46a [ceph]
Nov 30 10:58:25 tgpro1 kernel:  #3:  (&mdsc->snap_rwsem){+++++.}, at: [<006b5a4c>] send_mds_reconnect+0x19b/0x46a [ceph]
Nov 30 10:58:25 tgpro1 kernel:  #4:  (&(&s->s_cap_lock)->rlock){+.+...}, at: [<006b2de4>] iterate_session_caps+0x40/0x17d [ceph]
Nov 30 10:58:25 tgpro1 kernel: 
Nov 30 10:58:25 tgpro1 kernel: stack backtrace:
Nov 30 10:58:25 tgpro1 kernel: Pid: 4, comm: kworker/0:0 Tainted: G        W   3.1.4-rsbac #1
Nov 30 10:58:25 tgpro1 kernel: Call Trace:
Nov 30 10:58:25 tgpro1 kernel:  [<0008e776>] print_circular_bug+0x21a/0x227
Nov 30 10:58:25 tgpro1 kernel:  [<0008fa3e>] __lock_acquire+0xe79/0x1425
Nov 30 10:58:25 tgpro1 kernel:  [<0009038d>] lock_acquire+0x42/0x59
Nov 30 10:58:25 tgpro1 kernel:  [<000f7166>] ? igrab+0x11/0x41
Nov 30 10:58:25 tgpro1 kernel:  [<0052f147>] _raw_spin_lock+0x24/0x33
Nov 30 10:58:25 tgpro1 kernel:  [<000f7166>] ? igrab+0x11/0x41
Nov 30 10:58:25 tgpro1 kernel:  [<000f7166>] igrab+0x11/0x41
Nov 30 10:58:25 tgpro1 kernel:  [<006b2e14>] iterate_session_caps+0x70/0x17d [ceph]
Nov 30 10:58:25 tgpro1 kernel:  [<006b7488>] ? ceph_mdsc_submit_request+0x55/0x55 [ceph]
Nov 30 10:58:25 tgpro1 kernel:  [<00676d03>] ? ceph_pagelist_append+0xbc/0xf9 [libceph]
Nov 30 10:58:25 tgpro1 kernel:  [<006b5bca>] send_mds_reconnect+0x319/0x46a [ceph]
Nov 30 10:58:25 tgpro1 kernel:  [<0008daa1>] ? trace_hardirqs_on_caller+0x10b/0x13c
Nov 30 10:58:25 tgpro1 kernel:  [<0008dadd>] ? trace_hardirqs_on+0xb/0xd
Nov 30 10:58:25 tgpro1 kernel:  [<006b6035>] ceph_mdsc_handle_map+0x2f2/0x42d [ceph]
Nov 30 10:58:25 tgpro1 kernel:  [<000d7cd3>] ? __kmalloc+0x10d/0x137
Nov 30 10:58:25 tgpro1 kernel:  [<00c40015>] ? 0xc40014
Nov 30 10:58:25 tgpro1 kernel:  [<006a000d>] extra_mon_dispatch+0x18/0x1f [ceph]
Nov 30 10:58:25 tgpro1 kernel:  [<006783dd>] dispatch+0x4f7/0x52a [libceph]
Nov 30 10:58:25 tgpro1 kernel:  [<0008dadd>] ? trace_hardirqs_on+0xb/0xd
Nov 30 10:58:25 tgpro1 kernel:  [<0067644d>] con_work+0x14f7/0x16c6 [libceph]
Nov 30 10:58:25 tgpro1 kernel:  [<0007a24b>] process_one_work+0x223/0x391
Nov 30 10:58:25 tgpro1 kernel:  [<0007a1ff>] ? process_one_work+0x1d7/0x391
Nov 30 10:58:25 tgpro1 kernel:  [<00674f56>] ? ceph_fault+0x262/0x262 [libceph]
Nov 30 10:58:25 tgpro1 kernel:  [<0007a747>] worker_thread+0x182/0x2d7
Nov 30 10:58:25 tgpro1 kernel:  [<00002a00>] ? __show_regs+0x6f/0x6f
Nov 30 10:58:25 tgpro1 kernel:  [<00002a00>] ? __show_regs+0x6f/0x6f
Nov 30 10:58:25 tgpro1 kernel:  [<0007a5c5>] ? rescuer_thread+0x20c/0x20c
Nov 30 10:58:25 tgpro1 kernel:  [<0007d767>] kthread+0x62/0x67
Nov 30 10:58:25 tgpro1 kernel:  [<0007d705>] ? __init_kthread_worker+0x42/0x42
Nov 30 10:58:25 tgpro1 kernel:  [<00530b06>] kernel_thread_helper+0x6/0xd
Nov 30 10:58:26 tgpro1 kernel: ceph: mds0 reconnect success
Nov 30 10:58:30 tgpro1 kernel: ceph: mds0 recovery completed

--Boundary-00=_b/h1OqP25zu6ObH
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="circ3.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="circ3.log"

Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: =======================================================
Nov 30 13:02:05 tgpro1 kernel: [ INFO: possible circular locking dependency detected ]
Nov 30 13:02:05 tgpro1 kernel: 3.1.4-rsbac #1
Nov 30 13:02:05 tgpro1 kernel: -------------------------------------------------------
Nov 30 13:02:05 tgpro1 kernel: kworker/0:1/22099 is trying to acquire lock:
Nov 30 13:02:05 tgpro1 kernel:  (&sb->s_type->i_lock_key#16){+.+...}, at: [<000ff721>] igrab+0x11/0x41
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: but task is already holding lock:
Nov 30 13:02:05 tgpro1 kernel:  (&(&realm->inodes_with_caps_lock)->rlock){+.+...}, at: [<006ce9b4>] ceph_update_snap_trace+0x258/0x3bc [ceph]
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: which lock already depends on the new lock.
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: the existing dependency chain (in reverse order) is:
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: -> #1 (&(&realm->inodes_with_caps_lock)->rlock){+.+...}:
Nov 30 13:02:05 tgpro1 kernel:        [<00091456>] lock_acquire+0x42/0x59
Nov 30 13:02:05 tgpro1 kernel:        [<0053f187>] _raw_spin_lock+0x24/0x33
Nov 30 13:02:05 tgpro1 kernel:        [<006cc0a3>] ceph_add_cap+0x37d/0x554 [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<006bfbf7>] fill_inode+0x5ee/0x72d [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<006c0d61>] ceph_fill_trace+0x663/0x6c5 [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<006d4bd4>] dispatch+0xaff/0x10e9 [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<00694459>] con_work+0x14f4/0x16c3 [libceph]
Nov 30 13:02:05 tgpro1 kernel:        [<0007b331>] process_one_work+0x229/0x397
Nov 30 13:02:05 tgpro1 kernel:        [<0007b80e>] worker_thread+0x182/0x2d8
Nov 30 13:02:05 tgpro1 kernel:        [<0007e843>] kthread+0x62/0x67
Nov 30 13:02:05 tgpro1 kernel:        [<00540c86>] kernel_thread_helper+0x6/0xd
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: -> #0 (&sb->s_type->i_lock_key#16){+.+...}:
Nov 30 13:02:05 tgpro1 kernel:        [<00090b06>] __lock_acquire+0xe7b/0x1428
Nov 30 13:02:05 tgpro1 kernel:        [<00091456>] lock_acquire+0x42/0x59
Nov 30 13:02:05 tgpro1 kernel:        [<0053f187>] _raw_spin_lock+0x24/0x33
Nov 30 13:02:05 tgpro1 kernel:        [<000ff721>] igrab+0x11/0x41
Nov 30 13:02:05 tgpro1 kernel:        [<006ce9d3>] ceph_update_snap_trace+0x277/0x3bc [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<006cee4e>] ceph_handle_snap+0x336/0x458 [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<006d4e7d>] dispatch+0xda8/0x10e9 [ceph]
Nov 30 13:02:05 tgpro1 kernel:        [<00694459>] con_work+0x14f4/0x16c3 [libceph]
Nov 30 13:02:05 tgpro1 kernel:        [<0007b331>] process_one_work+0x229/0x397
Nov 30 13:02:05 tgpro1 kernel:        [<0007b80e>] worker_thread+0x182/0x2d8
Nov 30 13:02:05 tgpro1 kernel:        [<0007e843>] kthread+0x62/0x67
Nov 30 13:02:05 tgpro1 kernel:        [<00540c86>] kernel_thread_helper+0x6/0xd
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: other info that might help us debug this:
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel:  Possible unsafe locking scenario:
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel:        CPU0                    CPU1
Nov 30 13:02:05 tgpro1 kernel:        ----                    ----
Nov 30 13:02:05 tgpro1 kernel:   lock(&(&realm->inodes_with_caps_lock)->rlock);
Nov 30 13:02:05 tgpro1 kernel:                                lock(&sb->s_type->i_lock_key);
Nov 30 13:02:05 tgpro1 kernel:                                lock(&(&realm->inodes_with_caps_lock)->rlock);
Nov 30 13:02:05 tgpro1 kernel:   lock(&sb->s_type->i_lock_key);
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel:  *** DEADLOCK ***
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: 4 locks held by kworker/0:1/22099:
Nov 30 13:02:05 tgpro1 kernel:  #0:  (ceph-msgr){++++.+}, at: [<0007b2e5>] process_one_work+0x1dd/0x397
Nov 30 13:02:05 tgpro1 kernel:  #1:  ((&(&con->work)->work)){+.+.+.}, at: [<0007b2e5>] process_one_work+0x1dd/0x397
Nov 30 13:02:05 tgpro1 kernel:  #2:  (&mdsc->snap_rwsem){+++++.}, at: [<006cebe5>] ceph_handle_snap+0xcd/0x458 [ceph]
Nov 30 13:02:05 tgpro1 kernel:  #3:  (&(&realm->inodes_with_caps_lock)->rlock){+.+...}, at: [<006ce9b4>] ceph_update_snap_trace+0x258/0x3bc [ceph]
Nov 30 13:02:05 tgpro1 kernel: 
Nov 30 13:02:05 tgpro1 kernel: stack backtrace:
Nov 30 13:02:05 tgpro1 kernel: Pid: 22099, comm: kworker/0:1 Tainted: G        W   3.1.4-rsbac #1
Nov 30 13:02:05 tgpro1 kernel: Call Trace:
Nov 30 13:02:05 tgpro1 kernel:  [<0008f840>] print_circular_bug+0x219/0x226
Nov 30 13:02:05 tgpro1 kernel:  [<00090b06>] __lock_acquire+0xe7b/0x1428
Nov 30 13:02:05 tgpro1 kernel:  [<00090b54>] ? __lock_acquire+0xec9/0x1428
Nov 30 13:02:05 tgpro1 kernel:  [<00091456>] lock_acquire+0x42/0x59
Nov 30 13:02:05 tgpro1 kernel:  [<000ff721>] ? igrab+0x11/0x41
Nov 30 13:02:05 tgpro1 kernel:  [<0053f187>] _raw_spin_lock+0x24/0x33
Nov 30 13:02:05 tgpro1 kernel:  [<000ff721>] ? igrab+0x11/0x41
Nov 30 13:02:05 tgpro1 kernel:  [<000ff721>] igrab+0x11/0x41
Nov 30 13:02:05 tgpro1 kernel:  [<006ce9d3>] ceph_update_snap_trace+0x277/0x3bc [ceph]
Nov 30 13:02:05 tgpro1 kernel:  [<006cee4e>] ceph_handle_snap+0x336/0x458 [ceph]
Nov 30 13:02:05 tgpro1 kernel:  [<007f0312>] ? 0x7f0311
Nov 30 13:02:05 tgpro1 kernel:  [<006d4e7d>] dispatch+0xda8/0x10e9 [ceph]
Nov 30 13:02:05 tgpro1 kernel:  [<0048738c>] ? kernel_recvmsg+0x2a/0x34
Nov 30 13:02:05 tgpro1 kernel:  [<0053dbb6>] ? __mutex_unlock_slowpath+0xdf/0xf8
Nov 30 13:02:05 tgpro1 kernel:  [<0008eb6f>] ? trace_hardirqs_on_caller+0x10b/0x13c
Nov 30 13:02:05 tgpro1 kernel:  [<0008ebab>] ? trace_hardirqs_on+0xb/0xd
Nov 30 13:02:05 tgpro1 kernel:  [<00694459>] con_work+0x14f4/0x16c3 [libceph]
Nov 30 13:02:05 tgpro1 kernel:  [<0000784e>] ? text_poke+0x79/0x95
Nov 30 13:02:05 tgpro1 kernel:  [<0007b331>] process_one_work+0x229/0x397
Nov 30 13:02:05 tgpro1 kernel:  [<0007b2e5>] ? process_one_work+0x1dd/0x397
Nov 30 13:02:05 tgpro1 kernel:  [<00692f65>] ? ceph_fault+0x262/0x262 [libceph]
Nov 30 13:02:05 tgpro1 kernel:  [<0007b80e>] worker_thread+0x182/0x2d8
Nov 30 13:02:05 tgpro1 kernel:  [<00002b40>] ? setup_sigcontext+0x24/0x24
Nov 30 13:02:05 tgpro1 kernel:  [<00002b40>] ? setup_sigcontext+0x24/0x24
Nov 30 13:02:05 tgpro1 kernel:  [<0007b68c>] ? rescuer_thread+0x1ed/0x1ed
Nov 30 13:02:05 tgpro1 kernel:  [<0007e843>] kthread+0x62/0x67
Nov 30 13:02:05 tgpro1 kernel:  [<0007e7e1>] ? __init_kthread_worker+0x42/0x42
Nov 30 13:02:05 tgpro1 kernel:  [<00540c86>] kernel_thread_helper+0x6/0xd

--Boundary-00=_b/h1OqP25zu6ObH--
