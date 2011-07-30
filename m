From: Christian Brunner <chb@muc.de>
Subject: FAILED assert(pg_map.count(pgid))
Date: Sat, 30 Jul 2011 20:44:28 +0200
Message-ID: <CAO47_-8BhGWAs_+=1Eegqt0o3qaNcM7ZHD=ecByYdmBb0Ei=-w@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48570 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab1G3So2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2011 14:44:28 -0400
Received: by vxh35 with SMTP id 35so3367698vxh.19
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2011 11:44:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I shifted all my data to new filesystems. I did this, by using the
ceph replication.

During that process other cosd processes (those who had to send the
replication data) died several times. I was able to restart them, but
I think this should not happen.

Here is one log message... (they all looked similar)

Regards,
Christian


7fd23d66e700 osd13 9720 OSD::ms_handle_reset()
7fd23d66e700 osd13 9720 OSD::ms_handle_reset() s=0x3bc46e0
7fd23d66e700 osd13 9720 obc=0x204bcc0
7fd23d66e700 osd13 9720 removing watching session entity_name= from
i-C7DBB69L.rbd/head(9181'620627 client2482097.0:2565
wrlock_by=unknown0.0:0)
osd/OSD.cc: In function 'PG* OSD::_lookup_lock_pg(pg_t)', in thread
'0x7fd23d66e700'#012osd/OSD.cc: 1035: FAILED
assert(pg_map.count(pgid))

ceph version 0.31
(commit:9019c6ce64053ad515a493e912e2e63ba9b8e278)#012 1:
(OSD::_lookup_lock_pg(pg_t)+0x191) [0x507c71]#012 2:
(OSD::lookup_lock_raw_pg(pg_t)+0xdf) [0x51065f]#012 3:
(OSD::put_object_context(void*, pg_t)+0x20) [0x510ca0]#012 4:
(OSD::ms_handle_reset(Connection*)+0x485) [0x511155]#012 5:
(SimpleMessenger::dispatch_entry()+0x1249) [0x5975c9]#012 6:
(SimpleMessenger::DispatchThread::entry()+0x1c) [0x49bfdc]#012 7:
(()+0x77e1) [0x7fd24b73f7e1]#012 8: (clone()+0x6d) [0x7fd24a1818ed]

ceph version 0.31
(commit:9019c6ce64053ad515a493e912e2e63ba9b8e278)#012 1:
(OSD::_lookup_lock_pg(pg_t)+0x191) [0x507c71]#012 2:
(OSD::lookup_lock_raw_pg(pg_t)+0xdf) [0x51065f]#012 3:
(OSD::put_object_context(void*, pg_t)+0x20) [0x510ca0]#012 4:
(OSD::ms_handle_reset(Connection*)+0x485) [0x511155]#012 5:
(SimpleMessenger::dispatch_entry()+0x1249) [0x5975c9]#012 6:
(SimpleMessenger::DispatchThread::entry()+0x1c) [0x49bfdc]#012 7:
(()+0x77e1) [0x7fd24b73f7e1]#012 8: (clone()+0x6d) [0x7fd24a1818ed]

*** Caught signal (Aborted) **#012
in thread 0x7fd23d66e700

ceph version 0.31
(commit:9019c6ce64053ad515a493e912e2e63ba9b8e278)#012 1:
/usr/bin/cosd() [0x5b0124]#012 2: (()+0xf520) [0x7fd24b747520]#012 3:
(gsignal()+0x35) [0x7fd24a0cda45]#012 4: (abort()+0x175)
[0x7fd24a0cf225]#012 5:
(__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7fd24a984a7d]#012
6: (()+0xbcc06) [0x7fd24a982c06]#012 7: (()+0xbcc33)
[0x7fd24a982c33]#012 8: (()+0xbcd2e) [0x7fd24a982d2e]#012 9:
(ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x39f) [0x59326f]#012 10: (OSD::_lookup_lock_pg(pg_t)+0x191)
[0x507c71]#012 11: (OSD::lookup_lock_raw_pg(pg_t)+0xdf) [0x51065f]#012
12: (OSD::put_object_context(void*, pg_t)+0x20) [0x510ca0]#012 13:
(OSD::ms_handle_reset(Connection*)+0x485) [0x511155]#012 14:
(SimpleMessenger::dispatch_entry()+0x1249) [0x5975c9]#012 15:
(SimpleMessenger::DispatchThread::entry()+0x1c) [0x49bfdc]#012 16:
(()+0x77e1) [0x7fd24b73f7e1]#012 17: (clone()+0x6d) [0x7fd24a1818ed]
