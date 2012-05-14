From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: waiting for sub ops
Date: Mon, 14 May 2012 08:36:37 +0200
Message-ID: <4FB0A7F5.6000504@profihost.ag>
References: <4FACB96F.3050309@profihost.ag> <Pine.LNX.4.64.1205121714120.21796@cobra.newdream.net> <4FAFF7B0.2030400@profihost.ag> <Pine.LNX.4.64.1205132124190.29887@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:43690 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab2ENGgj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 02:36:39 -0400
In-Reply-To: <Pine.LNX.4.64.1205132124190.29887@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


>> 1.) th osd bench shows 150MB/s per osd
>> 2.) iperf shows constant 930Mbit/s per eth
>> 3.) when i write 16GB with dd to the ceph mount i see spikes to 450Mbit/ and
>> drops to 90kb/s for long periods of time. The overall dd speed is then
>> 40Mbit/s
> 
> We were doing some btrfs performance testing this week and seeing similar 
> bursty behavior.  (See my May 7th performance on btrfs email for some 
> out-of-context detail.)  It currently looks like the workload we're 
> presenting to the fs is resulting in non-optimal writeout, but we haven't 
> figured out yet how we can improve that or nailed down the source for the 
> burstiness.  How that some of the inktank launch stuff is out of the way 
> we'll be picking it up again and continuing to work on that this week.
> 
> If you're interested in getting involved, ping nhm in #ceph.  It would be 
> interesting to capture a block trace from your environment and see if 
> what you're seeing is what we're seeing!
Thank for your information - we've holdays in germany from thursday on
and i won't be available. So thanks for the offer.

But if you want i can provide a trace. Just tell me how i can produce one.

Thanks!

Stefan
