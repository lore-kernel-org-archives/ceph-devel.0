From: Guang Yang <yguang11@outlook.com>
Subject: Re: CDS G/H - bucket index sharding
Date: Tue, 24 Jun 2014 11:38:02 +0800
Message-ID: <BLU436-SMTP12849B607E8EFF8BBFFEB26DF1E0@phx.gbl>
References: <etPan.53a78626.6f6dd9ac.11c48@scuttleair.local> <BLU436-SMTP6695E9BCA624ADB74EE177DF1F0@phx.gbl> <CABBk=J-N7W8wzwj=qFxXy5i2vyJBd8HyhE1deRegntxK05-fdg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s2.hotmail.com ([65.55.111.141]:49348 "EHLO
	BLU004-OMC4S2.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaFXDiN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 23:38:13 -0400
In-Reply-To: <CABBk=J-N7W8wzwj=qFxXy5i2vyJBd8HyhE1deRegntxK05-fdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Ceph-devel <ceph-devel@vger.kernel.org>

Thanks Yehuda, my comments inline...
On Jun 23, 2014, at 10:44 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:

> On Mon, Jun 23, 2014 at 4:11 AM, Guang Yang <yguang11@outlook.com> wrote:
>> Hello Yehuda,
>> I drafted a brief summary for the status of the bucket index sharding blueprint and put it here - http://pad.ceph.com/p/GH-bucket-index-scalability, it would be nice you can take a look to see if there is anything I missed, I also posted the pull request here - https://github.com/ceph/ceph/pull/2013.
> 
> Just one note regarding the blueprint, other BI log operations will
> need to use the new schema too (e.g., log trim operations).
Yeah, that has been implemented, thanks for pointing it out.
> 
> I was thinking a bit about how to do resizing and dynamic sharding
> later on. My thought was that we'd have two bucket prefixes: one for
> read and delete operations, and one for read, write and delete
> operations. Normally both will point at the same prefix and we'll just
> access a single one. But when we're resizing we'll need to use both.
> If we're listing objects we'll access both sets of shards and merge
> everything). If we're creating object we'll just create it in the
> second one. Removing object, we'll remove it from both.
> The above description is a bit vague, and shouldn't really change what
> we do now. Just that the implementation needs to maybe abstract that
> bucket access decision nicely so that in the future we could implement
> this easily.
Considering the tradeoff we have with multiple shards for bucket index object, we are not likely to create a large number of shards (except we add something like per shard listing), thus it might make sense to start with the upper bound directly (e.g. 50), it might be good enough for most use cases. Another direction we may explore is to let user specify the number of shards (e.g. via user defined metadata), when he/she has an estimation of the number of objects for a bucket.

As for dynamic bucket, I think there are two options, one is with no data migration when changing the number of shards (thus there might be multiple version of truth), another is to have data migration. The approach mentioned above is the first one, we should be able to implement the above approach with some aggregation at client side for multiple version of truth.
> 
> Sadly I'll be off for this CDS, but I'm sure Josh, Greg, Sage, and
> others will be able to help there.
> 
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

