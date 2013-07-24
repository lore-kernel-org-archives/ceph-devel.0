From: Alex Bligh <alex@alex.org.uk>
Subject: Re: [ceph-users] v0.61.6 Cuttlefish update released
Date: Wed, 24 Jul 2013 14:18:18 +0100
Message-ID: <DBBFE481-F602-44BB-B824-FB088419D115@alex.org.uk>
References: <alpine.DEB.2.00.1307232146370.334@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:49498 "EHLO mail.avalus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3GXNSa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Jul 2013 09:18:30 -0400
In-Reply-To: <alpine.DEB.2.00.1307232146370.334@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Bligh <alex@alex.org.uk>, ceph-devel@vger.kernel.org, ceph-users@ceph.com


On 24 Jul 2013, at 05:47, Sage Weil wrote:

> There was a problem with the monitor daemons in v0.61.5 that would prevent 
> them from restarting after some period of time.  This release fixes the 
> bug and works around the issue to allow affected monitors to restart.  
> All v0.61.5 users are strongly recommended to upgrade.

Was this bug also in 0.61.4?

-- 
Alex Bligh




