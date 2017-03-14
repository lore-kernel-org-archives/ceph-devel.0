From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Question about writeback performance and content address obejct
 for deduplication
Date: Tue, 14 Mar 2017 15:25:09 +0900
Message-ID: <CAFNt83ZUHKxPZJiFO0MEbj+BNgQo6PxmfFQWdQ=E5fnq-w+Piw@mail.gmail.com>
References: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com>
 <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal> <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com>
 <alpine.DEB.2.11.1702071442411.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36442 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdCNGZL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 02:25:11 -0400
Received: by mail-vk0-f45.google.com with SMTP id t8so46928495vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Mar 2017 23:25:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1702071442411.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

Hi Sage


I addressed all of your concerns (I applied CAS pool and dedup
metadata in object_info_t) and created public repository in order to
show the prototype implementation
(https://github.com/myoungwon/ceph/commit/13597f62405d1c5a4977d630e69331407ef3a07a,
support non-aligned I/O, but for (K)RBD). This code is based on Jewel
and is not cleaned well but you can see the basic flow (start_flush(),
maybe_handle_cache_detail() ). It would be nice if you give me some
comments.

I have some queries mentioned below on which your feedback is highly required.

1. dedup metadata in object_info_t

You mentioned that it would be nice to make tuple in object_info_t
such as map<offset, tuple<length, cas object, pool>> But, I made
dedup_chunk_info_t in object_info_t because I need one more parameter
(chunk_state) and for extensibility. This is because to avoid read and
fingerprinting during flush time. chunk_state represents three states
in writeback mode. First is CLEAN (data and fingerprint are not
modified). Second is MODIFIED (data is modified but fingerprint is not
calculated). Third is CALCULATED (data is modified and fingerprint is
also calculated). When data is stored in cache tier, chunk_state will
be defined. Therefore, reading data and fingerprinting can be removed
during flush.


2. Single Rados Operation

You mentioned a Rados operation which can concurrently read the
reference count and write data. Do you want that API in objecter
class? (for example, objector->read_ref_and_write())


3. Write sequence for performance.

Current write sequence (proxy mode) is

a. Read metadata (promote_object)
b. Send data to OSD (in CAS pool) and send dedup metadata to OSD (in
original pool)
c. If data and metadata are stored then, proxy osd will issue message
to decrease the reference count (for previous chunk) to OSD (in CAS
pool) and update local object metadata (via simple_opc_submit)
d. If reference count is successful, send Ack to client

As you can see, the number of operations increased due to reference
count and metadata updates. This can degrade performance. My question
is that can we send ack to client at (c) above? (But I am worried
about inconsistent reference count state.)



Write sequence (writeback mode) is

a.  Read object data and do fingerprinting (if data is not calculated).
b. Send reference count decrement message (for previous chunk) to osd
(in CAS pool) and updates local object metadata
c. Send copy_from message to osd (in CAS pool) and send copy_from
message (in order to copy the dedup metadata) to a osd (in original
pool)

Writeback mode also increase the number of operation. Can we reduce?



4. Performance.

Performance is improved compared to previous results. But It still
seems to be improving. (512KB block, Seq. workload, fio, KRBD, single
thread, target_max_objects = 4)

Major concerns are first is fingerprint overhead and second is
writeback performance in cache tier. When the chunk size is large
(>512KB), SHA1 takes more than 3ms. (This can be reduced if we use
small chunk.)

Regarding writeback performance, Flush need two more operations than
proxy mode. First is "marking clean state". Second is "reading dedup
metadata and data from storage". Therefore, actual read and write
occur. These cause that flush completion is delayed.

Small chunk performance in the writeback mode is significantly
degraded because single flush thread handles multiple copy_from
message. It seems that we should improve basic flushing performance.


Write performance (MB/s)

Dedup ratio     0         60       100

Proxy             55       64       73

Writeback       48       50       50

Original           120      120      122



Read performance (MB/s)

Dedup ratio     0         60       100

Proxy             117      130      141

Writeback       198      197      200

Original           280      276      285




5. Command to enable dedup

Ceph osd pool create sds-hot 1024
Ceph osd pool create sds-cas 1024
Ceph osd tier add_cas rbd sds-hot sds-cas
Ceph osd tier sds-hot (proxy or writeback)
Ceph osd tier dedup_block rbd sds-hot sds-cas (chunk size. e.g. 65536, 131072..)
Ceph osd tier set-overlay rbd sds-hot



Thanks
Myoungwon Oh
(omwmw@sk.com)

2017-02-07 23:50 GMT+09:00 Sage Weil <sweil@redhat.com>:
> On Tue, 7 Feb 2017, myoungwon oh wrote:
>> Hi sage.
>>
>> I uploaded the document which describe my overall appoach.
>> please see it and give me feedback.
>> slide: https://www.slideshare.net/secret/JZcy3yYEDIHPyg
>
> This approach looks pretty close to what we have been planning.  A few
> comments:
>
> 1) I think it may be better to view the tier/pool that has the object
> metadata as the "base" pool, and the CAS pool with the refcounted
> object chunks as as tier below that.
>
> 2) I think we can use an object class or a handful of new native rados
> operations to make the CAS pool read/write operations more efficient.  In
> your slides you describe a process something like
>
>   rados(getattr)
>   if exists
>      rados(increment ref count)
>   else
>      rados(write object and set ref count to 1)
>
> This could be collapsed into a single optimistic operation that sends the
> data and a command that says "create or increment ref count" so that the
> conditional behavior is handled at the OSD.  This will be more efficient
> for small chunks.  (For large chunks, or in cases where we have some
> confidence that the chunk probably already exists, the pessimistic
> approach might still make sense.)  Either way, we should probably support
> both.
>
> 3) We'd like to generalize the first pool behavior so that it is just a
> special case of the new tiering functionality.  The idea is that an
> object_info_t can have a 'manifest' that described where and how the
> object is really stored instead of the object data itself (much like it
> can already be a whiteout, etc.).  In the simplest case, the manifest
> would just say "this object is stored in pool X" (simple tiering).  In
> this case, the manifest would a structure like
>
>   map<offset, tuple<length, cas object, pool>>
>
> I think it'll be worth the effort to build a general struture here that we
> can use for basic tiering (not just dedup).
>
> sage
>
>
>
>>
>> thanks
>>
>>
>> 2017-01-31 23:24 GMT+09:00 Sage Weil <sage@newdream.net>:
>> > On Thu, 26 Jan 2017, myoungwon oh wrote:
>> >> I have two questions.
>> >>
>> >> 1. I would like to ask about CAS location. current our implementation store
>> >> content address object in storage tier.However, If we store the CAO in the
>> >> cache tier, we can get a performance advantage. Do you think we can create
>> >> CAO in cachetier? or create a separate storage pool for CAS?
>> >
>> > It depends on the design.  If the you are naming the objects at the
>> > librados client side, then you can use the rados cluster itself
>> > unmodified (with or without a cache tier).  This is roughly how I have
>> > anticipated implementing the CAS storage portion.  If you are doing the
>> > chunking hashing and within the OSD itself, then you can't do the CAS
>> > at the first tier because the requests won't be directed at the right OSD.
>> >
>> >> 2. The results below are performance result for our current implementation.
>> >> experiment setup:
>> >> PROXY (inline dedup), WRITEBACK (lazy dedup, target_max_bytes: 50MB),
>> >> ORIGINAL(without dedup feature and cache tier),
>> >> fio, 512K block, seq. I/O, single thread
>> >>
>> >> One thing to note is that the writeback case is slower than the proxy.
>> >> We think there are three problems as follows.
>> >>
>> >> A. The current implementation creates a fingerprint by reading the entire
>> >> object when flushing. Therefore, there is a problem that read and write are
>> >> mixed.
>> >
>> > I expect this is a small factor compared to the fact that in writeback
>> > mode you have to *write* to the cache tier, which is 3x replicated,
>> > whereas in proxy mode those writes don't happen at all.
>> >
>> >> B. When client request read, the promote_object function reads the object
>> >> and writes it back to the cache tier, which also causes a mix of read and
>> >> write.
>> >
>> > This can be mitigated by setting the min_read_recency_for_promote pool
>> > property to something >1.  Then reads will be proxied unless the object
>> > appears to be hot (because it has been touched over multiple
>> > hitset intervals).
>> >
>> >> C. When flushing, the unchanged part is rewritten because flush operation
>> >> perform per-object based.
>> >
>> > Yes.
>> >
>> > Is there a description of your overall approach somewhere?
>> >
>> > sage
>> >
>> >
>> >>
>> >> Do I have something wrong? or Could you give me a suggestion to improve
>> >> performance?
>> >>
>> >>
>> >> a. Write performance (KB/s)
>> >>
>> >> dedup_ratio  0 20 40 60 80 100
>> >>
>> >> PROXY  45586 47804 51120 52844 56167 55302
>> >>
>> >> WRITEBACK  13151 11078 9531 13010 9518 8319
>> >>
>> >> ORIGINAL  121209 124786 122140 121195 122540 132363
>> >>
>> >>
>> >> b. Read performance (KB/s)
>> >>
>> >> dedup_ratio  0 20 40 60 80 100
>> >>
>> >> PROXY  112231 118994 118070 120071 117884 132748
>> >>
>> >> WRITEBACK  34040 29109 19104 26677 24756 21695
>> >>
>> >> ORIGINAL  285482 284398 278063 277989 271793 285094
>> >>
>> >>
>> >> thanks,
>> >> Myoungwon Oh
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>>
>>
