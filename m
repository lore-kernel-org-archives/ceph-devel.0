From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph status for Wheezy
Date: Sun, 8 Jul 2012 21:39:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207082132170.13271@cobra.newdream.net>
References: <1341122210.10000.46.camel@julia> <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net>
 <1341786172.24592.49.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48204 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab2GIEjv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 00:39:51 -0400
In-Reply-To: <1341786172.24592.49.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 8 Jul 2012, Laszlo Boszormenyi (GCS) wrote:
> Hi Sage,
> 
> On Sat, 2012-06-30 at 23:12 -0700, Sage Weil wrote:
> > Fingers crossed!
>  It may go into Wheezy, but I need some information.
> 
> > Barring any last-minute catastrophies, 0.48 should be released Monday.
>  It was released since then. But there are several files that I don't
> know where to install. First are some headers under /usr/include/crush :
> crush.h , hash.h , mapper.h and types.h .

I don't think these need to be installed anywhere; they're not currently 
packaged.  Why do you mention them?

> I'm sure that librados-config and its manpage goes to librados-dev .

Oh, right, we missed that; pushed a patch for that to wip-stable to make 
sure it builds on all distributions.

> What about ceph-disk-activate , ceph-disk-prepare exists , boto_tool and
> ceph-coverage ? They are python scripts except the latter being a shell
> script.

ceph-disk-* are already in ceph.  The other two shouldn't be packaged.

Is there anything missing on this end?

Thanks!
sage
