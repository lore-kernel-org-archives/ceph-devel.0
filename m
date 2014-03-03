From: Noah Watkins <noah.watkins@inktank.com>
Subject: ceph-osd seg-fault with small writes
Date: Mon, 3 Mar 2014 14:02:16 -0800
Message-ID: <CA+Hcz58AJCccK_gSrt9dtBVRopyP7LHS2piUCcqXemHei=ek+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:39900 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbaCCWCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 17:02:17 -0500
Received: by mail-qc0-f177.google.com with SMTP id w7so4396845qcr.8
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 14:02:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Running rados bench with the default 4MB object size works fine, but
when I shrink the write size to 4K (i.e. running `rados -p data -b
4096 bench 30 write`), ceph-osd will segfault almost immediately.

Here is the segfault, and a link to the full debug uploaded using
ceph-post-file.

ceph-post-file id: f9c8a1f8-969f-46c2-9cef-41b4683fdc76

 ceph version 0.77-624-g82f62b1 (82f62b1ea82f6d92f7a5ed0bcbacd608770a15e3)
 1: ./ceph-osd() [0x95dbaf]
 2: (()+0xfbb0) [0x7f3f1f2f4bb0]
 3: (gsignal()+0x37) [0x7f3f1d7cdf77]
 4: (abort()+0x148) [0x7f3f1d7d15e8]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f3f1e0d96e5]
 6: (()+0x5e856) [0x7f3f1e0d7856]
 7: (()+0x5e883) [0x7f3f1e0d7883]
 8: (()+0x5eaae) [0x7f3f1e0d7aae]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x1f2) [0xa3d1b2]
 10: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
long, int, ThreadPool::TPHandle*)+0x8e9) [0x749c59]
 11: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, unsigned long,
ThreadPool::TPHandle*)+0x6c) [0x74d88c]
 12: (FileStore::_do_op(FileStore::OpSequencer*,
ThreadPool::TPHandle&)+0x167) [0x74da17]
 13: (ThreadPool::worker(ThreadPool::WorkThread*)+0xaef) [0xa2dfdf]
 14: (ThreadPool::WorkThread::entry()+0x10) [0xa2eed0]
 15: (()+0x7f6e) [0x7f3f1f2ecf6e]
 16: (clone()+0x6d) [0x7f3f1d8919cd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
