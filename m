From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [PATCH v3] ceph: use kernel DNS resolver
Date: Thu, 29 Sep 2011 14:01:46 -0700 (PDT)
Message-ID: <1743105821.50960.1317330106487.JavaMail.root@mail-01.cse.ucsc.edu>
References: <Pine.LNX.4.64.1109291350100.5647@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:34863 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab1I2VBq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 17:01:46 -0400
In-Reply-To: <Pine.LNX.4.64.1109291350100.5647@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks!

> (BTW, whatever method you're using to email the patches doing some
> wordwrapping...)

Dangit. Thanks for point this out. Supposedly Gmail is patch friendly
if everything flows through IMAP--but I guess I'm doing it wrong :(

-Noah

> 
> Thanks!
> sage
> 
> >
> > Thanks,
> > Noah
> >
> > ----- Original Message -----
> > From: "Noah Watkins" <noahwatkins@gmail.com>
> > To: "Sage Weil" <sage@newdream.net>
> > Cc: ceph-devel@vger.kernel.org, "LKML"
> > <linux-kernel@vger.kernel.org>
> > Sent: Friday, September 23, 2011 12:40:12 PM
> > Subject: [PATCH v3] ceph: use kernel DNS resolver
> >
> > Change ceph_parse_ips to take either names given as
> > IP addresses or standard hostnames (e.g. localhost).
> > The DNS lookup is done using the dns_resolver facility
> > similar to its use in AFS, NFS, and CIFS.
> >
> > This patch defines CONFIG_CEPH_LIB_USE_DNS_RESOLVER
> > that controls if this feature is on or off.
> >
> >
