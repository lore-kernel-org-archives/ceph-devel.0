From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: Quick comparison of Hammer & Infernalis on NVMe
Date: Wed, 25 Nov 2015 21:52:59 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120B8FD242@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43854 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbbKYVxB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Nov 2015 16:53:01 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, sage Weil <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>

(2nd time w/o HTML formatting)
As I mentioned today in the meeting we have a first pass set of numbers=
 from=A0 Infernalis.=A0 This is the same hardware, configuration (inclu=
ding ceph.conf), and clients as the previous data from this presentatio=
n: http://www.slideshare.net/Inktank_Ceph/accelerating-cassandra-worklo=
ads-on-ceph-with-allflash-pcie-ssds

The comparison data is here: https://www.docdroid.net/X0kJcIp/quick-ham=
mer-vs-infernalis-nvme-comparison.pdf.html

Reads are a bit slower than we measured before at higher QD, but roughl=
y the same up to 1M IOPS.=A0 Writes look a lot better!=A0 Also if you l=
ook at the long-tail latency numbers (not graphed, in the backup slides=
) the long tail latency is much lower for writes and mixed workloads, b=
y 1/3rd to 1/8th.=A0=A0=A0=A0 We are doing analysis and building tools =
that are focusing on 80th/90th/95th/99th latency across workloads at va=
rious queue depths now so we'll see if we can get any more insight.

We did at some point during the upgrade find that SELinux was set to 'e=
nforcing', and originally this gave us a much lower performance measure=
ment.=A0 We have some comparison data for that if anyone is interested.=
=A0 =A0

If you're in the U.S, have a great holiday!

Thanks,

Stephen


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
