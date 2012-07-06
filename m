From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: mds fails to start on SL6
Date: Fri, 6 Jul 2012 16:42:46 +0100
Message-ID: <DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:43704 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757589Ab2GFPmt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 11:42:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id AD8DB83295
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 16:42:48 +0100 (IST)
Received: from tabaet.tchpc.tcd.ie ([127.0.0.1])
	by localhost (tabaet.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTDUS6nFcS+Y for <ceph-devel@vger.kernel.org>;
	Fri,  6 Jul 2012 16:42:47 +0100 (IST)
Received: from x00.tchpc.tcd.ie (x00.tchpc.tcd.ie [134.226.112.149])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id B7DA783289
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 16:42:47 +0100 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I was giving ceph 0.48 a try on SL6x, the OSD's startup okay, but the mds fails to start, below is a snippet of the error,


2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** got signal Terminated ***
2012-07-06 16:38:17.838139 7f2d6828d700  1 mds.-1.0 suicide.  wanted down:dne, now up:boot
2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecter.cc: In function 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-07-06 16:38:17.838156
osdc/Objecter.cc: 221: FAILED assert(initialized)

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: (Objecter::shutdown()+0x170) [0x6e2e20]
 2: (MDS::suicide()+0xc9) [0x4ad829]
 3: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
 4: (SignalHandler::entry()+0x283) [0x803d53]
 5: /lib64/libpthread.so.0() [0x3b3ea077f1]
 6: (clone()+0x6d) [0x3b3e6e5ccd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
    -3> 2012-07-06 16:37:57.786954 7f2d6b496760  0 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030), process ceph-mds, pid 12537
    -2> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** got signal Terminated ***
    -1> 2012-07-06 16:38:17.838139 7f2d6828d700  1 mds.-1.0 suicide.  wanted down:dne, now up:boot
     0> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecter.cc: In function 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-07-06 16:38:17.838156
osdc/Objecter.cc: 221: FAILED assert(initialized)

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: (Objecter::shutdown()+0x170) [0x6e2e20]
 2: (MDS::suicide()+0xc9) [0x4ad829]
 3: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
 4: (SignalHandler::entry()+0x283) [0x803d53]
 5: /lib64/libpthread.so.0() [0x3b3ea077f1]
 6: (clone()+0x6d) [0x3b3e6e5ccd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- end dump of recent events ---
2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught signal (Aborted) **
 in thread 7f2d6828d700

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: /usr/bin/ceph-mds() [0x803309]
 2: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
 3: (gsignal()+0x35) [0x3b3e632885]
 4: (abort()+0x175) [0x3b3e634065]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
     0> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught signal (Aborted) **
 in thread 7f2d6828d700

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: /usr/bin/ceph-mds() [0x803309]
 2: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
 3: (gsignal()+0x35) [0x3b3e632885]
 4: (abort()+0x175) [0x3b3e634065]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- end dump of recent events ---





Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

