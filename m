From: "Jim Schutt" <jaschut@sandia.gov>
Subject: osd/OSDMap.h: 330: FAILED assert(is_up(osd))
Date: Tue, 17 Jul 2012 14:49:34 -0600
Message-ID: <5005CFDE.5010100@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:59233 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab2GQUuE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 16:50:04 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 169C6D2C889
	for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 14:50:03 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 14:49:49 -0600
Received: from mail.sandia.gov (exch02.sandia.gov [134.253.103.2] (may
 be forged)) by mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id
 q6HKngkM016136 for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012
 14:49:43 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Recent master branch is asserting for me like this:

  ceph version 0.48argonaut-404-gabe05a3 (commit:abe05a3fbbb120d8d354623258d9104584db66f7)
  1: (OSDMap::get_cluster_inst(int) const+0xc9) [0x58cde9]
  2: (OSD::handle_osd_ping(MOSDPing*)+0x8cf) [0x5d4b4f]
  3: (OSD::heartbeat_dispatch(Message*)+0x71) [0x5d5491]
  4: (SimpleMessenger::DispatchQueue::entry()+0x583) [0x7d5683]
  5: (SimpleMessenger::dispatch_entry()+0x15) [0x7d6a05]
  6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7957bd]
  7: (()+0x77f1) [0x7ffff76507f1]
  8: (clone()+0x6d) [0x7ffff6aa1ccd]

gdb had this to say:

(gdb) bt
#0  0x00007ffff765836b in raise (sig=6) at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
#1  0x00000000007245b7 in reraise_fatal (signum=6) at global/signal_handler.cc:58
#2  handle_fatal_signal (signum=6) at global/signal_handler.cc:104
#3  <signal handler called>
#4  0x00007ffff69ee885 in raise (sig=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
#5  0x00007ffff69f0065 in abort () at abort.c:92
#6  0x0000003be84bea7d in __gnu_cxx::__verbose_terminate_handler() () from /usr/lib64/libstdc++.so.6
#7  0x0000003be84bcc06 in ?? () from /usr/lib64/libstdc++.so.6
#8  0x0000003be84bcc33 in std::terminate() () from /usr/lib64/libstdc++.so.6
#9  0x0000003be84bcd2e in __cxa_throw () from /usr/lib64/libstdc++.so.6
#10 0x000000000074b9e3 in ceph::__ceph_assert_fail (assertion=0x1488000 "\001", file=0x2d828a0 "\260m\"\003", line=330, func=0x8701e0 "entity_inst_t OSDMap::get_cluster_inst(int) const") at common/assert.cc:77
#11 0x000000000058cde9 in OSDMap::get_cluster_inst (this=<value optimized out>, osd=<value optimized out>) at osd/OSDMap.h:330
#12 0x00000000005d4b4f in OSD::handle_osd_ping (this=0x14d8000, m=<value optimized out>) at osd/OSD.cc:1717
#13 0x00000000005d5491 in OSD::heartbeat_dispatch (this=0x14d8000, m=0x24383100) at osd/OSD.cc:2784
#14 0x00000000007d5683 in ms_deliver_dispatch (this=0x1472960) at msg/Messenger.h:504
#15 SimpleMessenger::DispatchQueue::entry (this=0x1472960) at msg/SimpleMessenger.cc:367
#16 0x00000000007d6a05 in SimpleMessenger::dispatch_entry (this=0x1472880) at msg/SimpleMessenger.cc:384
#17 0x00000000007957bd in SimpleMessenger::DispatchThread::entry (this=<value optimized out>) at ./msg/SimpleMessenger.h:807
#18 0x00007ffff76507f1 in start_thread (arg=0x7fffe6ec6700) at pthread_create.c:301
#19 0x00007ffff6aa1ccd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
(gdb) f 12
#12 0x00000000005d4b4f in OSD::handle_osd_ping (this=0x14d8000, m=<value optimized out>) at osd/OSD.cc:1717
1717		  _share_map_outgoing(service.get_osdmap()->get_cluster_inst(from));
(gdb) l
1712	      hbserver_messenger->send_message(r, m->get_connection());
1713	
1714	      if (osdmap->is_up(from)) {
1715		note_peer_epoch(from, m->map_epoch);
1716		if (locked && is_active())
1717		  _share_map_outgoing(service.get_osdmap()->get_cluster_inst(from));
1718	      }
1719	    }
1720	    break;
1721	
(gdb) f 11
#11 0x000000000058cde9 in OSDMap::get_cluster_inst (this=<value optimized out>, osd=<value optimized out>) at osd/OSDMap.h:330
330	    assert(is_up(osd));
(gdb) l
325	  entity_inst_t get_inst(int osd) const {
326	    assert(is_up(osd));
327	    return entity_inst_t(entity_name_t::OSD(osd), get_addr(osd));
328	  }
329	  entity_inst_t get_cluster_inst(int osd) const {
330	    assert(is_up(osd));
331	    return entity_inst_t(entity_name_t::OSD(osd), get_cluster_addr(osd));
332	  }
333	  entity_inst_t get_hb_inst(int osd) const {
334	    assert(is_up(osd));


Apparently osdmap member in class OSD don't have the
same map contents as the osdmap member in OSDService
in this instance?

Why are there two osdmaps?  Under what conditions is it
appropriate for them to have different contents?

Is this the appropriate fix?

@@ -1711,10 +1711,10 @@ void OSD::handle_osd_ping(MOSDPing *m)
  				m->stamp);
        hbserver_messenger->send_message(r, m->get_connection());

-      if (osdmap->is_up(from)) {
+      if (locked && osdmap->is_up(from)) {
  	note_peer_epoch(from, m->map_epoch);
-	if (locked && is_active())
-	  _share_map_outgoing(service.get_osdmap()->get_cluster_inst(from));
+	if (is_active())
+	  _share_map_outgoing(osdmap->get_cluster_inst(from));
        }
      }
      break;


Thanks -- Jim

