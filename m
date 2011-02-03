From: Chris Dunlop <chris@onthe.net.au>
Subject: cmon: PGMonitor::encode_pending() assert failure
Date: Thu, 3 Feb 2011 01:51:40 +0000 (UTC)
Message-ID: <slrnikk2hd.jh1.chris@chris.onthe.net.au>
Reply-To: chris@onthe.net.au
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60883 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab1BCBvy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Feb 2011 20:51:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkoMS-0006Fl-Rt
	for ceph-devel@vger.kernel.org; Thu, 03 Feb 2011 02:51:52 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 03 Feb 2011 02:51:52 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 03 Feb 2011 02:51:52 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

I received this assert failure after copying about 110 GB of data into
a previously-empty ceph 0.24.2:

ceph version 0.25~rc (commit:73e76723e35562c9391872e07cf314b4465f30af)
2011-02-03 08:05:26.779951 409b9950 mon.0@0(leader).pg v19635 PGMonitor::update_from_paxos: error parsing incremental update: buffer::end_of_buffer
2011-02-03 08:05:28.651238 42b99950 mon.0@0(leader).pg v19635 PGMonitor::update_from_paxos: error parsing incremental update: buffer::end_of_buffer
mon/PGMonitor.cc: In function 'virtual void PGMonitor::encode_pending(ceph::bufferlist&)', In thread 409b9950
mon/PGMonitor.cc:178: FAILED assert(paxos->get_version() + 1 == pending_inc.version)
 ceph version 0.25~rc (commit:73e76723e35562c9391872e07cf314b4465f30af)
 1: (PGMonitor::encode_pending(ceph::buffer::list&)+0x442) [0x4d4332]
 2: (PaxosService::propose_pending()+0x26d) [0x4995ad]
 3: (SafeTimer::timer_thread()+0x65f) [0x5602bf]
 4: (SafeTimerThread::entry()+0xd) [0x563a3d]
 5: (Thread::_entry_func(void*)+0xa) [0x46fe0a]
 6: /lib/libpthread.so.0 [0x7f282fd87fc7]
 7: (clone()+0x6d) [0x7f282ec6764d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
*** Caught signal (Aborted) ***
in thread 409b9950
 ceph version 0.25~rc (commit:73e76723e35562c9391872e07cf314b4465f30af)
 1: /usr/bin/cmon [0x58054e]
 2: /lib/libpthread.so.0 [0x7f282fd8fa80]
 3: (gsignal()+0x35) [0x7f282ebc9ed5]
 4: (abort()+0x183) [0x7f282ebcb3f3]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x114) [0x7f282f44d294]
 6: /usr/lib/libstdc++.so.6 [0x7f282f44b696]
 7: /usr/lib/libstdc++.so.6 [0x7f282f44b6c3]
 8: /usr/lib/libstdc++.so.6 [0x7f282f44b7aa]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x3f4) [0x563f84]
 a: (PGMonitor::encode_pending(ceph::buffer::list&)+0x442) [0x4d4332]
 b: (PaxosService::propose_pending()+0x26d) [0x4995ad]
 c: (SafeTimer::timer_thread()+0x65f) [0x5602bf]
 d: (SafeTimerThread::entry()+0xd) [0x563a3d]
 e: (Thread::_entry_func(void*)+0xa) [0x46fe0a]
 f: /lib/libpthread.so.0 [0x7f282fd87fc7]
 10: (clone()+0x6d) [0x7f282ec6764d]

If needed, the cmon executable is available here:

http://www.onthe.net.au/private/cmon.gz

If you need any other info, just holler!

Cheers,

Chris

