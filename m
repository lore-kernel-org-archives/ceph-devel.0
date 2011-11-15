From: Josh Pieper <jjp@pobox.com>
Subject: Assert in OSDMap::Incremental::decode with recent git
Date: Tue, 15 Nov 2011 06:37:47 -0500
Message-ID: <20111115113747.GA32287@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:8236 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab1KOLhu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 06:37:50 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I was trying to test http://tracker.newdream.net/issues/1708, but in
the process of attempting to do so, keep getting asserts in one of my
monitors.

Pretty much all I have done is bring up a simple 3 node cluster, each
with a mon, osd, and mds.  All are using amd64 ubuntu 11.10, with git
2e195500.  Once the cluster is up, I have a rbd load applied which is
a single VM reading large files.  Three times now, I have gotten the
same assert out of mon, inlined below.

Thoughts?

Regards,
Josh

-----------------------------

2011-11-15 06:22:01.912870 7feb50cc37a0 ceph version 0.38-181-g2e19550 (commit:2e195500b5d3a8ab8512bcf2a219a6b7ff922c97), process ceph-mon, pid 29906
2011-11-15 06:22:01.912955 7feb50cc37a0 store(/data/mon2) mount
2011-11-15 06:22:01.971112 7feb50cc37a0 mon.2@2(probing) e1 init fsid eeca00c2-c99c-40d4-9458-5e7ce7dd648c
2011-11-15 06:22:17.597117 7feb4cdd1700 log [INF] : mon.2 calling new monitor election
2011-11-15 06:22:31.034562 7feb4cdd1700 log [INF] : mon.2 calling new monitor election
*** Caught signal (Aborted) **
 in thread 7feb4cdd1700
 ceph version 0.38-181-g2e19550 (commit:2e195500b5d3a8ab8512bcf2a219a6b7ff922c97)
 1: /usr/bin/ceph-mon() [0x5c2fa6]
 2: (()+0x10060) [0x7feb508a4060]
 3: (gsignal()+0x35) [0x7feb4f0253a5]
 4: (abort()+0x17b) [0x7feb4f028b0b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7feb4f8e3d7d]
 6: (()+0xb9f26) [0x7feb4f8e1f26]
 7: (()+0xb9f53) [0x7feb4f8e1f53]
 8: (()+0xba04e) [0x7feb4f8e204e]
 9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x127) [0x596237]
 10: (OSDMap::Incremental::decode(ceph::buffer::list::iterator&)+0x3f) [0x573b6f]
 11: (OSDMonitor::update_from_paxos()+0x7b0) [0x49a9c0]
 12: (PaxosService::_active()+0x39) [0x4933f9]
 13: (Context::complete(int)+0xa) [0x47c12a]
 14: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xca) [0x47da8a]
 15: (Paxos::handle_lease(MMonPaxos*)+0x36d) [0x48aafd]
 16: (Paxos::dispatch(PaxosServiceMessage*)+0x21b) [0x48f4db]
 17: (Monitor::_ms_dispatch(Message*)+0xcbf) [0x47b66f]
 18: (Monitor::ms_dispatch(Message*)+0x35) [0x486425]
 19: (SimpleMessenger::dispatch_entry()+0x84b) [0x583e8b]
 20: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x46612c]
 21: (()+0x7efc) [0x7feb5089befc]
 22: (clone()+0x6d) [0x7feb4f0d089d]
                        

