From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rados read ordering
Date: Mon, 08 Dec 2014 15:38:48 -0800
Message-ID: <54863688.20202@inktank.com>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:49553 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbaLHXhf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 18:37:35 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so13713igi.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Dec 2014 15:37:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, sjust@redhat.com, jdurgin@redhat.com, yehuda@redhat.com, dillaman@redhat.com
Cc: zhiqiang.wang@intel.com, ceph-devel@vger.kernel.org

On 12/08/2014 09:03 AM, Sage Weil wrote:
> The current RADOS behavior is that reads (on any given object) are always
> processed in the order they are submitted by the client.  This causes a
> few headaches for the cache tiering that it would be nice to avoid.  It
> also occurs to me that there are likely cases where we could go a lot
> faster by not strictly ordering things.  For example, a stat can respond
> more quickly than a large read, and some reads may hit cache while others
> go to disk.  This doesn't happen currently because of the (lame) way we do
> reads synchronously, but hope that can change too.
>
> I propose we drop this semantic.  If a client wants reads to have a strict
> ordering, they can set the existing RWORDERED flag (which also orders them
> with respect to writes).  That's not the most general thing ever, but I'm
> not sure we care about callers who want reads ordered with respect to each
> other but not writes.
>
> The real question is whether there are any users that want/need this
> currently.  I can't think of any offhand.  In several places we submit
> multiple *writes* and expect them to be strictly ordered (e.g., we
> set a completion on teh last write only).  I don't think we do this
> anywhere for reads though...
>
> Josh, Yehuda, Jason--can you think of any in RBD or RGW that would depend
> on this?

Nope, I've thought we should fix this since I found out about it.
