From: Amon Ott <a.ott@m-privacy.de>
Subject: BUG: scheduling while atomic
Date: Fri, 9 Dec 2011 11:00:51 +0100
Message-ID: <201112091100.52460.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Uxd4O2/Y1IBevH3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:33305 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab1LIKBD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 05:01:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 8791585F77
	for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2011 11:01:01 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 02880-05 for <ceph-devel@vger.kernel.org>;
 Fri,  9 Dec 2011 11:00:54 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id A74F185F76
	for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2011 11:00:54 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 243E526D80
	for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2011 11:00:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--Boundary-00=_Uxd4O2/Y1IBevH3
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry folks for making so much trouble,

but there is still another locking issue with the kernel client. iput gets=
=20
called with locks held, but iput can sleep and did in this occasion. It did=
=20
not hang the system this time, but it can be quite nasty.

Log attached as usual.

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

--Boundary-00=_Uxd4O2/Y1IBevH3
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="schedatomic.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="schedatomic.log"

Dec  9 10:45:26 tgpro1 kernel: BUG: scheduling while atomic: firefox-bin/31447/0x10000002
Dec  9 10:45:26 tgpro1 kernel: 2 locks held by firefox-bin/31447:
Dec  9 10:45:26 tgpro1 kernel:  #0:  (&sb->s_type->i_mutex_key#12){+.+.+.}, at: [<006c1e12>] ceph_dir_fsync+0x77/0x18a [ceph]
Dec  9 10:45:26 tgpro1 kernel:  #1:  (&(&ci->i_unsafe_lock)->rlock){+.+...}, at: [<006c1ecc>] ceph_dir_fsync+0x131/0x18a [ceph]
Dec  9 10:45:26 tgpro1 kernel: Modules linked in: parport_pc lp parport ceph libceph btrfs zlib_deflate lzo_decompress lzo_compress zlib_inflate libcrc32c fuse e1000e i2c_i801 i2c_core iTCO_wdt iTCO_vendor_support evdev igb rtc_cmos button
Dec  9 10:45:26 tgpro1 kernel: Pid: 31447, comm: firefox-bin Tainted: G        W   3.1.4-rsbac #1
Dec  9 10:45:26 tgpro1 kernel: Call Trace:
Dec  9 10:45:26 tgpro1 kernel:  [<00060591>] __schedule_bug+0x5d/0x64
Dec  9 10:45:26 tgpro1 kernel:  [<0053ca0f>] __schedule+0x8e/0xb60
Dec  9 10:45:26 tgpro1 kernel:  [<000025c0>] ? __switch_to+0x1a/0x1a
Dec  9 10:45:26 tgpro1 kernel:  [<0008e987>] ? mark_held_locks+0xac/0xc9
Dec  9 10:45:26 tgpro1 kernel:  [<000a095a>] ? res_counter_uncharge+0x50/0x58
Dec  9 10:45:26 tgpro1 kernel:  [<0008ebfb>] ? trace_hardirqs_on_caller+0x10b/0x13c
Dec  9 10:45:26 tgpro1 kernel:  [<0008ec37>] ? trace_hardirqs_on+0xb/0xd
Dec  9 10:45:26 tgpro1 kernel:  [<0053d555>] _cond_resched+0x24/0x37
Dec  9 10:45:26 tgpro1 kernel:  [<000b9ef3>] truncate_inode_pages_range+0x10e/0x2d8
Dec  9 10:45:26 tgpro1 kernel:  [<0007ebc5>] ? wake_up_bit+0x57/0x5b
Dec  9 10:45:26 tgpro1 kernel:  [<00100414>] ? evict+0x57/0x12c
Dec  9 10:45:26 tgpro1 kernel:  [<000ba0c9>] truncate_inode_pages+0xc/0x10
Dec  9 10:45:26 tgpro1 kernel:  [<00100460>] evict+0xa3/0x12c
Dec  9 10:45:26 tgpro1 kernel:  [<0010063c>] iput+0x153/0x158
Dec  9 10:45:26 tgpro1 kernel:  [<000fe5fe>] d_kill+0xc9/0xe2
Dec  9 10:45:26 tgpro1 kernel:  [<000fed51>] dput+0x120/0x12b
Dec  9 10:45:26 tgpro1 kernel:  [<006d5883>] ? ceph_mdsc_create_request+0xf5/0xf5 [ceph]
Dec  9 10:45:26 tgpro1 kernel:  [<006d5912>] ceph_mdsc_release_request+0x8f/0xf9 [ceph]
Dec  9 10:45:26 tgpro1 kernel:  [<001b44a4>] kref_put+0x3f/0x48
Dec  9 10:45:26 tgpro1 kernel:  [<006c1ed9>] ceph_dir_fsync+0x13e/0x18a [ceph]
Dec  9 10:45:26 tgpro1 kernel:  [<000237f0>] ? kunmap+0x7/0x4e
Dec  9 10:45:26 tgpro1 kernel:  [<006c1d9b>] ? ceph_finish_lookup+0x92/0x92 [ceph]
Dec  9 10:45:26 tgpro1 kernel:  [<0010c7cf>] vfs_fsync_range+0x23/0x35
Dec  9 10:45:26 tgpro1 kernel:  [<0010c7f5>] vfs_fsync+0x14/0x16
Dec  9 10:45:26 tgpro1 kernel:  [<0010ca00>] do_fsync+0x23/0x33
Dec  9 10:45:26 tgpro1 kernel:  [<0010ca20>] sys_fdatasync+0x10/0x12
Dec  9 10:45:26 tgpro1 kernel:  [<0053faba>] syscall_call+0x7/0xb
Dec  9 10:45:26 tgpro1 kernel:  [<00530000>] ? update_res+0xc0/0x179

--Boundary-00=_Uxd4O2/Y1IBevH3--
