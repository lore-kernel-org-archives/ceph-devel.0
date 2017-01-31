From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: RGW Indexing-in-PostgreSQL?
Date: Tue, 31 Jan 2017 12:03:40 +0800
Message-ID: <CACKY0b_WXCmjPGFqWMZCrRk7fw_rcF6zgyWT72NS2Qjbxb4Seg@mail.gmail.com>
References: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
 <28fa42fd-4d60-9d73-bfd0-997b183b1320@redhat.com> <20170131001923.pap3b24na4lrzqxc@134d30345a13d6cf85884e4b>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34516 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdAaEDl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2017 23:03:41 -0500
Received: by mail-yb0-f195.google.com with SMTP id w194so28486991ybe.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2017 20:03:41 -0800 (PST)
In-Reply-To: <20170131001923.pap3b24na4lrzqxc@134d30345a13d6cf85884e4b>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>, Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

BTW, it would be better to support Bucket Index Plugin mechanism. We
could use Hbase/Cassandra as optional back-end in production
environment since hbase/cassandra is already deployed in our servers.

2017-01-31 8:19 GMT+08:00 Martin Millnert <martin@millnert.se>:
> Hi Mark,
>
> On Mon, Jan 30, 2017 at 06:09:44PM -0600, Mark Nelson wrote:
>>
>>
>> On 01/30/2017 05:56 PM, Martin Millnert wrote:
>> > Hi,
>> >
>> > we're running RGW with indexes placed on fast pools, whereas the data is
>> > placed on slow pools. The write throughput is approximately 10% of rados
>> > bench and I guess we're experiencing some locking/syncronization
>> > feature, because parallelisation doesn't really speed it up.
>> > I've seen the sharding option, and the indexless option, but neither one
>> > of these seems like /the/ fix to me.
>> > My limited knowledge of the RGW code makes me guess it's due to the
>> > indexes, and possibly even additional metadata that RGW keeps
>> > up-to-date?
>> >
>> > Assuming that the index objectes must be downloaded, rewritten, and
>> > re-uploaded to the index pools by RGW (and that this should be
>> > locking?), the thought that I've had for a while now is:
>> > How hard is it to abstract these index operations and add support for
>> > actually using PostgreSQL as a backend?
>>
>> The indexes are definitely something to watch!  It would be very interesting
>> to see how your write benchmark does with indexless buckets.
>
> Yeah we'll try to get some comparative data to try to find the
> bottleneck(s), though what I want is fast indexes. :-)
>
>> we've seen in the past is when the bucket indexes are slow (in that
>> particular case because the bucket index pool only had 8 PGs!), RGW is
>> spending most of it's time waiting on bucket index updates.  You can grab a
>> couple of GDB stacktraces of the RGW process to see if this is happening in
>> your case.
>
> Thanks for the pointer, I'll see what we can do.
>
>> > I don't mean to say bad words vis-a-vis a completely self-contained data
>> > management system, etc, but (more) right(*) (optional) tool for the job has some
>> > quality to it too. :-)
>> >
>> > I'd be willing to take a look at it, I guess.
>> >
>> > Thoughts?
>>
>> I think first figure out if it's actually the bucket indexes.
>
> Sure, data first makes very good sense. :-)
>> Like you said, there's more metadata associated with RGW, so at least some
>> of what you are seeing could be metadata getting pushed out of the inode and
>> into separate extents.  Are you writing out lots of really small objects or fewer
>> larger objects?
>
> We're throughput limited when uploading single chunk or multi chunk
> large objects (10+ MB), this is the main concern.
> Data pool is on a wide EC (10+4), where rados bench saturate CPU on hosts,
> but give 10x throughput. Have to double check if our config is doing additional
> striping/chunking of incoming objects, and how this interacts with EC.
>
> Thanks,
> Martin
