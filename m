From: Noah Watkins <noah.watkins@inktank.com>
Subject: assertion failure in update_from_paxos
Date: Tue, 9 Jul 2013 08:37:33 -0700
Message-ID: <CA+Hcz5_EeKy=stHHKUvL4QkpGT8KsMc7dpr7KAppwBcDAMjLug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:41724 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3GIPhe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 11:37:34 -0400
Received: by mail-ve0-f181.google.com with SMTP id db10so4765275veb.12
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jul 2013 08:37:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm getting the following failure when running a vstart instance with
1 of each daemon.

--

0> 2013-07-09 08:30:43.213345 7fdc289e97c0 -1 mon/OSDMonitor.cc: In
function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
7fdc289e97c0 time 2013-07-09 08:30:43.207686
mon/OSDMonitor.cc: 129: FAILED assert(latest_bl.length() != 0)

 ceph version 0.65-307-g0e93dd9 (0e93dd93e5439fb82c416cb8eec7f36598ae7b48)
 1: (OSDMonitor::update_from_paxos(bool*)+0x16bd) [0x5ad5ed]
 2: (PaxosService::refresh(bool*)+0x143) [0x592963]
 3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x536c87]
 4: (Paxos::finish_proposal()+0x3a) [0x58c13a]
 5: (Paxos::begin(ceph::buffer::list&)+0x82c) [0x58bbac]
 6: (Paxos::propose_queued()+0xd9) [0x58be79]
 7: (Paxos::propose_new_value(ceph::buffer::list&, Context*)+0x140) [0x58d230]
 8: (PaxosService::propose_pending()+0x6c8) [0x593c28]
 9: (PaxosService::_active()+0x58b) [0x5956fb]
 10: (PaxosService::election_finished()+0x328) [0x595c38]
 11: (Monitor::win_election(unsigned int, std::set<int,
std::less<int>, std::allocator<int> >&, unsigned long)+0x2e5)
[0x55ae05]
 12: (Monitor::win_standalone_election()+0x197) [0x55b027]
 13: (Monitor::bootstrap()+0x84b) [0x55b8fb]
 14: (Monitor::init()+0xad) [0x55bbcd]
 15: (main()+0x1ac7) [0x5296b7]
 16: (__libc_start_main()+0xf5) [0x3f2dc21b75]
 17: ./ceph-mon() [0x52e259]
