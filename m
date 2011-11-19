From: Josh Pieper <jjp@pobox.com>
Subject: A couple more ceph-mon crashes
Date: Sat, 19 Nov 2011 10:03:09 -0500
Message-ID: <20111119150309.GA13985@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:64931 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab1KSPEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Nov 2011 10:04:16 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I observed the following two crashes using the same test setup I have
had for the previous reports.  3x ubuntu 11.04 amd64 nodes with an rbd
load, this time each running cc5b5e17.

Links to the full logs are below each stack trace snip.

mon/OSDMonitor.cc: In function 'MOSDMap* OSDMonitor::build_incremental(epoch_t, epoch_t)', in thread '7fd11a363700'
mon/OSDMonitor.cc: 944: FAILED assert(0)
 ceph version 0.38-202-gcc5b5e1 (commit:cc5b5e17e64c011b68cc8560676182e187bbb503)
 1: (OSDMonitor::build_incremental(unsigned int, unsigned int)+0xc86) [0x497f76]
 2: (OSDMonitor::committed()+0x162) [0x49a1f2]
 3: (PaxosService::_commit()+0x19e) [0x491fee]
 4: (Context::complete(int)+0xa) [0x47c10a]
 5: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xca) [0x47da6a]
 6: (Paxos::handle_accept(MMonPaxos*)+0x5b4) [0x48dbc4]
 7: (Paxos::dispatch(PaxosServiceMessage*)+0x23b) [0x48f38b]
 8: (Monitor::_ms_dispatch(Message*)+0xcbf) [0x47b64f]
 9: (Monitor::ms_dispatch(Message*)+0x35) [0x486405]

http://joshp.no-ip.com:8080/20111119-mon-build_incremental.log


mon/PaxosService.cc: In function 'void PaxosService::propose_pending()', in thread '7f4dd6acd700'
mon/PaxosService.cc: 127: FAILED assert(have_pending)
 ceph version 0.38-202-gcc5b5e1 (commit:cc5b5e17e64c011b68cc8560676182e187bbb503)
 1: (PaxosService::propose_pending()+0x335) [0x4924b5]
 2: (PGMonitor::check_osd_map(unsigned int)+0xcb0) [0x4d42e0]
 3: (Context::complete(int)+0xa) [0x47c10a]
 4: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xca) [0x47da6a]
 5: (Paxos::handle_accept(MMonPaxos*)+0x5d8) [0x48dbe8]
 6: (Paxos::dispatch(PaxosServiceMessage*)+0x23b) [0x48f38b]
 7: (Monitor::_ms_dispatch(Message*)+0xcbf) [0x47b64f]
 8: (Monitor::ms_dispatch(Message*)+0x35) [0x486405]

http://joshp.no-ip.com:8080/20111119-mon-propose_pending.log

-Josh
