From: Sam Lang <samlang@gmail.com>
Subject: heartbeat logic
Date: Wed, 03 Aug 2011 22:10:31 -0500
Message-ID: <4E3A0DA7.8090409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:33579 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1HDDQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 23:16:46 -0400
Received: by iye16 with SMTP id 16so848512iye.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2011 20:16:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


During startup of an osd cluster with 37 osds, within the first few 
seconds I see osds getting marked down, even though the osd processes 
remain running and seem to be just fine.  The up count fluctuates for a 
while but seems to stabilize eventually at around 30 up osds, while 7 or 
so remain down, and eventually get marked out.

With debugging enabled, I've tracked it down to this bit of logic in 
OSD.cc:1502 (stable branch):

------snip------
   // ignore (and mark down connection for) old messages
   epoch_t e = m->map_epoch;
   if (!e)
     e = m->peer_as_of_epoch;
   if (e <= osdmap->get_epoch() &&
       ((heartbeat_to.count(from) == 0 && heartbeat_from.count(from) == 
0) ||
        heartbeat_con[from] != m->get_connection())) {
     dout(5) << "handle_osd_ping marking down peer " << m->get_source_inst()
<< " after old message from epoch " << e
<< " <= current " << osdmap->get_epoch() << dendl;
     heartbeat_messenger->mark_down(m->get_connection());
     goto out;
   }
--------------------

It looks as though the osd getting marked down is sending a heartbeat 
ping to another osd, at which point, that osd marks it as down.  Its not 
clear to me why that happens.  Is it because connections are getting 
dropped and ports are changing?

In any case, that if conditional succeeds, resulting in the osd marking 
down the osd that just sent it a ping heartbeat.

I modified the debug output to show the values for 
heartbeat_to.count(from) and heartbeat_from.count(from), as well as 
heartbeat_con[from] and m->get_connection().  The cases where osds are 
marked down are when the ping message's epoch and the osdmap epoch are 
the same (usually around 16), and the counts are always zero, suggesting 
that this is the first heartbeat from osdA to osdB.  Even if they 
weren't zero, the heartbeat_con[from] is null, and doesn't get set till 
later, so the conditional would succeed anyway.  Can someone explain the 
purpose and reasoning behind this bit of code?  If I just whack the 
second part of the conditional will bad things happen?  Any help is 
greatly appreciated.

Thanks,
-sam

