From: Amon Ott <a.ott@m-privacy.de>
Subject: BUG at fs/inode.c
Date: Mon, 24 Oct 2011 12:39:12 +0200
Message-ID: <201110241239.13157.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RBUpOthReUy4XfB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:46879 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab1JXKjX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Oct 2011 06:39:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id B157B85F2F
	for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2011 12:39:21 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 13713-04 for <ceph-devel@vger.kernel.org>;
 Mon, 24 Oct 2011 12:39:15 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id CEB8285F2E
	for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2011 12:39:14 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 3DC5A269F5
	for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2011 12:39:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--Boundary-00=_RBUpOthReUy4XfB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

we have hit a kernel bug with current ceph-client master (commit=20
a2742a09568f81315e0f30021f29f14e7cd3924b), which I assume to be a Ceph bug.=
=20

Kernel is x86-32, Ceph is running on a two node cluster over ext4. The kern=
el=20
traces are attached, the system dies shortly after these messages. The bug =
is=20
reproducable. I have not found anything useful in ceph bug tracker when=20
searching for "fs/inode.c".

Around fs/inode.c line 1375 mentioned in the trace is the iput() function:
void iput(struct inode *inode)
{
        if (inode) {
                BUG_ON(inode->i_state & I_CLEAR);

                if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock))
                        iput_final(inode);
        }
}

So inode->i_state seems to be incorrect when iput() is called, maybe a doub=
le=20
call to iput() or a missing iget() somewhere. Is this really a Ceph bug or=
=20
have I messed up our kernel code when merging patches?

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

--Boundary-00=_RBUpOthReUy4XfB
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="Console.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Console.log"

------------[ cut here ]------------
kernel BUG at fs/inode.c:1375!
invalid opcode: 0000 [#1] PREEMPT SMP 
Modules linked in: lp ceph libceph crc32c libcrc32c fuse parport_pc parport floppy evdev i2c_piix4 button 8139too 8139cp mii i2c_core

Pid: 14455, comm: find Tainted: G        W   3.0.7-rsbac #1 Bochs Bochs
EIP: 0060:[<000e91bf>] EFLAGS: 00010202 CPU: 0
EIP is at iput+0x16/0x126
EAX: ea114950 EBX: ea114950 ECX: 00000282 EDX: ea1147a4
ESI: 005a1bc9 EDI: ea114950 EBP: e7bb9e34 ESP: e7bb9e28
 DS: 0068 ES: 0068 FS: 00d8 GS: 0033 SS: 0068
Process find (pid: 14455, ti=ee3f6dc0 task=ee3f6b20 task.ti=ee3f6dc0)
Stack:
 e7a6e200 005a1bc9 ea114950 e7bb9e40 005a1c4c e7a6e398 e7bb9e50 00196860
 e7a6e200 00000000 e7bb9e6c 0058ffde ee247200 00000155 e7bb9f5c 0058ffeb
 ea114950 e7bb9e84 00590005 e7bb9f34 ea114950 0058ffeb e7bb9ec4 e7bb9f34
Call Trace:
 [<005a1bc9>] ? ceph_mdsc_create_request+0xf5/0xf5 [ceph]
 [<005a1c4c>] ceph_mdsc_release_request+0x83/0xfb [ceph]
 [<00196860>] kref_put+0x3f/0x48
 [<0058ffde>] ceph_do_getattr+0xb6/0xc3 [ceph]
 [<0058ffeb>] ? ceph_do_getattr+0xc3/0xc3 [ceph]
 [<00590005>] ceph_getattr+0x1a/0xb6 [ceph]
 [<0058ffeb>] ? ceph_do_getattr+0xc3/0xc3 [ceph]
 [<000d68a2>] vfs_getattr+0x125/0x13e
 [<000d6914>] vfs_fstatat+0x59/0x6c
 [<000d6941>] sys_fstatat64+0x1a/0x2e
 [<000081a4>] ? hw_breakpoint_exceptions_notify+0x2f/0x117
 [<00003e34>] ? math_state_restore+0x2d/0x2d
 [<00003e32>] ? math_state_restore+0x2b/0x2d
 [<00003e3f>] ? do_device_not_available+0xb/0x15
 [<004dea0a>] syscall_call+0x7/0xb
Code: 4b 3f 00 b8 e4 34 44 c2 e8 04 39 f9 ff 83 c4 10 5b 5e 5f 5d c3 55 85 c0 89 e5 57 56 53 89 c3 0f 84 11 01 00 00 f6 40 1c 40 74 04 <0f> 0b eb fe 8d 50 14 8d 40 64 e8 86 b5 0a 00 85 c0 0f 84 f4 00 
EIP: [<000e91bf>] iput+0x16/0x126 SS:ESP 0068:e7bb9e28
---[ end trace fbba93cb09482261 ]---
------------[ cut here ]------------
WARNING: at fs/inode.c:334 ihold+0x27/0x29()
Hardware name: Bochs
Modules linked in: lp ceph libceph crc32c libcrc32c fuse parport_pc parport floppy evdev i2c_piix4 button 8139too 8139cp mii i2c_core
Pid: 14432, comm: genstatus Tainted: G      D W   3.0.7-rsbac #1
Call Trace:
 [<00061e40>] warn_slowpath_common+0x65/0x7a
 [<000e85e1>] ? ihold+0x27/0x29
 [<00061e64>] warn_slowpath_null+0xf/0x13
 [<000e85e1>] ihold+0x27/0x29
 [<0058ffb0>] ceph_do_getattr+0x88/0xc3 [ceph]
 [<0058ffeb>] ? ceph_do_getattr+0xc3/0xc3 [ceph]
 [<00590005>] ceph_getattr+0x1a/0xb6 [ceph]
 [<0058ffeb>] ? ceph_do_getattr+0xc3/0xc3 [ceph]
 [<000d68a2>] vfs_getattr+0x125/0x13e
 [<000d6914>] vfs_fstatat+0x59/0x6c
 [<000d69f8>] vfs_stat+0x13/0x15
 [<000d6a0e>] sys_stat64+0x14/0x28
 [<0006de3b>] ? set_current_blocked+0x37/0x3b
 [<0006e006>] ? sigprocmask+0x7e/0x89
 [<0006e134>] ? sys_rt_sigprocmask+0x123/0x138
 [<004dea0a>] syscall_call+0x7/0xb
---[ end trace fbba93cb09482262 ]---

--Boundary-00=_RBUpOthReUy4XfB--
