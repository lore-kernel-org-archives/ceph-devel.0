From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: MDS crash
Date: Fri, 28 Oct 2011 15:57:40 -0700 (PDT)
Message-ID: <1348706885.13037.1319842660241.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:55085 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932935Ab1J1W5k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 18:57:40 -0400
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 52E311009BFC
	for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2011 15:57:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is a trace of an MDS crash. I was running a simple setup (./vstart -d -n), and this is from out/mds.b

This is from the latest wip-getdir branch. I posted some context preceding the crash. I have the full trace if more context is helpful.

-Noah

================================

2011-10-28 15:50:00.251876 7f2f3102b700 mds.1.cache.dir(100000003f6) pop_and_dirty_projected_fnode 0x13ab180 v55
2011-10-28 15:50:00.251902 7f2f3102b700 mds.1.cache.dir(100000003f6) mark_dirty (already dirty) [dir 100000003f6 /tmp/hadoop-nwatkins/mapred/staging/nwatkins/.staging/ [2,head] auth{0=1} pv=55 v=55 cv=0/0 ap=1+2+2 state=1610612738|complete f(v0 m2011-10-28 15:50:00.116185 3=0+3)->f(v0 m2011-10-28 15:50:00.116185 3=0+3) n(v5 rc2011-10-28 15:50:00.116185 b284930 5=2+3)->n(v5 rc2011-10-28 15:50:00.116185 b284930 5=2+3) hs=3+1,ss=0+0 dirty=4 | child replicated dirty authpin 0x12b6770] version 55
2011-10-28 15:50:00.251909 7f2f3102b700 mds.1.cache.dir(100000003f5) pop_and_dirty_projected_fnode 0x13abb40 v52
2011-10-28 15:50:00.251936 7f2f3102b700 mds.1.cache.dir(100000003f5) mark_dirty (already dirty) [dir 100000003f5 /tmp/hadoop-nwatkins/mapred/staging/nwatkins/ [2,head] auth{0=1} pv=52 v=52 cv=0/0 ap=1+1+2 state=1610612738|complete f(v0 m2011-10-28 15:39:07.835948 1=0+1)->f(v0 m2011-10-28 15:39:07.835948 1=0+1) n(v9 rc2011-10-28 15:50:00.116185 b284930 6=2+4)/n(v9 rc2011-10-28 15:46:30.070103 b284930 5=2+3)->n(v9 rc2011-10-28 15:50:00.116185 b284930 6=2+4)/n(v9 rc2011-10-28 15:46:30.070103 b284930 5=2+3) hs=1+0,ss=0+0 dirty=1 | child replicated dirty authpin 0x12b6378] version 52
2011-10-28 15:50:00.251957 7f2f3102b700 mds.1.cache send_dentry_link [dentry #1/tmp/hadoop-nwatkins/mapred/staging/nwatkins/.staging/job_201110281545_0003 [2,head] auth (dn xlock x=1 by 0x135bc00) (dversion lock w=1 last_client=4242) v=54 ap=2+0 inode=0x1311b60 | request lock inodepin dirty authpin 0x1345d80]
2011-10-28 15:50:00.251980 7f2f3102b700 mds.1.server reply_request 0 (Success) client_request(client.4242:11 mkdir #100000003f6/job_201110281545_0003) v1
2011-10-28 15:50:00.251990 7f2f3102b700 mds.1.server apply_allocated_inos 20000000004 / [20000000005~3e8] / 0
2011-10-28 15:50:00.252002 7f2f3102b700 mds.1.inotable: apply_alloc_id 20000000004 to [200000003ed~2fffffffc12]/[200000003ec~2fffffffc13]
./include/interval_set.h: In function 'void interval_set<T>::erase(T, T) [with T = inodeno_t]', in thread '7f2f3102b700'
./include/interval_set.h: 385: FAILED assert(p->first <= start)
 ceph version 0.37-192-g1a4eec2 (commit:1a4eec20a345ced993a48012aaaa8d8ca344a1ba)
 1: (InoTable::apply_alloc_id(inodeno_t)+0x441) [0x647041]
 2: (Server::apply_allocated_inos(MDRequest*)+0x4dd) [0x509f3d]
 3: (Server::reply_request(MDRequest*, MClientReply*, CInode*, CDentry*)+0x83) [0x50a283]
 4: (C_MDS_mknod_finish::finish(int)+0xfe) [0x53686e]
 5: (Context::complete(int)+0xa) [0x4a4d7a]
 6: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xc8) [0x4c3568]
 7: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x18f) [0x69dd9f]
 8: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xc57) [0x686c47]
 9: (MDS::handle_core_message(Message*)+0x987) [0x4bedf7]
 10: (MDS::_dispatch(Message*)+0x2f) [0x4bef8f]
 11: (MDS::ms_dispatch(Message*)+0x70) [0x4c06f0]
 12: (SimpleMessenger::dispatch_entry()+0x833) [0x6edd13]
 13: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x49ed7c]
 14: (()+0x7efc) [0x7f2f348f0efc]
 15: (clone()+0x6d) [0x7f2f3332a89d]
 ceph version 0.37-192-g1a4eec2 (commit:1a4eec20a345ced993a48012aaaa8d8ca344a1ba)
 1: (InoTable::apply_alloc_id(inodeno_t)+0x441) [0x647041]
 2: (Server::apply_allocated_inos(MDRequest*)+0x4dd) [0x509f3d]
 3: (Server::reply_request(MDRequest*, MClientReply*, CInode*, CDentry*)+0x83) [0x50a283]
 4: (C_MDS_mknod_finish::finish(int)+0xfe) [0x53686e]
 5: (Context::complete(int)+0xa) [0x4a4d7a]
 6: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xc8) [0x4c3568]
 7: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x18f) [0x69dd9f]
 8: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xc57) [0x686c47]
 9: (MDS::handle_core_message(Message*)+0x987) [0x4bedf7]
 10: (MDS::_dispatch(Message*)+0x2f) [0x4bef8f]
 11: (MDS::ms_dispatch(Message*)+0x70) [0x4c06f0]
 12: (SimpleMessenger::dispatch_entry()+0x833) [0x6edd13]
 13: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x49ed7c]
 14: (()+0x7efc) [0x7f2f348f0efc]
 15: (clone()+0x6d) [0x7f2f3332a89d]
*** Caught signal (Aborted) **
 in thread 7f2f3102b700
 ceph version 0.37-192-g1a4eec2 (commit:1a4eec20a345ced993a48012aaaa8d8ca344a1ba)
 1: ./ceph-mds() [0x777fb6]
 2: (()+0x10060) [0x7f2f348f9060]
 3: (gsignal()+0x35) [0x7f2f3327f3a5]
 4: (abort()+0x17b) [0x7f2f33282b0b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f2f33b3dd7d]
 6: (()+0xb9f26) [0x7f2f33b3bf26]
 7: (()+0xb9f53) [0x7f2f33b3bf53]
 8: (()+0xba04e) [0x7f2f33b3c04e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x193) [0x6fedf3]
 10: (InoTable::apply_alloc_id(inodeno_t)+0x441) [0x647041]
 11: (Server::apply_allocated_inos(MDRequest*)+0x4dd) [0x509f3d]
 12: (Server::reply_request(MDRequest*, MClientReply*, CInode*, CDentry*)+0x83) [0x50a283]
 13: (C_MDS_mknod_finish::finish(int)+0xfe) [0x53686e]
 14: (Context::complete(int)+0xa) [0x4a4d7a]
 15: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xc8) [0x4c3568]
 16: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x18f) [0x69dd9f]
 17: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xc57) [0x686c47]
 18: (MDS::handle_core_message(Message*)+0x987) [0x4bedf7]
 19: (MDS::_dispatch(Message*)+0x2f) [0x4bef8f]
 20: (MDS::ms_dispatch(Message*)+0x70) [0x4c06f0]
 21: (SimpleMessenger::dispatch_entry()+0x833) [0x6edd13]
 22: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x49ed7c]
 23: (()+0x7efc) [0x7f2f348f0efc]
 24: (clone()+0x6d) [0x7f2f3332a89d]
