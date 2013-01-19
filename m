From: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Subject: RE: questions on networks and hardware
Date: Sat, 19 Jan 2013 16:00:39 +0000
Message-ID: <C4049E4484F13747B672D64B9C12C31328DEAC30@PWMAILM01.cscinfo.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.cscinfo.com ([165.160.9.58]:48673 "EHLO mx2.cscinfo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab3ASQAm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 11:00:42 -0500
In-Reply-To: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi John,

I have a public/cluster network option setup in my config file.  You do not need to also specify an addr for each osd individually.  Here's an example of my working config:
[global]
        auth cluster required = none
        auth service required = none
        auth client required = none
        public network = 172.20.41.0/25
        cluster network = 172.20.41.128/25
        osd mkfs type = xfs
[osd]
        osd journal size = 1000
        filestore max sync interval = 30

[mon.a]
        host = plcephd01
        mon addr = 172.20.41.4:6789
[mon.b]
        host = plcephd03
        mon addr = 172.20.41.6:6789
[mon.c]
        host = plcephd05
        mon addr = 172.20.41.8:6789

[osd.0]
        host = plcephd01
        devs = /dev/sda3
[osd.X]
.... and so on...


-Chris
-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of John Nielsen
Sent: Friday, January 18, 2013 6:35 PM
To: ceph-devel@vger.kernel.org
Subject: questions on networks and hardware

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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

NOTICE: This e-mail and any attachments is intended only for use by the addressee(s) named herein and may contain legally privileged, proprietary or confidential information. If you are not the intended recipient of this e-mail, you are hereby notified that any dissemination, distribution or copying of this email, and any attachments thereto, is strictly prohibited. If you receive this email in error please immediately notify me via reply email or at (800) 927-9800 and permanently delete the original copy and any copy of any e-mail, and any printout.
