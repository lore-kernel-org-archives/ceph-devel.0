From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Kernel crash
Date: Wed, 30 May 2012 19:35:35 +0200
Message-ID: <1934548.axdquzlaJh@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:47292 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab2E3Rfm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 May 2012 13:35:42 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id BD05410C866
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 19:35:40 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I just saw a kernel crash on one of my machines. It had the cephfs from the 
ceph cluster mounted using the in-kernel client:

[522247.751071]  [<ffffffff814d3383>] ? release_sock+0xe3/0x110
[522247.751182]  [<ffffffff815ea438>] __bad_area_nosemaphore+0x1d1/0x1f0
[522247.751290]  [<ffffffff815ea46a>] bad_area_nosemaphore+0x13/0x15
[522247.751397]  [<ffffffff815f7b76>] do_page_fault+0x416/0x4f0
[522247.751503]  [<ffffffff814ce5dd>] ? sock_recvmsg+0x11d/0x140
[522247.751611]  [<ffffffff812c0ea6>] ? cpumask_next_and+0x36/0x50
[522247.751718]  [<ffffffff815f4475>] page_fault+0x25/0x30
[522247.751828]  [<ffffffffa03ccba4>] ? ceph_x_destroy_authorizer+0x14/0x40 
[libceph]
[522247.751995]  [<ffffffffa040f9be>] get_authorizer+0x6e/0x140 [ceph]
[522247.752104]  [<ffffffff814ce646>] ? kernel_recvmsg+0x46/0x60
[522247.752213]  [<ffffffffa03b969a>] prepare_write_connect+0x17a/0x270 
[libceph]
[522247.752378]  [<ffffffffa03bba75>] con_work+0x755/0x2c40 [libceph]
[522247.752486]  [<ffffffff810876a3>] ? update_rq_clock+0x43/0x1b0
[522247.752598]  [<ffffffffa03bb320>] ? ceph_msg_new+0x2d0/0x2d0 [libceph]
[522247.752707]  [<ffffffff810747ae>] process_one_work+0x11e/0x470
[522247.752815]  [<ffffffff810755bf>] worker_thread+0x15f/0x360
[522247.752925]  [<ffffffff81075460>] ? manage_workers+0x230/0x230
[522247.753032]  [<ffffffff81079da3>] kthread+0x93/0xa0
[522247.753137]  [<ffffffff815fd2a4>] kernel_thread_helper+0x4/0x10
[522247.753245]  [<ffffffff81079d10>] ? 
kthread_freezable_should_stop+0x70/0x70
[522247.753355]  [<ffffffff815fd2a0>] ? gs_change+0x13/0x13
[522247.753459] ---[ end trace b9ba686594d99f89 ]---

These lines are all that I could still read on the screen. (Good thing there's 
Opens Source OCR programs out there...) I do not know how to extract more 
information about that crash (scrolling up does not work), but I'm leaving the 
machine like that over night in case someone can tell me.

Kernel version was 3.3.6-3.fc16.x86_64, Ceph cluster is version 0.47.2. The 
crash happened after I issued an rbd command. Another thing that might be 
related is that I stopped and restarted the entire cluster twice since 
mounting the cephfs. The first time, I disabled cephx, the second time I 
enabled it again.

Regards,
	Guido

