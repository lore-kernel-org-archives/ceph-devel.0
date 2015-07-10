From: Wido den Hollander <wido@42on.com>
Subject: Re: [IANA #826907] Application for a Port Number and/or Service Name
 "ceph" (Completed) (fwd)
Date: Fri, 10 Jul 2015 23:49:20 +0200
Message-ID: <55A03DE0.2070900@42on.com>
References: <alpine.DEB.2.00.1507101406390.20547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:35772 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbbGJVtX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jul 2015 17:49:23 -0400
In-Reply-To: <alpine.DEB.2.00.1507101406390.20547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 07/10/2015 11:08 PM, Sage Weil wrote:
> It's official!  We have a new port number for the monitor:
> 
> 	3300	(that's CE4h, or 0xCE4).
> 
> Sometime in the next cycle we'll need to make a transition plan to move 
> from 6789.
> 

Very nice! We should be clear though that nothing will break for
existing users.

The new default will become 3300, but every mon has IP+Port in the
monmap, so it won't hit them. Just to make sure people aren't afraid to
upgrade their Ceph cluster.

> sage
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
