From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: Understanding mon space usage during recovery
Date: Wed, 8 Jun 2016 11:25:14 +0200
Message-ID: <5757E47A.2010203@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 7.mo174.mail-out.ovh.net ([46.105.47.152]:58724 "EHLO
	7.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161294AbcFHKpM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2016 06:45:12 -0400
Received: from EX3.OVH.local (corp.ovh.com [5.196.251.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mo174.mail-out.ovh.net (Postfix) with ESMTPS id A4905FF8123
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jun 2016 11:25:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I was recently trying to understand the growth of mon disk space usage 
during recovery in one of our clusters,
wanted to know whether we could reduce disk usage somehow or if we just 
have to prepare more space for our mons.
Cluster is 0.94.6, just over 300 OSDs. Leveldb compaction does reduce 
space usage but it quickly grows back
to the previous usage. What I found out is that most of the leveldb data 
is used by osdmap history.

For each osdmap version leveldb contains both full and incremental entry 
so I was thinking if we really need to
store full osdmaps for all versions? If we're having incremental changes 
for every version anyway, wouldn't it be
sufficient to keep first full version only and then recover any future 
ones by applying incrementals?

I was also trying to understand how ceph figures out the range of osdmap 
versions to keep. After analyzing the code
I thought the obvious answer was in PGMap::calc_min_last_epoch_clean() - 
In case of our production cluster,
the difference between min and max clean epochs was around 30k during 
recovery, size of one full osdmap blob
in leveldb is around 250k.

I also tried to test this on my dev cluster where I could run gdb (15 
OSD, 4 OSD nearfull and lots of misplaced objects).
What I found out is that execution in OSDmonitor::get_trim_to() almost 
never jumped inside the first 'if'.
mon->pgmon()->is_readable() returns false, I did debug it once and it 
was a result of false returned by Paxos::is_lease_valid().
I was able get into mentioned 'if' only once the cluster got back to the 
healthy state. Is this expected behavior?

Thanks,
Bartek
