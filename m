From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: replicatedPG assert fails
Date: Thu, 21 Jul 2016 10:13:54 -0400
Message-ID: <CAG0LsznhUpP=ub-TmiHSO0A9JZWjk8eov2Lu8y15snqcdG_4Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36583 "EHLO
	mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcGUONz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 10:13:55 -0400
Received: by mail-qt0-f179.google.com with SMTP id 52so44498122qtq.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 07:13:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I am working on a research project which requires multiple write
operations for the same object at the same time from the client. At
the OSD side, I got this error:
osd/ReplicatedPG.cc: In function 'int
ReplicatedPG::find_object_context(const hobject_t&, ObjectContextRef*,
bool, bool, hobject_t*)' thread 7f0586193700 time 2016-07-21
14:02:04.218448
osd/ReplicatedPG.cc: 9041: FAILED assert(oid.pool ==
static_cast<int64_t>(info.pgid.pool()))
 ceph version 10.2.0-2562-g0793a28 (0793a2844baa38f6bcc5c1724a1ceb9f8f1bbd9c)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0x7f059fe6dd7b]
 2: (ReplicatedPG::find_object_context(hobject_t const&,
std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*)+0x1dbb)
[0x7f059f9296fb]
 3: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x186e) [0x7f059f959d7e]
 4: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x73c) [0x7f059f916a0c]
 5: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f5)
[0x7f059f7ced65]
 6: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
const&)+0x5d) [0x7f059f7cef8d]
 7: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x86c) [0x7f059f7f003c]
 8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
[0x7f059fe5e007]
 9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f059fe60160]
 10: (()+0x8184) [0x7f059e2d2184]
 11: (clone()+0x6d) [0x7f059c1e337d]

And at the client side, I got segmentation fault.

I am wondering what will be the possible reason that cause the assert fail?

Thanks,

Sugang
