From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Inline dedup/compression
Date: Tue, 30 Jun 2015 14:03:14 +0800
Message-ID: <CACJqLyY_FYYx9AvK5ShfN+NUKiz25S=w4qPa36sEYN8hFOy-jg@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLyY2P0_O-MRs9MoH1oVg8jESc0EoAjSq4dYmVjH=K0a0mQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319BBA@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36438 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbF3GDP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 02:03:15 -0400
Received: by ykdr198 with SMTP id r198so134971303ykd.3
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 23:03:14 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B319BBA@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jun 30, 2015 at 4:55 AM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Haomai,
>   Thanks for moving the idea forward. Regarding to the compression.  However,  if we do compression on the client level, it is not global. And the compression was only applied to the local client, am I right?  I think there is pros and cons in two solutions and we can get into details more for each solution.

Yes, I think a lot myself about compression with Ceph. At firstly, we
could easily use objectstore backend to implement compress like
filestore with zfs/btrfs and keyvaluestore with leveldb/rocksdb etc.
The advantages are we can enjoy it now. The cons are we may lose too
much for benefit of compression especially for performance.

So we think about to move compression on osd/pg layer(implementation),
maybe we can get compression data from messenger module(NIC or IB card
may offer compression feature), then we directly carry with compressed
data and process this. The problem is that at pg/osd layer, we will
aware of the compress thing and we need to manage compress state(This
is important). Maybe we could create a pool with compressed feature,
and specify compress unit(8-64KB), compress algorithm. The cons is
that the pool level maybe coarsness, and actually increase the
complexity of io process path. For example, if compress unit is 8k, it
means all objects in this pool need to process data with 8k aligned
io, otherwise, we need to read-before-write. Consider the pool is
high-level concept and it's difficult to let users choose accurate
client workload.

If we implement compress thing at client side such as lirbd, we can
get the volume-level compress feature. It should be more friendly to
users. We can create a 64kb compress unit for seq workload and 4kb/8kb
for performance tradeoff volume and no compress for performance
volume. It's the same for cephfs directory level and radosgw bucket.
Librbd may directly split object to compress stripe and cephfs file
can compress one file, it maybe better for compress ratio than
compress unaware data structure in osd side. Another benefit is that
we can enjoy the benefit of compression as early as possible, it may
counteract a part of compress performance degraded. The cons we need
to implement more codes at client library.

>   I really like your idea for dedupe in OSD side   by the way. Let me think more about it.
>
>  Regards,
>  James
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Friday, June 26, 2015 8:55 PM
> To: James (Fei) Liu-SSI
> Cc: ceph-devel
> Subject: Re: Inline dedup/compression
>
> On Sat, Jun 27, 2015 at 2:03 AM, James (Fei) Liu-SSI <james.liu@ssi.samsung.com> wrote:
>> Hi Haomai,
>>   Thanks for your response as always. I agree compression is comparable easier task but still very challenge in terms of implementation no matter where we should implement . Client side like RBD, or RDBGW or CephFS, or PG should be a little bit better place to implementation in terms of efficiency and cost reduction before the data were duplicated to other OSDs. It has  two reasons :
>> 1. Keep the data consistency among OSDs in one PG 2. Saving the
>> computing resources
>>
>> IMHO , The compression should be accomplished before the replication come into play in pool level. However, we can also have second level of compression in the local objectstore.  In term of unit size of compression , It really depends workload and in which layer we should implement.
>>
>> About inline deduplication, it will dramatically increase the complexities if we bring in the replication and Erasure Coding for consideration.
>>
>> However, Before we talk about implementation, It would be great if we can understand the pros and cons to implement inline dedupe/compression. We all understand the benefits of dedupe/compression. However, the side effect is performance hurt and need more computing resources. It would be great if we can understand the problems from 30,000 feet high for the whole picture about the Ceph. Please correct me if I were wrong.
>
> Actually we may have some tricks to reduce performance hurt like compression. As Joe mentioned, we can compress slave pg data to avoid performance hurt, but it may increase the complexity of recovery and pg remap things. Another in-detail implement way if we begin to compress data from messenger, osd thread and pg thread won't access data for normal client op, so maybe we can make it parallel with pg process. Journal thread will get the compressed data at last.
>
> The effect of compression also is a concern, we do compression in rados may not get the best compression result. If we can do compression in libcephfs, librbd and radosgw and make rados unknown to compression, it maybe simpler and we can get file/block/object level compression. it should be better?
>
> About dedup, my current idea is we could setup a memory pool at osd side for checksum store usage. Then we calculate object data and map to PG instead of object name at client side, so a object could always in a osd where it's also responsible for dedup storage. It also could be distributed at pool level.
>
>
>>
>> By the way, Both of software defined storage solution startups like Hdevig and Springpath provide inline dedupe/compression.  It is not apple to apple comparison. But it is good reference. The datacenters need cost effective solution.
>>
>> Regards,
>> James
>>
>>
>>
>> -----Original Message-----
>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> Sent: Thursday, June 25, 2015 8:08 PM
>> To: James (Fei) Liu-SSI
>> Cc: ceph-devel
>> Subject: Re: Inline dedup/compression
>>
>> On Fri, Jun 26, 2015 at 6:01 AM, James (Fei) Liu-SSI <james.liu@ssi.samsung.com> wrote:
>>> Hi Cephers,
>>>     It is not easy to ask when Ceph is going to support inline dedup/compression across OSDs in RADOS because it is not easy task and answered. Ceph is providing replication and EC for performance and failure recovery. But we also lose the efficiency  of storage store and cost associate with it. It is kind of contradicted with each other. But I am curious how other Cephers think about this question.
>>>    Any plan for Cephers to do anything regarding to inline dedupe/compression except the features brought by local node itself like BRTFS?
>>
>> Compression is easier to implement in rados than dedup. The most important thing about compression is where we begin to compress, client, pg or objectstore. Then we need to decide how much the compress unit is. Of course, compress and dedup both like to use keyvalue-alike storage api to use, but I think it's not difficult to use existing objectstore api.
>>
>> Dedup is more possible to implement in local osd instead of the whole pool or cluster, and if we want to do dedup for the pool level, we need to do dedup from client.
>>
>>>
>>>   Regards,
>>>   James
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
