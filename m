From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Write path changes
Date: Sat, 21 Nov 2015 02:21:57 +0000
Message-ID: <CO1PR02MB20895A31B6C12F2AE0065C9F4190@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]:18656
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751345AbbKUCWA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 21:22:00 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
FYI, I have sent out a new PR addressing your earlier comments and some more enhancement. Here it is..

https://github.com/ceph/ceph/pull/6670

Did some exhaustive comparison with ceph latest master code base and found up to 32 OSDs (4 OSD nodes , one per 8TB SAS SSD) , my changes are giving ~35-40% improvement (more scale more delta). But, for 48 OSDs (6 OSD nodes) it is giving > 2x improvement for small IO. I didn't dig down much to find out why but my guess is the following.

1. During the drive addition, I found out some of the drives are performing slow than others while running ceph workload. Because of this, the entire cluster throughput is suffering. The stock throttle scheme is very crude and probably not able to handle this. New PR has some changes in the throttling specifically addressing this kind of scenarios.

2. Since those drives are slow the way Ceph stock code writes to the device is not helping much. Doing a big syncfs() on those drives are more harmful thus lowering those OSD throughput. In fact, stock code performance has degraded from 32 OSDs to 48 OSDs...

3. Mixed workload also not scaling well with stock, getting ~2X benefit there as well.


Thanks & Regards
Somnath
