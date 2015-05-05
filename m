From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Newstore Read ?
Date: Tue, 5 May 2015 15:11:42 -0700
Message-ID: <CAFkUHxe6fiewz78H4CTuPghqJr6nTdJq4Ucn2O6H1uEqVGgKqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33499 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbEEWLm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 18:11:42 -0400
Received: by pacwv17 with SMTP id wv17so207267126pac.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 15:11:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I am unable to get any reads out of Newstore. The log is filled with
assert failures.

> 2015-05-05 14:49:46.654113 7f4236387700 -1 os/newstore/NewStore.cc: In function 'virtual int NewStore::fiemap(coll_t, const ghobject_t&, uint64_t, size_t, ceph::bufferlist&)' thread 7f4236387700 time 2015-05-05 14:49:46.582991

os/newstore/NewStore.cc: 1371: FAILED assert(0)


 ceph version 0.93-1098-g66e555d (66e555d4a6e2fd21efd9da0d1ebd3feb024b041e)

 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0xc9bdeb]

 2: ceph-osd() [0x9ea293]

 3: (ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*,
std::vector<OSDOp, std::allocator<OSDOp> >&)+0x708c) [0x8d8ccc]

 4: (ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*)+0x97)
[0x8e6427]

 5: (ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*)+0x5e5) [0x8e6c85]

 6: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>&)+0x2907) [0x8eac87]

 7: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x66a) [0x877bea]

 8: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3bd)
[0x6d94fd]

 9: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x331) [0x6d9a21]

 10: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x875)
[0xc77905]

 11: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xc79a20]

 12: (()+0x8182) [0x7f427fe7c182]

 13: (clone()+0x6d) [0x7f427de8e47d]

 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

Is anyone else seeing this ?

-Neo
