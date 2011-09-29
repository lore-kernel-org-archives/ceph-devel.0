From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH v3] ceph: use kernel DNS resolver
Date: Thu, 29 Sep 2011 13:51:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109291350100.5647@cobra.newdream.net>
References: <540605577.50538.1317324662345.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51677 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab1I2UvW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 16:51:22 -0400
In-Reply-To: <540605577.50538.1317324662345.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 29 Sep 2011, Noah Watkins wrote:
> I don't see this patch in master after my latest fetch. I was curious if 
> this got yanked?

I just forgot it.  It's pushed now. 

(BTW, whatever method you're using to email the patches doing some 
wordwrapping...)

Thanks!
sage

> 
> Thanks,
> Noah
> 
> ----- Original Message -----
> From: "Noah Watkins" <noahwatkins@gmail.com>
> To: "Sage Weil" <sage@newdream.net>
> Cc: ceph-devel@vger.kernel.org, "LKML" <linux-kernel@vger.kernel.org>
> Sent: Friday, September 23, 2011 12:40:12 PM
> Subject: [PATCH v3] ceph: use kernel DNS resolver
> 
> Change ceph_parse_ips to take either names given as
> IP addresses or standard hostnames (e.g. localhost).
> The DNS lookup is done using the dns_resolver facility
> similar to its use in AFS, NFS, and CIFS.
> 
> This patch defines CONFIG_CEPH_LIB_USE_DNS_RESOLVER
> that controls if this feature is on or off.
> 
> 
