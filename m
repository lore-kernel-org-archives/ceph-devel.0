From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: recommanded cache setting for rbd image
Date: Mon, 05 Nov 2012 15:57:11 -0800
Message-ID: <50985257.3040304@inktank.com>
References: <5097D2DD.2000006@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60763 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2KEX5a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 18:57:30 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2905751dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 15:57:30 -0800 (PST)
In-Reply-To: <5097D2DD.2000006@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/05/2012 06:53 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> right now i'm testing rbd block devices with kvm using Default cache (no
> cache).
>
> Is there any recommanded value for RBD? (i don't wanna loose data)

It acts like a well-behaved disk cache (i.e. it respects
flushes/barriers from the guest), so it's no more likely to cause data
loss than a local hard disk in the event of an unexpected shutdown.

I recommend running it in writeback mode (the default when rbd cache = 
true). The best cache size will depend on your workload and hardware.

