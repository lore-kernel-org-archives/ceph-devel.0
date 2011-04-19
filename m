From: Mark Nigh <mnigh@netelligent.com>
Subject: mds crash
Date: Tue, 19 Apr 2011 10:18:31 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C6788452D627@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:45820 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752347Ab1DSPT3 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Apr 2011 11:19:29 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I recently have been working with exporting ceph to NFS. I have had stability problems with NFS (ceph is working but NFS crashes). But most recently, my mds0 will not start after one of these instances with NFS.

My setup. 2 mds, 1 mon (located on mds0), 5 osds. All running Ubuntu v10.10.

Here is the output when I try to start the mds0. Is there other debugging I can turn on?

/etc/init.d/ceph start mds0

2011-04-19 10:06:58.602640 7fb202fe4700 mds0.11 ms_handle_connect on 10.6.1.93:6800/945
./include/elist.h: In function 'elist<T>::item::~item() [with T = MDSlaveUpdate*]', in thread '0x7fb2004d5700'
./include/elist.h: 39: FAILED assert(!is_on_list())
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: (MDSlaveUpdate::~MDSlaveUpdate()+0x59) [0x4d9fe9]
 2: (ESlaveUpdate::replay(MDS*)+0x422) [0x4d2772]
 3: (MDLog::_replay_thread()+0xb90) [0x67f850]
 4: (MDLog::ReplayThread::entry()+0xd) [0x4b89ed]
 5: (()+0x7971) [0x7fb20564a971]
 6: (clone()+0x6d) [0x7fb2042e692d]
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: (MDSlaveUpdate::~MDSlaveUpdate()+0x59) [0x4d9fe9]
 2: (ESlaveUpdate::replay(MDS*)+0x422) [0x4d2772]
 3: (MDLog::_replay_thread()+0xb90) [0x67f850]
 4: (MDLog::ReplayThread::entry()+0xd) [0x4b89ed]
 5: (()+0x7971) [0x7fb20564a971]
 6: (clone()+0x6d) [0x7fb2042e692d]
*** Caught signal (Aborted) **
 in thread 0x7fb2004d5700
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: /usr/bin/cmds() [0x70fc38]
 2: (()+0xfb40) [0x7fb205652b40]
 3: (gsignal()+0x35) [0x7fb204233ba5]
 4: (abort()+0x180) [0x7fb2042376b0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fb204ad76bd]
 6: (()+0xb9906) [0x7fb204ad5906]
 7: (()+0xb9933) [0x7fb204ad5933]
 8: (()+0xb9a3e) [0x7fb204ad5a3e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x36a) [0x6f5eaa]
 10: (MDSlaveUpdate::~MDSlaveUpdate()+0x59) [0x4d9fe9]
 11: (ESlaveUpdate::replay(MDS*)+0x422) [0x4d2772]
 12: (MDLog::_replay_thread()+0xb90) [0x67f850]
 13: (MDLog::ReplayThread::entry()+0xd) [0x4b89ed]
 14: (()+0x7971) [0x7fb20564a971]
 15: (clone()+0x6d) [0x7fb2042e692d]

I am not sure why the IP address of 0.0.0.0 shows up with starting the mds0.

root@mds0:/var/log/ceph# /etc/init.d/ceph start mds0
=== mds.0 ===
Starting Ceph mds.0 on mds0...
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
starting mds.0 at 0.0.0.0:6800/2994

Thanks for your assistance.

Mark Nigh
Systems Architect
mnigh@netelligent.com
 (p) 314.392.6926




This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
