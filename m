From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: RE: wip-auth
Date: Mon, 26 Jan 2015 06:20:50 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120AB43257@ORSMSX152.amr.corp.intel.com>
References: <alpine.DEB.2.00.1501221512580.19192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6012 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbbAZGUy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 01:20:54 -0500
In-Reply-To: <alpine.DEB.2.00.1501221512580.19192@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "andreas.bluemle@itxperts.de" <andreas.bluemle@itxperts.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I noticed that the spec file for building RPM's defaults to building with libnss, instead of libcrypto++.  Since the measurements I'd done so far were from those RPM's I rebuilt with libcrypto++.. so FWIW here is the difference between those two on my system, memstore backend with a single OSD, and single client.    

Dual socket Xeon E5 2620v3, 64GB Memory,  RHEL7 
Kernel: 3.10.0-123.13.2.el7

100% 4K Writes, 1xOSD w/ Rados Bench
	libnss		            |    Cryptopp		
# QD	IOPS	Latency(ms)   |	IOPS	Latency(ms)	IOPS Improvement %
16	14432.57	1.11    |	18896.60	0.85	30.93%
	                                     
100% 4K Reads, 1xOSD w/ Rados Bench				
	libnss	                            |    Cryptopp		
# QD	IOPS	Latency(ms)   |	IOPS	Latency(ms)	IOPS Improvement %
16	19532.53	0.82    |	25708.70	0.62	31.62%


Thanks,

Stephen

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, January 22, 2015 4:56 PM
To: andreas.bluemle@itxperts.de
Cc: ceph-devel@vger.kernel.org
Subject: wip-auth

Hi Andreas,

I took a look at the wip-auth I mentioned in the security call last week... and the patch didn't work at all.  Sorry if you wasted any time trying it.

Anyway, I fixed it up so that it actually worked and made one other optimization.  It would be great to hear what latencies you measure with the changes in place.

Also, it might be worth trying --with-cryptopp (or --with-nss if you built cryptopp by default) to see if there is a difference.  There is a ton of boilerplate setting up encryption contexts and key structures and so on that I suspect could be cached (perhaps stashed in the CryptoKey struct?) with a bit of effort.  See

	https://github.com/ceph/ceph/blob/master/src/auth/Crypto.cc#L99-L213

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
