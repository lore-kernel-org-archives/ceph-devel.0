From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: Clusters and pools
Date: Wed, 25 Jul 2012 04:34:45 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C0E903140@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:33234
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102Ab2GYEev convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Jul 2012 00:34:51 -0400
Received: from mail59-db3 (localhost [127.0.0.1])	by mail59-db3-R.bigfish.com
 (Postfix) with ESMTP id 961FC1C02AA	for <ceph-devel@vger.kernel.org>; Wed, 25
 Jul 2012 04:34:49 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.238])	by
 mail59-db3.bigfish.com (Postfix) with ESMTP id 0A5B43000AA	for
 <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 04:34:48 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm running a cluster based on 4 hosts that each have 3 fast, SCSI osd's, and 1 very large SATA osd, meaning, 12 fast osd's and 4 slow osd's total. I wish to segregate these into 2 pools, that operate independently. The goal is to use the faster disks as an area to hold rbd based VM's, and the larger area to host rbd-base large volumes (to start), and possibly have that become just a big cephfs area once, the fs side of things is considered more stable.

Now, I've been thrown a couple options, and am still unsettled. Which is best?:
- Create 2 independent clusters; one with the 12 SCSI osd's and the other with just the 4 large OSD's on the same hosts. This seems to be more complex from a scripting and boot time standpoint, but easier for my head.
- Create a single cluster and use CRUSH rules to separate the two. This one STILL has me lost, as I'm having trouble understanding the crushmap syntax, the Crushmap import/export commands, and the other mkpool or otherwise commands from the docs in order to "make rbd's come from this faster pool", while "cephfs, you come from this slower pool". I really would like to entertain this path, however, as this allows ceph to handle the entire situation, and, it would seem more elegant.

I'm also open to other options as well. 

Thanks!

Ryan Nicholson

