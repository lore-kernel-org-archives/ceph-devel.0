From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: osd crash in ReplicatedPG::add_object_context_to_pg_stat(ReplicatedPG::ObjectContext*,
 pg_stat_t*)
Date: Fri, 12 Oct 2012 00:17:46 +0200
Message-ID: <5077458A.7030108@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:60359 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752632Ab2JKW2F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Oct 2012 18:28:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTP id 86DEF4016E3
	for <ceph-devel@vger.kernel.org>; Fri, 12 Oct 2012 00:17:47 +0200 (CEST)
Received: from smtp-tls.univ-nantes.fr ([127.0.0.1])
	by localhost (smtptls1-cha.cpub.univ-nantes.fr [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MAMrY1mDMOAw for <ceph-devel@vger.kernel.org>;
	Fri, 12 Oct 2012 00:17:47 +0200 (CEST)
Received: from [192.168.21.21] (familledupont.org [81.56.167.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTPSA id EB8B04016E0
	for <ceph-devel@vger.kernel.org>; Fri, 12 Oct 2012 00:17:46 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello everybody.

I'm currently having problem with 1 of my OSD, crashing with  this trace :

ceph version 0.52 (commit:e48859474c4944d4ff201ddc9f5fd400e8898173)
  1: /usr/bin/ceph-osd() [0x737879]
  2: (()+0xf030) [0x7f43f0af0030]
  3: 
(ReplicatedPG::add_object_context_to_pg_stat(ReplicatedPG::ObjectContext*, 
pg_stat_t*)+0x292) [0x555262]
  4: (ReplicatedPG::recover_backfill(int)+0x1c1a) [0x55c93a]
  5: (ReplicatedPG::start_recovery_ops(int, PG::RecoveryCtx*)+0x26a) 
[0x563c1a]
  6: (OSD::do_recovery(PG*)+0x39d) [0x5d3c9d]
  7: (OSD::RecoveryWQ::_process(PG*)+0xd) [0x6119fd]
  8: (ThreadPool::worker()+0x82b) [0x7c176b]
  9: (ThreadPool::WorkThread::entry()+0xd) [0x5f609d]
  10: (()+0x6b50) [0x7f43f0ae7b50]
  11: (clone()+0x6d) [0x7f43ef81b78d]

Restarting gives the same message after some seconds.
I've been watching the bug tracker but I don't see something related.

Some informations : kernel is 3.6.1, with "standard" debian packages 
from ceph.com

My ceph cluster was running well and stable on 6 osd since june (3 
datacenters, 2 with 2 nodes, 1 with 4 nodes, a replication of 2, and 
adjusted weight to try to balance data evenly). Beginned with the 
then-up-to-date version, then 0.48, 49,50,51... Data store is on XFS.

I'm currently in the process of growing my ceph from 6 nodes to 12 
nodes. 11 nodes are currently in ceph, for a 130 TB total. Declaring new 
osd was OK, the data has moved "quite" ok (in fact I had some OSD crash 
- not definitive, the osd restart ok-, maybe related to an error in my 
new nodes network configuration that I discovered after. More on that 
later, I can find the traces, but I'm not sure it's related)

When ceph was finally stable again, with HEALTH_OK, I decided to 
reweight the osd (that was tuesday). Operation went quite OK, but near 
the end of operation (0,085% left), 1 of my OSD crashed, and won't start 
again.

More problematic, with this osd down, I have 1 incomplete PG :

ceph -s
    health HEALTH_WARN 86 pgs backfill; 231 pgs degraded; 4 pgs down; 15 
pgs incomplete; 4 pgs peering; 134 pgs recovering; 19 pgs stuck 
inactive; 455 pgs stuck unclean; recovery 2122878/23181946 degraded 
(9.157%); 2321/11590973 unfound (0.020%); 1 near full osd(s)
    monmap e1: 3 mons at 
{chichibu=172.20.14.130:6789/0,glenesk=172.20.14.131:6789/0,karuizawa=172.20.14.133:6789/0}, 
election epoch 20, quorum 0,1,2 chichibu,glenesk,karuizawa
    osdmap e13184: 11 osds: 10 up, 10 in
     pgmap v2399093: 1728 pgs: 165 active, 1270 active+clean, 8 
active+recovering+degraded, 41 
active+recovering+degraded+remapped+backfill, 4 down+peering, 137 
active+degraded, 3 active+clean+scrubbing, 15 incomplete, 40 
active+recovering, 45 active+recovering+degraded+backfill; 44119 GB 
data, 84824 GB used, 37643 GB / 119 TB avail; 2122878/23181946 degraded 
(9.157%); 2321/11590973 unfound (0.020%)
    mdsmap e321: 1/1/1 up {0=karuizawa=up:active}, 2 up:standby

how is it possible as I have a replication of 2  ?

Is it a known problem ?

Cheers,

