From: Sage Weil <sage@newdream.net>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Wed, 30 Mar 2016 18:24:57 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603301824080.22014@cpach.fuggernut.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com> <EC1BE61F68296D4A8CE45AD3DEDB99E21AEF7D1C@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60413 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbcC3WZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 18:25:07 -0400
In-Reply-To: <EC1BE61F68296D4A8CE45AD3DEDB99E21AEF7D1C@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vikas Sinha-SSI <v.sinha@ssi.samsung.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 30 Mar 2016, Vikas Sinha-SSI wrote:
> > [snip]
> 
> If I understand correctly, then there would still be a cost associated with writing dis-contiguously
> to disk. In cases such as this where the resources for compression are not easily available, I wonder
> if it is reasonable to simply not do compression for that Write. The cost of not compressing would be
> a missed space optimization, but the cost of compressing in any and all cases could be significant to latency.

I also like this better than the split pextent complexity.

sage

