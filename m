From: xiaoyan li <wisher2003@gmail.com>
Subject: Re: CDM for: pg log, pg info, and dup ops data storage
Date: Tue, 21 Nov 2017 16:25:30 +0800
Message-ID: <CAERxPZJccTJ3X7t6-O0FxCDiHekWX07MZcRZHQHMX1_Rr+=cSQ@mail.gmail.com>
References: <fad6dd2f-2d81-c05a-46a6-8dca32574e31@gmail.com> <58231112-c4a0-9467-b139-4da070beb65a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:39265 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdKUIZb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Nov 2017 03:25:31 -0500
Received: by mail-oi0-f42.google.com with SMTP id r190so7973408oie.6
        for <ceph-devel@vger.kernel.org>; Tue, 21 Nov 2017 00:25:31 -0800 (PST)
In-Reply-To: <58231112-c4a0-9467-b139-4da070beb65a@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Mark,

My understanding about option 1 is to store pg logs(pg_log_entry_t) in
allocated partition. And store pg_info_t and pg_log_t etc in RocksDB.
Yes?
Meanwhile, could you kindly help to clear the following concerns?

1. Does every pg have a ring buffer?  I suppose this is easier for
every pg. Only when max_pg_log_entries changes, the buffer needs to
change its size.
2. What for dup op entries for?
3. Are the pg logs' and dup ops' insertion sequences same as their
deletion sequences?


On Mon, Oct 30, 2017 at 11:18 PM, Mark Nelson <mark.a.nelson@gmail.com> wrote:
> I forgot to mention, Josh also made the point that perhaps on NVMe we don't
> want to record pg log data at all.  Maybe the benefit of having the log
> isn't worth the overhead!
>
> Mark
>
>
> On 10/30/2017 09:51 AM, Mark Nelson wrote:
>>
>> Hi Folks,
>>
>> I had a really good conversation with Josh Durgin on Friday and I wanted
>> to write it down before I forgot everything.  I figured I might as well
>> post it here too since folks might be interested or come up with even
>> better ideas.
>>
>> Background: Recently I've been looking into how much work RocksDB is
>> doing in Bluestore dealing with the creation and deletion of pg log, pg
>> info, and dup op key/value pairs.  Now that we are separating OMAP data
>> into it's own column family, it is possible to look at OMAP statistics
>> independently of bluestore metadata:
>>
>> - ~1 hour 4K random overwrites to RBD on 1 NVMe OSD
>> - 128 PGs
>> - stats are sloppy since they only appear every ~10 mins
>> - [D] CF = onodes, etc
>> - [M] CF = pglog/dup_ops/pginfo
>> - [L] CF = defered IO
>>
>> First the default:
>>
>> min_pg_log_entries = 1500, trim = default, iops = 26.6K
>>
>> [D] CF - Size:  65.63MB, KeyIn:  22M, KeyDrop:  17M, Flush:  7.858GB
>> [M] CF - Size: 118.09MB, KeyIn: 302M, KeyDrop: 269M, Flush: 15.847GB
>> [L] CF - Size:   1.00MB, KeyIn: 181K, KeyDrop:  80K, Flush:  0.320GB
>>
>> With dup ops code path disabled by increasing the min pglog entries:
>>
>> min_pg_log_entries = 3000, trim = default iops = 28.3K
>> [D] CF - Size:  23.13MB, KeyIn:  25M, KeyDrop:  19M, Flush:  8.762GB
>> [M] CF - Size: 159.97MB, KeyIn: 202M, KeyDrop: 175M, Flush: 16.890GB
>> [L] CF - Size:   0.86MB, KeyIn: 201K, KeyDrop:  89K, Flush:  0.355GB
>>
>> Notice the large drop in KeyIn and KeyDrop records!
>>
>> And now adding a hack to remove pginfo:
>>
>> min_pg_log_entries = 3000, trim = default, pginfo hack, iops = 27.8K
>>
>> [D] CF - Size:  23.15MB, KeyIn:  24M, KeyDrop:  19M, Flush:  8.662GB
>> [M] CF - Size: 159.97MB, KeyIn: 162M, KeyDrop: 139M, Flush: 10.335GB
>> [L] CF - Size:   1.39MB, KeyIn: 201K, KeyDrop:  89K, Flush:  0.355GB
>>
>> There's still 162M KeyIn and 139M keyDrop events for pglog remaining!
>>
>> So as a result of this I started thinking that there must be a better
>> way to deal with this kind of data than constantly writing and deleting
>> key/value pairs from the database, at least for dup ops and pg log.
>> Based on my conversation with Josh it sounds like we are already reusing
>> pginfo keys which might explain why hacking it out didn't result in a
>> 33% drop in key inserts and deletes.
>>
>> For pg log and dup ops, my first thought was to simply create a simple
>> on-disk ring-buffer for pglog and dup ops.  The idea being that instead
>> of specifying a "min" and "max" number of pglog entries, the user would
>> just assign a portion of the disk (in Bluestore perhaps a portion of the
>> DB device) that would be reserved for the ring buffer and we'd fill it
>> with as many pglog and dup op entries as we could.
>>
>> Josh keenly pointed out that we want to make sure that inactive PG logs
>> don't get overwritten by active ones.  To deal with this, I proposed a
>> modification: use a series of logs and reference count the per-pg links.
>>  You'd never delete an old log until all references to it are removed.
>> The problem here is that potentially if you had a lot of inactive PGs
>> you could end up with pretty big space amplification.
>>
>> Advantages:
>>
>> 1) Avoid key creation/deletion
>> 2) sequential appends only
>> 3) Write once (no direct write amplification)
>>
>> Disadvantages:
>>
>> 1) potential for large space amp when PGs are inactive
>> 2) lots of new code
>> 3) potential for thrashing with the RocksDB WAL and other writes
>>
>> Josh pointed out another potential option: create a ring buffer in
>> RocksDB with sequentially ordered keys.  The key names themselves are
>> not particularly important: some prefix along with say an 8byte index.
>> In this scenario we'd still end up writing to the WAL first and
>> potentially compacting into an SST file, but the overhead should be less
>> (far less?) than the current behavior.  We could also make it general
>> enough that we could have per-pg ring buffers for pglog data and a
>> global ringbuffer for dup-ops (which is sort of the best case scenario
>> for both sitautions)
>>
>> Advantages:
>>
>> 1) Reuse the KeyValueDB interface (and all of the optimized RocksDB code!)
>> 2) Still avoid new key creation/deletion
>> 3) WAL writes are still sequentially laid out and compaction overhead
>> may not be too bad
>> 4) Shared WAL means less thrashing on spinning disks than multiple
>> independent WALs.
>> 4) Space amp potentially less bad than on-disk ring-buffer approach.
>>
>> Disadvantages:
>>
>> 1) still has compaction overhead
>> 2) less control over what RocksDB does
>> 3) shared WAL means implications for global KV traffic, even with
>> independent column families.
>>
>> No matter what we do, I think we need to get away from the current
>> behavior for pglog and dup ops.  Unless I'm missing something (and I
>> could be!) I don't think we need to be creating and deleting keys
>> constantly like we currently are doing.  I suspect that either of the
>> above approaches would improve the situation dramatically.
>>
>> Mark
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best wishes
Lisa
