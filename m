From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Seg Fault on rgw 0.61.1 with cluster in 0.61
Date: Fri, 10 May 2013 09:28:51 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C55E230F45@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:37485
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808Ab3EJJ25 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 May 2013 05:28:57 -0400
Received: from mail77-co1 (localhost [127.0.0.1])	by mail77-co1-R.bigfish.com
 (Postfix) with ESMTP id 5200C2A0A36	for <ceph-devel@vger.kernel.org>; Fri, 10
 May 2013 09:28:56 +0000 (UTC)
Received: from CO1EHSMHS024.bigfish.com (unknown [10.243.78.250])	by
 mail77-co1.bigfish.com (Postfix) with ESMTP id CE46BB80073	for
 <ceph-devel@vger.kernel.org>; Fri, 10 May 2013 09:28:53 +0000 (UTC)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've downgraded the rgw to 0.60 and I still had the same issue.

I returned to 0.61.1 and noticed that sometimes (1 on 10) the radosgw start normally.
I've installed debug package of librados to do some debugging and now it always works...

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yann ROBIN
Sent: vendredi 10 mai 2013 10:51
To: ceph-devel@vger.kernel.org
Subject: Seg Fault on rgw 0.61.1 with cluster in 0.61

Hi,

I've tried to update the rgw to 0.61.1 and now I have a segfault while connecting to the 0.61 cluster.
The rgw with version 0.61 run fine.

*** Caught signal (Segmentation fault) **  in thread 7fc1fec79780  ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
 1: /usr/bin/radosgw() [0x4f19da]
 2: (()+0xfcb0) [0x7fc1fcf0dcb0]
 3: (ceph::crypto::init(CephContext*)+0xf) [0x7fc1fdfeb2ef]
 4: (common_init_finish(CephContext*)+0x23) [0x7fc1fdfc33f3]
 5: (librados::RadosClient::connect()+0x1d) [0x7fc1fde1d48d]
 6: (RGWRados::initialize()+0x53) [0x5b5c03]
 7: (RGWStoreManager::init_storage_provider(CephContext*, bool)+0x2c9) [0x5b9b39]
 8: (main()+0x2d7) [0x4b4ed7]
 9: (__libc_start_main()+0xed) [0x7fc1fb90176d]
 10: /usr/bin/radosgw() [0x4b6db1]
2013-05-10 10:36:39.749439 7fc1fec79780 -1 *** Caught signal (Segmentation fault) **  in thread 7fc1fec79780

--
Yann ROBIN
YouScribe


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


