From: Martin Mailand <martin@tuxadero.com>
Subject: osd crash during resync
Date: Tue, 24 Jan 2012 19:48:26 +0100
Message-ID: <4F1EFCFA.3060607@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:55742 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171Ab2AXSs3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2012 13:48:29 -0500
Received: from [192.168.1.175] (e178241150.adsl.alicedsl.de [85.178.241.150])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0OImQrJ007896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 24 Jan 2012 19:48:27 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
today I tried the btrfs patch mentioned on the btrfs ml. Therefore I 
rebooted osd.0 with a new kernel and created a new btrfs on the osd.0, 
than I took the osd.0 into the cluster. During the the resync of osd.0 
osd.2 and osd.3 crashed.
I am not sure, if the crashes happened because I played with osd.0, or 
if they are bugs.


osd.2
-rw-------  1 root root 1.1G 2012-01-24 12:19 
core-ceph-osd-1000-1327403927-s-brick-002

log:
2012-01-24 12:15:45.563135 7f1fdd42c700 log [INF] : 2.a restarting 
backfill on osd.0 from (185'113859,185'113859] 0//0 to 196'114038
osd/PG.cc: In function 'void PG::finish_recovery_op(const hobject_t&, 
bool)', in thread '7f1fdab26700'
osd/PG.cc: 1553: FAILED assert(recovery_ops_active > 0)

-rw-------  1 root root 758M 2012-01-24 15:58 
core-ceph-osd-20755-1327417128-s-brick-002

log:
2012-01-24 15:58:48.356892 7fe26acbf700 osd.2 379 pg[2.ff( v 379'286211 
lc 202'286160 (185'285159,379'286211] n=112 ec=1 les/c 379/310 
373/376/376) [2,1] r=0 lpr=376 rops=1 mlcod 202'286160 active m=6]  * 
oi->watcher: client.4478 cookie=1
osd/ReplicatedPG.cc: In function 'void 
ReplicatedPG::populate_obc_watchers(ReplicatedPG::ObjectContext*)', in 
thread '7fe26fdca700'
osd/ReplicatedPG.cc: 3199: FAILED assert(obc->watchers.size() == 0)
osd/ReplicatedPG.cc: In function 'void 
ReplicatedPG::populate_obc_watchers(ReplicatedPG::ObjectContext*)', in 
thread '7fe26fdca700'

http://85.214.49.87/ceph/20120124/osd.2.log.bz2



osd.3
-rw-------  1 root root 986M 2012-01-24 12:24 
core-ceph-osd-962-1327404263-s-brick-003

log:
2012-01-24 12:15:50.241321 7f30c8fde700 log [INF] : 2.2e restarting 
backfill on osd.0 from (185'338312,185'338312] 0//0 to 196'339910
2012-01-24 12:21:48.420242 7f30c5ed7700 log [INF] : 2.9d scrub ok
osd/PG.cc: In function 'void PG::activate(ObjectStore::Transaction&, 
std::list<Context*>&, std::map<int, std::map<pg_t, PG::Query> >&, 
std::map<int, MOSDPGInfo*>*)', in thread '7f30c8fde700'

http://85.214.49.87/ceph/20120124/osd.3.log.bz2



-martin


