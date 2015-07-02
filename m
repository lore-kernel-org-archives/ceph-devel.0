From: =?UTF-8?Q?=C5=81ukasz_Redynk?= <lukas.redynk@gmail.com>
Subject: Memstore & fio + librbd crash on 0.94.1
Date: Thu, 2 Jul 2015 10:30:01 +0200
Message-ID: <CADkk3is4aYX-KBtZdAQ+pPXu=_ECCFnS4+y4q1HoJ5E-vz-ufw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33754 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbbGBIae (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2015 04:30:34 -0400
Received: by laar3 with SMTP id r3so56251591laa.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2015 01:30:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

My setup:
- 5 physical nodes
- 1 MON
- 4 OSD
- OS: CentOS 7
- Ceph: 0.94.1
- rbd_cache = false

Lately I was benchmarking Ceph 0.94.1 rbd devices created in Memstore
with fio + librbd and I encountered intersting crash:

 1: /usr/bin/ceph-osd() [0xb81872]
 2: (()+0xf130) [0x7f02fba00130]
 3: (gsignal()+0x39) [0x7f02fa41a989]
 4: (abort()+0x148) [0x7f02fa41c098]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f02fad1e9d5]
 6: (()+0x5e946) [0x7f02fad1c946]
 7: (()+0x5e973) [0x7f02fad1c973]
 8: (()+0x5eb9f) [0x7f02fad1cb9f]
 9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x137) [0xcf6057]
 10: (void decode<unsigned long, unsigned long>(std::map<unsigned
long, unsigned long, std::less<unsigned long>, std::allocator<std::
pair<unsigned long const, unsigned long> > >&,
ceph::buffer::list::iterator&)+0x3e) [0x96c65e]
 11: (ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*,
std::vector<OSDOp, std::allocator<OSDOp> >&)+0x7018) [0x930588]
 12: (ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*)+0xbf)
[0x93e59f]
 13: (ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*)+0x5f1) [0x93ee11]
 14: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>&)+0x45d7) [0x944bc7]
 15: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x68a) [0x8dd2fa]
 16: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409)
[0x6cf3d9]
 17: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x32f) [0x6cf9ef]
 18: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x86f)
[0xc70f6f]
 19: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xc730a0]
 20: (()+0x7df3) [0x7f02fb9f8df3]
 21: (clone()+0x6d) [0x7f02fa4db3dd]

It was related to the implementation of Memstore::fiemap function
called in ReplicatedPG::do_osd_op for sparse read command: when offset
was bigger then object size then Memstore::fiemap was just returning
'0', ReplicatedPG::do_osd_ops was interpreting it as "ok" and starting
to decode bufferlist of extents, which was empty, and this was main
cause of crash.

It looks like Filestore isn't affected by this issue, fiemap syscall
is returning with error, or when fiemap is not available it's just
encoding [offset,length] (without *any* validation of input
parameters).

Now I'm wondering about best way to fix it, mimic behavior of fiemap
(the long way)? Or implement it similar to the Filestore (with backend
not supporting fiemap, the fast way)?

Other thing is should OSD try to read past object's boundary?

And my other question: I'm encountering this issue *every* time on
physical cluster and I'm not able to reproduce it even *once* on
vstart cluster with the same configuration. Is there any way to force
sparse reads with librbd?

-Lukas
