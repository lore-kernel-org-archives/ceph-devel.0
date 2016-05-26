From: Sage Weil <sage@newdream.net>
Subject: Re: Snap handling in the cache tiering case
Date: Thu, 26 May 2016 08:52:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605260851500.6221@cpach.fuggernut.com>
References: <CA+cZ7sjxwa=AZYiQEQA7Han97QcuCSYKZqt_RNwG9Z5N2BTQ3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58776 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbcEZMwR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 08:52:17 -0400
In-Reply-To: <CA+cZ7sjxwa=AZYiQEQA7Han97QcuCSYKZqt_RNwG9Z5N2BTQ3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhiqiang Wang <wonzhq@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 26 May 2016, Zhiqiang Wang wrote:
> Hi all,
> 
> In the current implementation, the base pool's snap info is well
> propagated to the cache pool. However, this is not vice verse. When
> creating a pool snap on the cache pool, this information is not shared
> with the base. And it could potentially be overwritten by the later
> snap operations on the base pool. Should we allow pool snap operations
> on the cache pool?

We shouldn't allow them on the cache pool.

> Another question is that is it safe to clear all the snap infos on the
> cache pool when removing the cache tiering? This seems ok to me if the
> base and cache pools' snap infos are identical. I'm asking this
> because if the snap infos are not cleared on the cache pool, it
> prevents us from using this pool as a cache pool again.

Yeah, we should clear them.  There should also be the check that the pool 
is in fact empty when this happens (that should already be there...).

sage

