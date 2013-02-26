From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: maintanance on osd host
Date: Tue, 26 Feb 2013 18:22:08 +0100
Message-ID: <727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag>
References: <512CCD19.7010509@profihost.ag> <alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:54476 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab3BZRWM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 12:22:12 -0500
In-Reply-To: <alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

But that redults in a 1-3s hickup for all KVM vms. This is not what I want.

Stefan

Am 26.02.2013 um 18:06 schrieb Sage Weil <sage@inktank.com>:

> On Tue, 26 Feb 2013, Stefan Priebe - Profihost AG wrote:
>> Hi list,
>> 
>> how can i do a short maintanance like a kernel upgrade on an osd host?
>> Right now ceph starts to backfill immediatly if i say:
>> ceph osd out 41
>> ...
>> 
>> Without ceph osd out command all clients hang for the time ceph does not
>> know that the host was rebootet.
>> 
>> I tried
>> ceph osd set nodown and ceph osd set noout
>> but this doesn't result in any difference
> 
> For a temporary event like this, you want the osd to be down (so that io 
> can continue with remaining replicas) but NOT to mark it out (so that data 
> doesn't get rebalanced).  The simplest way to do that is
> 
> ceph osd set noout
> killall ceph-osd
> .. reboot ..
> 
> Just remember to do
> 
> ceph osd unset noout
> 
> when you are done so that future osds that fail will get marked out on 
> their own after the 5 minute (default) interval.
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
