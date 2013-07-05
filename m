From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Unexpected pg placement in degraded mode with custom crush rule
Date: Fri, 05 Jul 2013 16:32:25 +1200
Message-ID: <51D64C59.3010004@catalyst.net.nz>
References: <51D63F54.70900@catalyst.net.nz> <alpine.DEB.2.00.1307042058380.22858@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51889 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3GEEc3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 00:32:29 -0400
In-Reply-To: <alpine.DEB.2.00.1307042058380.22858@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

I don't believe so, I'm loading the objects directly from another host 
(which is running 0.64 built from src) with:

$ rados -m 192.168.122.21 -p obj put smallnode$n.dat smallnode.dat   # 
$n=0->99

and the osd's are all running 0.56.6, so I don't think there is any 
kernel rbd or librbd involved.


I did try:

$ ceph osd crush tunables optimal

In one run - no difference.

I have updated to 0.61.4 and am running the test again, will update with 
the results!

Cheers

Mark

On 05/07/13 16:01, Sage Weil wrote:
> Hi Mark,
>
> If you're not using a kernel cephfs or rbd client older than ~3.9, or
> ceph-fuse/librbd/librados older than bobtail, then you should
>
>   ceph osd crush tunables optimal
>
> and I suspect that this will suddenly work perfectly.  The defaults are
> still using semi-broken legacy values because client support is pretty
> new.  Trees like yours, with sparsely populated leaves, tend to be most
> affected.
>
> (I bet you're seeing the rack separation rule violated because the
> previous copy of the PG was already there and ceph won't throw out old
> copies before creating new ones.)
>
>

