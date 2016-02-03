From: "Moreno, Orlando" <orlando.moreno@intel.com>
Subject: Infernalis on NVMe cephx authentication impact
Date: Wed, 3 Feb 2016 00:18:29 +0000
Message-ID: <034AAD465C6CBE4F96D9FB98573A79A6024B1591@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21781 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbcBCASv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Feb 2016 19:18:51 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>

Following up on the first pass of all-flash performance numbers for Infernalis, we ran the same tests with cephx authentication on. Previously, for both Hammer and Infernalis, the performance reported was with authentication turned off. Since the authentication interface changed to libnss between Hammer and Infernalis, we wanted to verify the impact of authentication in a high-performance Ceph cluster.

With authentication on, random 4K read performance drops by about 11% and clearly hits a wall in terms of max IOPS. Random writes see a greater impact with max performance reaching 176K IOPS compared to the 200K+ IOPS with authentication off. The mixed workload seems to be affected by this as well and maxes out at 408K IOPS. Considering the high throughput of the cluster, these numbers seem reasonable and the overhead of adding authentication did not degrade the performance as much as Hammer's authentication implementation where we saw at least a 30% hit on reads/writes.

Below is a comparison table of authentication on vs off. More detailed data is available for anyone that is interested.

				Infernalis			Infernalis w/ cephx	
		IODepth	IOPS		Avg Lat (ms)	IOPS		Avg Lat (ms)
========================================================================
100% Rand Read	4	383747		0.619167	347850		0.683139
			8	645551		0.7345		581384		0.815726
			16	955990		0.994833	820765		1.153785
			32	1072001	1.774667	937832		2.023074
			64	1028112	3.578667	942742		4.036471
			96	1070847	5.402833	941746		6.06505
			128	1088625	7.085		N/A		N/A

100% Rand Write	4	131447		1.820833	111689		2.135115
			8	175180		2.8385		138931		3.43494
			16	198219		5.129333	163417		5.844878
			32	191775		10.0895		174522		10.956354
			64	185602		21.089167	176733		21.669579
			96	204202		30.601833	163963		35.046025
			128	233095		37.532667	150943		50.75762

70% Rand Read		4	234445		1.015333	210798		1.129461
			8	337808		1.417667	309584		1.538977
			16	394676		2.425333	360150		2.649063
			32	445295		4.3465		391638		4.879287
			64	478867		8.297833	408463		9.364712
			96	513590		11.9885		407493		14.084794
			128	532439		15.970333	406757		18.814887


Thanks,

Orlando
