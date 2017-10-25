From: Sage Weil <sweil@redhat.com>
Subject: Re: Why does Erasure-pool not support omap?
Date: Wed, 25 Oct 2017 12:16:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710251213140.22592@piezo.us.to>
References: <201710251652060421729@zte.com.cn>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2027976288-1508933795=:22592"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbdJYMQf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 08:16:35 -0400
In-Reply-To: <201710251652060421729@zte.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xie.xingguo@zte.com.cn
Cc: ceph-devel@vger.kernel.org, jdurgin@redhat.com, gfarnum@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2027976288-1508933795=:22592
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Xingguo,

On Wed, 25 Oct 2017, xie.xingguo@zte.com.cn wrote:
>       I wonder why erasure-pools can not support omap currently.
> 
>       The simplest way for erasure-pools to support omap I can figure out would be duplicating omap on every shard.
> 
>       It is because it consumes too much space when k + m gets bigger?

Right.  There isn't a nontrivial way to actually erasure code it, and 
duplicating on every shard is inefficient.

One reasonableish approach would be to replicate the omap data on m+1 
shards.  But it's a bit of work to implement and nobody has done it.

I can't remember if there were concerns with this approach or it was just 
a matter of time/resources... Josh? Greg?

sage
--8323329-2027976288-1508933795=:22592--
