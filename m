From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Why does Erasure-pool not support omap?
Date: Wed, 25 Oct 2017 11:57:16 -0700
Message-ID: <37aa304a-f13b-2cf8-c5c5-5d03d37feffa@redhat.com>
References: <201710251652060421729@zte.com.cn>
 <alpine.DEB.2.11.1710251213140.22592@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932302AbdJYS5R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 14:57:17 -0400
In-Reply-To: <alpine.DEB.2.11.1710251213140.22592@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, xie.xingguo@zte.com.cn
Cc: ceph-devel@vger.kernel.org, gfarnum@redhat.com

On 10/25/2017 05:16 AM, Sage Weil wrote:
> Hi Xingguo,
> 
> On Wed, 25 Oct 2017, xie.xingguo@zte.com.cn wrote:
>>        I wonder why erasure-pools can not support omap currently.
>>
>>        The simplest way for erasure-pools to support omap I can figure out would be duplicating omap on every shard.
>>
>>        It is because it consumes too much space when k + m gets bigger?
> 
> Right.  There isn't a nontrivial way to actually erasure code it, and
> duplicating on every shard is inefficient.
> 
> One reasonableish approach would be to replicate the omap data on m+1
> shards.  But it's a bit of work to implement and nobody has done it.
> 
> I can't remember if there were concerns with this approach or it was just
> a matter of time/resources... Josh? Greg?

It restricts us to erasure codes like reed-solomon where a subset of 
shards are always updated. I think this is a reasonable trade-off 
though, it's just a matter of implementing it. We haven't written
up the required peering changes, but they did not seem too difficult to
implement.

Some notes on the approach are here - just think of 'replicating omap'
as a partial write to m+1 shards:

http://pad.ceph.com/p/ec-partial-writes
