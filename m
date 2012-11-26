From: Sage Weil <sage@inktank.com>
Subject: Re: two trivial patches for the upcoming stable release
Date: Mon, 26 Nov 2012 13:09:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211261309340.3409@cobra.newdream.net>
References: <ord2z06rhh.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52320 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab2KZVJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 16:09:37 -0500
In-Reply-To: <ord2z06rhh.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Mon, 26 Nov 2012, Alexandre Oliva wrote:

> The first one was posted before, to enable out-of-tree builds; it was
> acked but apparently it fell through the cracks.
> 
> The second fixes a regression in log rotation on systems that don't use
> invoke-rc.d.  The which command doesn't output anything to stdout when
> it fails to find the requested command, and for some reason [ -x ]
> passes, so we end up trying to run the non-existing invoke-rc.d instead
> of falling back to other alternatives as intended.
> 
> 
