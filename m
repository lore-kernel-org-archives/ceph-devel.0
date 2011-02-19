From: Henry Chang <henry.cy.chang@gmail.com>
Subject: deadlock problem of client + osd
Date: Sun, 20 Feb 2011 00:53:43 +0800
Message-ID: <AANLkTik7ouc8vKZROLf2kvcNOtzYi+toa_xHNfwR+cq3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55402 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1BSQxp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Feb 2011 11:53:45 -0500
Received: by ewy5 with SMTP id 5so1942389ewy.19
        for <ceph-devel@vger.kernel.org>; Sat, 19 Feb 2011 08:53:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I have a ceph cluster of 3 mons,  2 mdses and 6 osds. The ceph clients
live along with 3 of the 6 osds.
I was running iozone on each client to generate the workload. After
hours, I found that one osd (with the client on it) hung.

The call stacks of three most suspicious threads of the cosd are:

[<ffffffff813abeec>] sock_common_recvmsg+0x39/0x4a
[<ffffffff813a9853>] __sock_recvmsg+0x71/0x7c
[<ffffffff813a9e11>] sock_recvmsg+0xcf/0xe8
[<ffffffff813ab189>] sys_recvfrom+0xd7/0x141
[<ffffffff81012d32>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff

[<ffffffffa01634e7>] ceph_osdc_wait_request+0x22/0xc7 [libceph]
[<ffffffffa0164851>] ceph_osdc_writepages+0xf8/0x169 [libceph]
[<ffffffffa018f34d>] writepage_nounlock+0x262/0x3df [ceph]
[<ffffffffa0190292>] ceph_writepage+0x3b/0x58 [ceph]
[<ffffffff810e24ed>] pageout+0x137/0x203
[<ffffffff810e29d0>] shrink_page_list+0x265/0x483
[<ffffffff810e2fb4>] shrink_inactive_list+0x3c6/0x6ee
[<ffffffff810e3393>] shrink_list+0xb7/0xc3
[<ffffffff810e3678>] shrink_zone+0x2d9/0x37a
[<ffffffff810e393f>] do_try_to_free_pages+0x226/0x3a0
[<ffffffff810e3bb3>] try_to_free_pages+0x6e/0x70
[<ffffffff810ddb75>] __alloc_pages_nodemask+0x3e4/0x62d
[<ffffffff81106e0f>] alloc_pages_current+0x95/0x9e
[<ffffffff813f3890>] tcp_sendmsg+0x3e7/0x876
[<ffffffff813a97d7>] __sock_sendmsg+0x61/0x6c
[<ffffffff813a9f3c>] sock_sendmsg+0xcc/0xe5
[<ffffffff813aa176>] sys_sendmsg+0x221/0x2a5
[<ffffffff81012d32>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff

[<ffffffff813aca66>] lock_sock_nested+0x94/0xca
[<ffffffff8140eb7e>] inet_shutdown+0x3e/0xe9
[<ffffffff813a990f>] sys_shutdown+0x45/0x61
[<ffffffff81012d32>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0

I wonder if it is the so-called "deadlock" problem when the client and
the osd are running on the same node?

-- 
Henry Chang
