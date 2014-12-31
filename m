From: Wido den Hollander <wido@42on.com>
Subject: Higher OSD disk util due to RBD snapshots from Dumpling to Firefly
Date: Wed, 31 Dec 2014 17:21:20 +0100
Message-ID: <54A42280.60607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:34361 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbaLaQVY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Dec 2014 11:21:24 -0500
Received: from [IPv6:2a02:f6e:8007:0:30b5:b4bb:d34d:5b3a] (unknown [IPv6:2a02:f6e:8007:0:30b5:b4bb:d34d:5b3a])
	by websrv.42on.com (Postfix) with ESMTPSA id 3858CC0001
	for <ceph-devel@vger.kernel.org>; Wed, 31 Dec 2014 17:21:21 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Last week I upgraded a 250 OSD cluster from Dumpling 0.67.10 to Firefly
0.80.7 and after the upgrade there was a severe performance drop on the
cluster.

It started raining slow requests after the upgrade and most of them
included a 'snapc' in the request.

That lead me to investigate the RBD snapshots and I found that a rogue
process had created ~1800 snapshots spread out over 200 volumes.

One image even had 181 snapshots!

As the snapshots weren't used I removed them all and after the snapshots
were removed the performance of the cluster came back to normal level again.

I'm wondering what changed between Dumpling and Firefly which caused
this? I saw OSDs spiking to 100% disk util constantly under Firefly
where this didn't happen with Dumpling.

Did something change in the way OSDs handle RBD snapshots which causes
them to create more disk I/O?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
