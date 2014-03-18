From: Yaron Haviv <yaronh@mellanox.com>
Subject: XioMessenger (RDMA) Performance results
Date: Tue, 18 Mar 2014 20:05:25 +0000
Message-ID: <DD06A08C9A04024C8B0D8A63110C7E14B0573CA6@MTLDAG01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:52731 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754338AbaCRUFc convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Mar 2014 16:05:32 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>, "Matt W. Benjamin (matt@cohortfs.com)" <matt@cohortfs.com>, Eyal Salomon <esalomon@mellanox.com>

Im happy to share test results we run in the lab with Matt's latest XioMessenger code which implements Ceph messaging over Accelio RDMA library 
Results look pretty encouraging, demonstrating a * 20x * performance boost

Below is a table comparing XioMessenger (RDMA) with SimpleMessanger (TCP) and various interconnects (56G InfiniBand and 40GbE/RoCE)
Note that we tested with CRC on/off, in RDMA there is no need for software CRC, its done by the hardware  
Tests below use a single communication thread, using more threads would produce higher performance (on 64KB IO the Link/PCIe is saturated with RDMA using a single thread)   

Matt has some more small IO optimizations in the pipe, and we hope to share perf results using librados soon, I assume they will be disk bound 

protocol	CRC	msg depth	IO size	Msg/sec	bandwidth (MB/s)	CPU % server	CPU% client
eth	crc	50	4K	          16,262 	64	100%	100%
eth	no_crc	50	4K	          15,637 	61	100%	100%
eth	crc	50	64K	            5,960 	373	93%	100%
eth	no_crc	50	64K	            7,678 	480	93%	100%
ipoib	no_crc	50	4K	          16,003 	63	100%	100%
ipoib	no_crc	50	64K	            7,375 	461	93%	100%
							
IB	no_crc	50	4K	        334,088 	1305	98%	98%
IB	no_crc	50	64K	          95,078 	5942	98%	98%
							
roce	no_crc	50	4K	        332,388 	1298	95%	100%
roce	no_crc	50	64K	          69,445 	4340	91%	87%
							
roce	crc	50	4K	        172,756 	675	97%	100%
roce	crc	50	64K	          19,657 	1229	100%	48%

Regards, Yaron



