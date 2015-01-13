From: Sage Weil <sage@newdream.net>
Subject: Re: Cache pool latency impact
Date: Tue, 13 Jan 2015 06:01:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501130601040.26676@cobra.newdream.net>
References: <68A06213B74F1742A2C48216AE1BB6B808720E8A@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1501130553270.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56217 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbAMOBu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 09:01:50 -0500
In-Reply-To: <alpine.DEB.2.00.1501130553270.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 13 Jan 2015, Sage Weil wrote:
> > 2) Is there any mechanism (that I might have overlooked) to avoid this 
> > situation, by throttling the flush/evict operations on the fly? If not, 
> > shouldn't there be one?
> 
> Hmm, we could have a 'noagent' option (similar to noout, nobackfill, 
> noscrub, etc.) that lets the admin tell the system to stop tiering 
> movements, but I'm not sure that's wht you're asking for...

...and it looks like we already have a 'notieragent' flag that does 
exactly that:

 ceph osd set notieragent

and

 ceph osd unset notieragent

That might be helpful in narrowing down what effect flush/evict operations 
are having...

sage
