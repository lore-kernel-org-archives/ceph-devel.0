From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Increasing number of PGs
Date: Mon, 30 Jul 2012 09:16:10 -0700
Message-ID: <5016B34A.8090902@inktank.com>
References: <5013B7E7.3020407@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43377 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2G3QQQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 12:16:16 -0400
Received: by pbbrp8 with SMTP id rp8so10051665pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 09:16:16 -0700 (PDT)
In-Reply-To: <5013B7E7.3020407@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On 07/28/2012 02:59 AM, Vladimir Bashkirtsev wrote:
> Hello,
>
> I am working on optimization of ceph performance: CPU load vs OSD data
> load. Right now I have 576 PGs in total. Three pools: metadata, data,
> rbd. Each pool has 192 PGs. data is not used heavily, rbd is in heavy
> use. In total 6 OSDs in cluster. I have read recommendation about 100
> PGs per OSD. Roughly I do have 100 PGs per OSD. But now it seems that
> PGs in data pool are mostly empty while PGs in rbd pool are quite busy.
> Would it make sense to increase number of PGs to be 100 per rbd pool per
> OSD? Technically it should take some memory and CPU but because other
> two pools are virtually stand still it should not make big difference
> while improving data placement on OSDs (which is currently somewhat
> skewed).

If you're not using them, you can delete the data and metadata pools.
You can always recreate them later, or use different pools for cephfs.

> So here two questions:
>
> 1. Should I increase number of PGs in rbd pool or better leave it where
> it is?

It would be better to increase it from a data balancing point of view,
but it's not clear that it would help performance.

> 2. Wiki says that increase in PGs is not tested and only should be
> attempted on empty pool. Date on Wiki is quite old. Is this still an
> issue? Is it safe to increase PGs number on 0.49 on pool in use?

Right now the number of pgs in a pool can't be increased. This should
be possible in a couple months. If you can stop I/O to the current pool,
you can create a new one with more pgs, copy all the data to it, delete
the original and rename the new one.

Josh

> Regards,
> Vladimir

