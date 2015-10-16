From: Tomy Cheru <Tomy.Cheru@sandisk.com>
Subject: RE: does newstore skip some data ??
Date: Fri, 16 Oct 2015 09:19:21 +0000
Message-ID: <CO1PR02MB1597B371BF93BBFDE6F5A88943D0@CO1PR02MB159.namprd02.prod.outlook.com>
References: <EBFBEFF470372547BAACF06D39FF53A54F5A9732@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1510150524550.16833@cobra.newdream.net>
 <EBFBEFF470372547BAACF06D39FF53A54F5A9893@SACMBXIP02.sdcorp.global.sandisk.com>
 <6F3FA899187F0043BA1827A69DA2F7CC03632FCA@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0094.outbound.protection.outlook.com ([65.55.169.94]:57123
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752603AbbJPJTY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 05:19:24 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC03632FCA@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Single OSD in this test

-----Original Message-----
From: Chen, Xiaoxi [mailto:xiaoxi.chen@intel.com] 
Sent: Friday, October 16, 2015 11:28 AM
To: Tomy Cheru; Sage Weil
Cc: ceph-devel@vger.kernel.org
Subject: RE: does newstore skip some data ??

How many osds do you have? I wonder if the overlay layer is that large to keep 160K obj(which is 64K * 32 on default, per OSD)?



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel- 
> owner@vger.kernel.org] On Behalf Of Tomy Cheru
> Sent: Thursday, October 15, 2015 11:08 PM
> To: Sage Weil
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: does newstore skip some data ??
> 
> Thanks Sage, make sense.
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, October 15, 2015 5:56 PM
> To: Tomy Cheru
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: does newstore skip some data ??
> 
> On Thu, 15 Oct 2015, Tomy Cheru wrote:
> > Tried to write 160k objects of 64k size, totaling 10G to newstore 
> > via rgw
> >
> > PUTS were successful
> >
> > # ./rados df
> > .log                       0          127            0          254            0          762          635          508
> 0
> > .rgw                       8           40            0           80            0            0            0          100
> 40
> > .rgw.buckets        10485760       163840            0       327680            0            0            0
> 819200     10485760
> > .rgw.buckets.index         0           20            0           40            0       655420       655400
> 655380            0
> > .rgw.control               0            8            0           16            0            0            0            0
> 0
> > .rgw.gc                    0           32            0           64            0           96           64           64
> 0
> > .rgw.root                  1            3            0            6            0            3            2            5
> 5
> > .users                     1            5            0           10            0            0            0            5            5
> > .users.email               1            3            0            6            0            0            0            3
> 3
> > .users.swift               1            2            0            4            0            0            0            2
> 2
> > .users.uid                 2            6            0           12            0          134          131          136
> 8
> > rbd                        0            0            0            0            0            0            0            0            0
> >   total used          644956       164086
> >   total avail      194620640
> >   total space      195265596
> >
> > however not able to see at least 10G worth data in device
> >
> > # du -ks dev/osd0/
> > 611548  dev/osd0/
> > # du -ks dev/osd0/db/
> > 611524  dev/osd0/db/
> > # du -ks dev/osd0/fragments/
> > 0       dev/osd0/fragments/
> >
> > why this discrepancy ??
> >
> > Does newstore apply any kind of storage efficiency in io path ??
> 
> In current master rocksdb has snappy compression enabled by default, 
> and I'm guessing you're writing either 0's or something very compressible.
> 
> If you try wip-newstore-frags cmopression is disabled (it's 
> problematic in general)...
> 
> sage
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message 
> is intended only for the use of the designated recipient(s) named 
> above. If the reader of this message is not the intended recipient, 
> you are hereby notified that you have received this message in error 
> and that any review, dissemination, distribution, or copying of this 
> message is strictly prohibited. If you have received this 
> communication in error, please notify the sender by telephone or 
> e-mail (as shown above) immediately and destroy any and all copies of 
> this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at http://vger.kernel.org/majordomo-info.html
