From: John Nielsen <lists@jnielsen.net>
Subject: questions on networks and hardware
Date: Fri, 18 Jan 2013 16:34:37 -0700
Message-ID: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:43978 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752156Ab3ARXuX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 18:50:23 -0500
Received: from [10.10.1.32] (office.betterlinux.com [199.58.199.60])
	(authenticated bits=0)
	by ns1.jnielsen.net (8.14.4/8.14.4) with ESMTP id r0INYUqB066370
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 18:34:30 -0500 (EST)
	(envelope-from lists@jnielsen.net)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm planning a Ceph deployment which will include:
	10Gbit/s public/client network
	10Gbit/s cluster network
	dedicated mon hosts (3 to start)
	dedicated storage hosts (multiple disks, one XFS and OSD per disk, 3-5 to start)
	dedicated RADOS gateway host (1 to start)

I've done some initial testing and read through most of the docs but I still have a few questions. Please respond even if you just have a suggestion or response for one of them.

If I have "cluster network" and "public network" entries under [global] or [osd], do I still need to specify "public addr" and "cluster addr" for each OSD individually?

Which network(s) should the monitor hosts be on? If both, is it valid to have more than one "mon addr" entry per mon host or is there a different way to do it?

Is it worthwhile to have 10G NIC's on the monitor hosts? (The storage hosts will each have 2x 10Gbit/s NIC's.)

I'd like to have 2x 10Gbit/s NIC's on the gateway host and maximize throughput. Any suggestions on how to best do that? I'm assuming it will talk to the OSD's on the Ceph public/client network, so does that imply a third even-more-public network for the gateway's clients?

I think this has come up before, but has anyone written up something with more details on setting up gateways? Hardware recommendations, strategies to improve caching and performance, multiple gateway setups with and without a load balancer, etc.

Thanks!

JN

