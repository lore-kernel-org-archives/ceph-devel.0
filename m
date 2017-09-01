From: xiaoyan li <wisher2003@gmail.com>
Subject: Re: luminous OSD memory usage
Date: Fri, 1 Sep 2017 10:00:38 +0800
Message-ID: <CAERxPZKokC4j76NMLoc1RLLBS8_cZVkKXavaqF--03LxcF5KJQ@mail.gmail.com>
References: <d3b8007f-4bdf-65c5-f4e9-7d1d9c85e019@synesis.ru> <alpine.DEB.2.11.1708301455490.3491@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36046 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdIACAj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2017 22:00:39 -0400
Received: by mail-oi0-f49.google.com with SMTP id t75so10933547oie.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 19:00:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708301455490.3491@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Aleksei Gutikov <aleksey.gutikov@synesis.ru>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 30, 2017 at 11:17 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Aleksei,
>
> On Wed, 30 Aug 2017, Aleksei Gutikov wrote:
>> Hi.
>>
>> I'm trying to synchronize osd daemons memory limits and bluestore cache
>> settings.
>> For 12.1.4 we have hdd osds usage about 4G with default settings.
>> For ssds we have limit 6G and they are been oom killed periodically.
>
> So,
>
>> While
>> osd_op_num_threads_per_shard_hdd=1
>> osd_op_num_threads_per_shard_ssd=2
>> and
>> osd_op_num_shards_hdd=5
>> osd_op_num_shards_ssd=8
>
> aren't relevant to memory usage.  The _per_shard is about how many bytes
> are stored in each rocksdb key, and the num_shards is about how many
> threads we use.

I can't understand the point about _per_shard. I notice that
osd_op_num_threads_per_shard is used to set cache shards in BlueStore.
>
> This is the one that matters:
>
>> bluestore_cache_size_hdd=1G
>> bluestore_cache_size_ssd=3G
>
> It governs how much memory bluestore limits itself to.  He bad news is
> that bluestore counts what it allocates, not how much memory the allocator
> uses, so there is some overhead.  From what I've anecdotally seen it's
> something like 1.5x, which kind of sucks; there is more to be done here.
>
> On top of that is usage by the OSD outside of bluestore,
> which is somewhere in the 500m to 1.5g range.
>
> We're very interested in hearing what observed RSS users see relative to
> the configured bluestore size and pg count, along with a dump of the
> mempool metadata (ceph daemon osd.NNN dump_mempools).
>
>> Does anybody have an idea about the equation for upper bound of memory
>> consumption?
>
> Very roughly, something like: osd_overhead + bluestore_cache_size * 1.5 ?
>
>> Can bluestore_cache_size be decreased safely for example to 2G, or to 1G?
>
> Yes, you can/should change this to whatever you like (big or small).
>
>> I want to calculate the maximum expected size of bluestore metadata (that must
>> be definitely fit into cache) using size of raw space, average size of
>> objects, rocksdb space amplification.
>> I thought it should be something simple like
>> raw_space/avg_obj_size*obj_overhead*rocksdb_space_amp.
>> For example if obj_overhead=1k, hdd size=1T, rocksdb space amplification is 2
>> and avg obj size=4M then 1T/4M*1k*2=500M so I need at least 512M for cache.
>> But wise guys said that I have to take into account number of extents also.
>> But bluestore_extent_map_shard_max_size=1200, I hope this number is not a
>> multiplicator...
>
> Nope, just a shard size...
>
>> What would be correct approach for calculation of this minimum cache size?
>> What can be expected size of key-values stored in rocksdb per rados object?
>
> This depends, unfortunately, on what the write pattern is for the objects.
> If they're written by RGW in big chunks, the overhead will be smaller.
> If it comes out of a 4k random write pattern it will be bigger.  Again,
> very interestd in hearing user reports of what is observed in real world
> situations.  I would trust that more than a calculation from first
> principles like the above.
>
>> Default bluestore_cache_kv_ratio*bluestore_cache_size_ssd=0.99*3G
>> while default bluestore_cache_kv_max=512M
>> Looks like BlueStore::_set_cache_sizes() will set cache_kv_ratio to 1/6 in
>> default case. Is 512M enough for bluestore metadata?
>
> In Mark's testing he found that we got more performance benefit when
> small caches were devoted to rocksdb and large caches were devoted mostly
> to the bluestore metadata cache (parsed onodes vs caching the encoded
> on-disk content).  You can always adjust the 512m value upwards (and that
> may make sense for large cache sizes).  Again, very interested in hearing
> whther that works better or worse for your workload!
>
I am wondering whether Bluestore should have Rocksdb block cache.
Rocksdb uses block cache to cache data blocks in memory for reads. But
the data is already cached by bluestore metadata cache. And bluestore
metadata cache has two advantages: 1. no cache for pg_log and deferred
io logs. 2. Rocksdb cache data blocks. it doesn't have
fine-granularity.

Thanks-
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best wishes
Lisa
