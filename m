From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Wed, 30 Mar 2016 22:35:18 +0000
Message-ID: <CY1PR0201MB189729363158CFE8EE6AFE02E8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <EC1BE61F68296D4A8CE45AD3DEDB99E21AEF7D1C@SSIEXCH-MB3.ssi.samsung.com>
 <alpine.DEB.2.11.1603301824080.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0096.outbound.protection.outlook.com ([157.56.111.96]:42228
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751212AbcC3WfW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 18:35:22 -0400
In-Reply-To: <alpine.DEB.2.11.1603301824080.22014@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Vikas Sinha-SSI <v.sinha@ssi.samsung.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Wednesday, March 30, 2016 3:25 PM
> To: Vikas Sinha-SSI <v.sinha@ssi.samsung.com>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Igor Fedotov
> <ifedotov@mirantis.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject: RE: Adding compression/checksum support for bluestore.
> 
> On Wed, 30 Mar 2016, Vikas Sinha-SSI wrote:
> > > [snip]
> >
> > If I understand correctly, then there would still be a cost associated
> > with writing dis-contiguously to disk. In cases such as this where the
> > resources for compression are not easily available, I wonder if it is
> > reasonable to simply not do compression for that Write. The cost of not
> compressing would be a missed space optimization, but the cost of
> compressing in any and all cases could be significant to latency.
> 
> I also like this better than the split pextent complexity.

I agree that the complexity is reduced -- which is good. Of course this is traded-off with a reduced storage capability, provided that this doesn't happen very often -- this might be a reasonable approach . I want to brood on this for a while.

 
> 
> sage

