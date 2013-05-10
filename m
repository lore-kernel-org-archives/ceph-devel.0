From: Sage Weil <sage@inktank.com>
Subject: RE: Seg Fault on rgw 0.61.1 with cluster in 0.61
Date: Fri, 10 May 2013 08:30:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305100825050.23708@cobra.newdream.net>
References: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com> <367CC0B0FC02EE47BF7482398BD623C55E230F45@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39302 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab3EJPaR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 11:30:17 -0400
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C55E230F45@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 10 May 2013, Yann ROBIN wrote:
> I've downgraded the rgw to 0.60 and I still had the same issue.

Yeah, the radosgw code is essentially identical between the two versions 
(there is a new config option but it is unused).
 
> I returned to 0.61.1 and noticed that sometimes (1 on 10) the radosgw start normally.
> I've installed debug package of librados to do some debugging and now it always works...

That is disconcerting.

I've pushed wip-rgw-crash that prints some debug information in 
ceph::crypto::init... do you mind instaling that (without debug packages 
:) and seeing if you can reproduce the problem?  it should print out a 
couple of lines to stdout, but you need to run radosgw with the '-f' 
option (which prevents fork).  hopefully the problem is reproducible in 
that case.

What distro are you running?
sage


 > 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yann ROBIN
> Sent: vendredi 10 mai 2013 10:51
> To: ceph-devel@vger.kernel.org
> Subject: Seg Fault on rgw 0.61.1 with cluster in 0.61
> 
> Hi,
> 
> I've tried to update the rgw to 0.61.1 and now I have a segfault while connecting to the 0.61 cluster.
> The rgw with version 0.61 run fine.
> 
> *** Caught signal (Segmentation fault) **  in thread 7fc1fec79780  ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>  1: /usr/bin/radosgw() [0x4f19da]
>  2: (()+0xfcb0) [0x7fc1fcf0dcb0]
>  3: (ceph::crypto::init(CephContext*)+0xf) [0x7fc1fdfeb2ef]
>  4: (common_init_finish(CephContext*)+0x23) [0x7fc1fdfc33f3]
>  5: (librados::RadosClient::connect()+0x1d) [0x7fc1fde1d48d]
>  6: (RGWRados::initialize()+0x53) [0x5b5c03]
>  7: (RGWStoreManager::init_storage_provider(CephContext*, bool)+0x2c9) [0x5b9b39]
>  8: (main()+0x2d7) [0x4b4ed7]
>  9: (__libc_start_main()+0xed) [0x7fc1fb90176d]
>  10: /usr/bin/radosgw() [0x4b6db1]
> 2013-05-10 10:36:39.749439 7fc1fec79780 -1 *** Caught signal (Segmentation fault) **  in thread 7fc1fec79780
> 
> --
> Yann ROBIN
> YouScribe
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
