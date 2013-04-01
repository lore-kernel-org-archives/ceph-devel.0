From: Travis Rhoden <trhoden@gmail.com>
Subject: Kernel BUG using RBD module
Date: Mon, 1 Apr 2013 16:16:48 -0400
Message-ID: <CACkq2mq+r6WiCeDJem5tfxb1dKpDGYguUaH3fnjrBipr8gumwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:57007 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205Ab3DAURK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Apr 2013 16:17:10 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so1081318bkc.1
        for <ceph-devel@vger.kernel.org>; Mon, 01 Apr 2013 13:17:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello folks,

Ran into this one today on a machine using kRBD.  Completely locked the machine:

Apr  1 17:35:10 nfs1 kernel: [492418.251665] Call Trace:
Apr  1 17:35:10 nfs1 kernel: [492418.251675]  [<ffffffffa02086b4>]
reset_changed_osds+0x74/0xa0 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251682]  [<ffffffffa020b0c2>]
ceph_osdc_handle_map+0x212/0x3e0 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251689]  [<ffffffffa0207547>]
dispatch+0xa7/0x120 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251694]  [<ffffffffa0201045>]
process_message+0xa5/0xc0 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251700]  [<ffffffffa0204fa1>]
try_read+0x2e1/0x440 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251705]  [<ffffffffa0205100>] ?
try_read+0x440/0x440 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251711]  [<ffffffffa0205192>]
con_work+0x92/0x1c0 [libceph]
Apr  1 17:35:10 nfs1 kernel: [492418.251716]  [<ffffffff81071baa>]
process_one_work+0x11a/0x480
Apr  1 17:35:10 nfs1 kernel: [492418.251720]  [<ffffffff81072bc5>]
worker_thread+0x165/0x370
Apr  1 17:35:10 nfs1 kernel: [492418.251723]  [<ffffffff81072a60>] ?
manage_workers.isra.29+0x130/0x130
Apr  1 17:35:10 nfs1 kernel: [492418.251727]  [<ffffffff81077b63>]
kthread+0x93/0xa0
Apr  1 17:35:10 nfs1 kernel: [492418.251733]  [<ffffffff816a3ee4>]
kernel_thread_helper+0x4/0x10
Apr  1 17:35:10 nfs1 kernel: [492418.251736]  [<ffffffff81077ad0>] ?
flush_kthread_worker+0xb0/0xb0
Apr  1 17:35:10 nfs1 kernel: [492418.251739]  [<ffffffff816a3ee0>] ?
gs_change+0x13/0x13


Anybody run into this before?

I'm running kernel 3.5.7.2

I came across a few patches that touch relevant functions:
https://patchwork.kernel.org/patch/1913871/

From what i can tell, this can pulled into 3.4.26 and 3.7.3.  I can't
tell if it went into 3.5.x at all.

Is this a known bug that's already been fixed?

This happened while I was doing a rolling upgrade of the Ceph cluster
-- doing a "service ceph restart osd.$x" for 60 OSDs.  30 second sleep
in between each to allow things to settle.

 - Travis
