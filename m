From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: Newbie questions
Date: Sun, 07 Oct 2012 10:08:17 +1000
Message-ID: <k4qh5i$l2a$1@ger.gmane.org>
References: <itxvbcnv59ub7io20vp9jwxp.1349537492870@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60632 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab2JGAIa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Oct 2012 20:08:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TKeQ6-0002vw-4A
	for ceph-devel@vger.kernel.org; Sun, 07 Oct 2012 02:08:34 +0200
Received: from 124-170-67-40.dyn.iinet.net.au ([124.170.67.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 07 Oct 2012 02:08:34 +0200
Received: from a.nielsen by 124-170-67-40.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 07 Oct 2012 02:08:34 +0200
In-Reply-To: <itxvbcnv59ub7io20vp9jwxp.1349537492870@email.android.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> The problem you are describing is called split-brain.  Ceph has an odd
> number of monitors and quorum is required before objects can be served.
> The partition with the smaller number of monitors will wait harmlessly
> until connectivity is reestablished .

Ah right, that makes sense.  Is this set in stone or can it be configured? 
I'm just thinking that in this scenario it could be beneficial to allow 
read-only access from the partition with the smaller number of monitors, if 
there are also clients that can only see those hosts.  (For example, a 
business with two sites, and the link between them goes down, so client PCs 
can only see their site-local servers.)

Thanks,
Adam.

