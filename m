From: Christian Brunner <chb@muc.de>
Subject: osd/ReplicatedPG.cc:2403: FAILED assert(!missing.is_missing(soid))
Date: Tue, 26 Oct 2010 14:14:58 +0200
Message-ID: <AANLkTim_-Je553u5FVv6bdhCirz1t90KQEUG=icmMr5-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34948 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab0JZMO7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 08:14:59 -0400
Received: by gyg4 with SMTP id 4so2753184gyg.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Oct 2010 05:14:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here is another problem (I think it's unrelated to the previous, but
I'm not sure).

One of our osds crashed with the following message:

osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_modify(MOSDSubOp*)':
osd/ReplicatedPG.cc:2403: FAILED assert(!missing.is_missing(soid))
ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (OSD::dequeue_op(PG*)+0x374) [0x4d27a4]
2: (ThreadPool::worker()+0x291) [0x5b69d1]
3: (ThreadPool::WorkThread::entry()+0xd) [0x4f36dd]
4: (Thread::_entry_func(void*)+0x7) [0x470927]
5: (()+0x77e1) [0x7fe83e60e7e1]
6: (clone()+0x6d) [0x7fe83d83251d]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
*** Caught signal (ABRT) ***
ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (sigabrt_handler(int)+0x7d) [0x5c767d]
2: (()+0x32a30) [0x7fe83d783a30]
3: (gsignal()+0x35) [0x7fe83d7839b5]
4: (abort()+0x175) [0x7fe83d785195]
5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7fe83e028aad]
6: (()+0xbcc36) [0x7fe83e026c36]
7: (()+0xbcc63) [0x7fe83e026c63]
8: (()+0xbcd5e) [0x7fe83e026d5e]
9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x448) [0x5b5338]
10: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0x719) [0x48d8b9]
11: (OSD::dequeue_op(PG*)+0x374) [0x4d27a4]
12: (ThreadPool::worker()+0x291) [0x5b69d1]
13: (ThreadPool::WorkThread::entry()+0xd) [0x4f36dd]
14: (Thread::_entry_func(void*)+0x7) [0x470927]
15: (()+0x77e1) [0x7fe83e60e7e1]
16: (clone()+0x6d) [0x7fe83d83251d]

When we are trying to restart the cosd, we can see the following log-output:

2010-10-26 13:51:52.176904 7f005e83e720 journal read_entry
10102640640: seq 188804 728 bytes
2010-10-26 13:51:52.308172 7f0054f31710 osd5 39 map says i am down or
have a different address.  switching to boot state.
2010-10-26 13:51:52.308222 7f0054f31710 log [WRN] : map e39 wrongly
marked me down
2010-10-26 13:51:56.097515 7f0054f31710 journal throttle: waited for ops

After that we are unable to do any rados operations in our cluster.
The only way to solve this, was killing the cosd again.

Regards,
Christian
