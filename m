From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Increasing number of PGs
Date: Tue, 31 Jul 2012 03:15:40 +0930
Message-ID: <5016C844.7010106@bashkirtsev.com>
References: <5013B7E7.3020407@bashkirtsev.com> <5016B34A.8090902@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:55169 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2G3Rpz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 13:45:55 -0400
In-Reply-To: <5016B34A.8090902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 31/07/12 01:46, Josh Durgin wrote:
>
>> So here two questions:
>>
>> 1. Should I increase number of PGs in rbd pool or better leave it where
>> it is?
>
> It would be better to increase it from a data balancing point of view,
> but it's not clear that it would help performance.
I would care about data balancing first - as I said it is currently 
skewed a bit. Performance wise perhaps it will take a bit more 
CPU/memory to process but not to the extent where it will affect 
performance.
>
>> 2. Wiki says that increase in PGs is not tested and only should be
>> attempted on empty pool. Date on Wiki is quite old. Is this still an
>> issue? Is it safe to increase PGs number on 0.49 on pool in use?
>
> Right now the number of pgs in a pool can't be increased. This should
> be possible in a couple months. If you can stop I/O to the current pool,
> you can create a new one with more pgs, copy all the data to it, delete
> the original and rename the new one.
Then I am stuck with current number of PGs: pool is in heavy use and 
there virtually no chance to increase PGs number offline. Will wait for 
a version which will make it possible.

