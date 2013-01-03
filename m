From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: radosgw segfault in 0.56
Date: Thu, 3 Jan 2013 16:54:09 +0100
Message-ID: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:59100 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab3ACPyK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 10:54:10 -0500
Received: by mail-ob0-f181.google.com with SMTP id oi10so13593498obb.40
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 07:54:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


I've just updated a test cluster to 0.56 and I'm getting a segfault
when doing requests on radosgw :

root@ceph /var/log/ceph # /usr/bin/radosgw -n client.radosgw.gateway -f
*** Caught signal (Segmentation fault) **
 in thread 7fee095f8700
 ceph version 0.56 (1a32f0a0b42f169a7b55ed48ec3208f6d4edc1e8)
 1: /usr/bin/radosgw() [0x4783da]
 2: (()+0xfcb0) [0x7fee1a112cb0]
 3: (()+0x89101) [0x7fee18d87101]
 4: (RGWREST::preprocess(req_state*, RGWClientIO*)+0x36) [0x44c456]
 5: (RGWREST::get_handler(RGWRados*, req_state*, RGWClientIO*,
int*)+0x3f) [0x44d70f]
 6: (RGWProcess::handle_request(RGWRequest*)+0x18b) [0x4730bb]
 7: (RGWProcess::RGWWQ::_process(RGWRequest*)+0x36) [0x474f66]
 8: (ThreadPool::worker(ThreadPool::WorkThread*)+0x4bc) [0x4908fc]
 9: (ThreadPool::WorkThread::entry()+0x10) [0x492710]
 10: (()+0x7e9a) [0x7fee1a10ae9a]
 11: (clone()+0x6d) [0x7fee18df1cbd]
2013-01-03 16:48:23.937807 7fee095f8700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7fee095f8700


Anyone seeing something similar to this ?


It's a bit more complete with gdb :

#0  0x00007ffff4f27101 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x000000000044c456 in RGWREST::preprocess(req_state*, RGWClientIO*) ()
#2  0x000000000044d70f in RGWREST::get_handler(RGWRados*, req_state*,
RGWClientIO*, int*) ()
#3  0x00000000004730bb in RGWProcess::handle_request(RGWRequest*) ()
#4  0x0000000000474f66 in RGWProcess::RGWWQ::_process(RGWRequest*) ()
#5  0x00000000004908fc in ThreadPool::worker(ThreadPool::WorkThread*) ()
#6  0x0000000000492710 in ThreadPool::WorkThread::entry() ()
#7  0x00007ffff62aae9a in start_thread () from
/lib/x86_64-linux-gnu/libpthread.so.0
#8  0x00007ffff4f91cbd in clone () from /lib/x86_64-linux-gnu/libc.so.6
#9  0x0000000000000000 in ?? ()


Cheers,

    Sylvain
