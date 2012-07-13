From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ceph: fix potential double free
Date: Fri, 13 Jul 2012 15:56:10 +0100
Message-ID: <20120713155610.4638b307@pyramind.ukuu.org.uk>
References: <20120713142839.23587.58658.stgit@localhost.localdomain>
	<50003289.5010805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33391 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab2GMOwb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 10:52:31 -0400
In-Reply-To: <50003289.5010805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 13 Jul 2012 09:36:57 -0500
Alex Elder <elder@inktank.com> wrote:

> On 07/13/2012 09:28 AM, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > We re-run the loop but we don't re-set the attrs pointer back to NULL.
> 
> It looks to me like we're OK here without this.
> 
> At the top of the loop, the if condition either holds or it does not.
> - If it does not, we don't touch "xattrs" again, before returning "err".
> - If the condition holds, the next time "xattrs" is touched is when its
>   value is assigned the result of a kcalloc() call.


If the condition is invariant across the race/retry then a better fix
would be to move the start label to re-execute only the relevant code ?

Alan
