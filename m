From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [IANA #826907] Application for a Port Number and/or Service Name
 "ceph" (Completed) (fwd)
Date: Fri, 10 Jul 2015 16:08:22 -0600
Message-ID: <55A04256.1060703@redhat.com>
References: <alpine.DEB.2.00.1507101406390.20547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbbGJWIY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jul 2015 18:08:24 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id CFBDD2ED13C
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 22:08:23 +0000 (UTC)
Received: from mbp.ktdreyer.com (vpn-56-204.rdu2.redhat.com [10.10.56.204])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6AM8NEm009711
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 18:08:23 -0400
In-Reply-To: <alpine.DEB.2.00.1507101406390.20547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 07/10/2015 03:08 PM, Sage Weil wrote:
> It's official!  We have a new port number for the monitor:
> 
> 	3300	(that's CE4h, or 0xCE4).
> 
> Sometime in the next cycle we'll need to make a transition plan to move 
> from 6789.

That's great news! Thanks for doing that.

I've updated the firewalld PR to include the new port.
https://github.com/t-woerner/firewalld/pull/22

- Ken
