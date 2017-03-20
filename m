From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Question about writeback performance and content address obejct
 for deduplication
Date: Mon, 20 Mar 2017 21:43:53 +0900
Message-ID: <CAFNt83aS0hOWQuairQkKvregr_FCho1__kNqPjM5TMg85oKF5A@mail.gmail.com>
References: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com>
 <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal> <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com>
 <alpine.DEB.2.11.1702071442411.3654@piezo.novalocal> <CAFNt83ZUHKxPZJiFO0MEbj+BNgQo6PxmfFQWdQ=E5fnq-w+Piw@mail.gmail.com>
 <alpine.DEB.2.11.1703160249260.10776@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33444 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbdCTMnz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Mar 2017 08:43:55 -0400
Received: by mail-vk0-f41.google.com with SMTP id d188so69129242vka.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 05:43:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1703160249260.10776@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

Hi sage.

Thanks for your comments!
I created pads in order to brainstorm design option about #1, #2 first.

#1 http://pad.ceph.com/p/deduplication_how_dedup_manifists
#2 http://pad.ceph.com/p/deduplication_how_do_we_store_chunk


Thanks.

2017-03-16 22:42 GMT+09:00 Sage Weil <sweil@redhat.com>:
> Hi Myoungwon,
>
> This is quite a patch!  Sorry for the slow reply.
>
> On Tue, 14 Mar 2017, myoungwon oh wrote:
>> Hi Sage
>>
>>
>> I addressed all of your concerns (I applied CAS pool and dedup
>> metadata in object_info_t) and created public repository in order to
>> show the prototype implementation
>> (https://github.com/myoungwon/ceph/commit/13597f62405d1c5a4977d630e69331407ef3a07a,
>> support non-aligned I/O, but for (K)RBD). This code is based on Jewel
>> and is not cleaned well but you can see the basic flow (start_flush(),
>> maybe_handle_cache_detail() ). It would be nice if you give me some
>> comments.
>>
>> I have some queries mentioned below on which your feedback is highly required.
>>
>> 1. dedup metadata in object_info_t
>>
>> You mentioned that it would be nice to make tuple in object_info_t
>> such as map<offset, tuple<length, cas object, pool>> But, I made
>> dedup_chunk_info_t in object_info_t because I need one more parameter
>> (chunk_state) and for extensibility.
>
> Yes, we definitely want an extensible approach to the state in
> object_info_t that will support
>
>  - a simple redirect ("the object is in that other pool")
>  - a dedup object ("the object consists of these N lumps, each one
> referencing an object named X_i in pool Y_i")
>  - an external system (extenral archive, like a backup system, external
> object store, whatever)
>
> I think we should try to come up with a general notion, like "redirect" or
> "object map" or something that covers other options... not just dedup!
>
>> This is because to avoid read and
>> fingerprinting during flush time. chunk_state represents three states
>> in writeback mode. First is CLEAN (data and fingerprint are not
>> modified). Second is MODIFIED (data is modified but fingerprint is not
>> calculated). Third is CALCULATED (data is modified and fingerprint is
>> also calculated). When data is stored in cache tier, chunk_state will
>> be defined. Therefore, reading data and fingerprinting can be removed
>> during flush.
>
> I'm not following this, though.  I think "clean" would just mean we are
> storing the normal object in the pool.  "modified" would mean that the
> FLAG_DIRTY is set.  And "calculated" would mean we have successfully
> chunked the object, stored or taken refs on the chunks, and written the
> chunk map into object_info_t?
>
>
>> 2. Single Rados Operation
>>
>> You mentioned a Rados operation which can concurrently read the
>> reference count and write data. Do you want that API in objecter
>> class? (for example, objector->read_ref_and_write())
>
> We may not need to make it a first-class rados operation.  For example,
> cls_refcount could probably be extended with a write_or_get operation.
> But it might also be advantageous to make it a native op.  The main thing
> I'm worried about here is that we probably want to make the refs
> reliable and autitable, which means backpointers (so you can look at a
> chunk and see which dedup objects are using it).  That means that a
> popular sequence of bytes might have a huge number of references, and that
> will need to scale gracefully.  Or, we just use counters, accept that
> failure conditions could make us leak dedup chunks, and make all of our
> failure paths fail-safe.
>
>> 3. Write sequence for performance.
>>
>> Current write sequence (proxy mode) is
>>
>> a. Read metadata (promote_object)
>> b. Send data to OSD (in CAS pool) and send dedup metadata to OSD (in
>> original pool)
>> c. If data and metadata are stored then, proxy osd will issue message
>> to decrease the reference count (for previous chunk) to OSD (in CAS
>> pool) and update local object metadata (via simple_opc_submit)
>> d. If reference count is successful, send Ack to client
>>
>> As you can see, the number of operations increased due to reference
>> count and metadata updates. This can degrade performance. My question
>> is that can we send ack to client at (c) above? (But I am worried
>> about inconsistent reference count state.)
>
> I'm worried that if we focus on inline dedup immediately we'll end up with
> something that is less general and more fragile.  It's also harder.
> Instead, we can consider the inline and async dedup separately.  Async:
>
> writeback:
> a. normal write into object.  ack client.
> ...
> b. dedup agent: read object (from cache), chunk
> c. dedup agent: write/refcount chunks
> d. replace object with dedup manifest
>
> This could happen with or without a delay.  I don't think it makes sense
> to consider "promote" here at all; it sounds like you're assuming the
> initial dedup tier is a cache tier, and we should try not to assume that
> (even though it might be possible).  Instead, I think a "basic" setup
> would probably be
>
> 1. base pool (all ssd; contains all metadata for all objects, and absorbs
>    writes).
> 2. dedup pool(s) contain refcounted chunks
>
> If we want to do inline dedup, it would be some complex code that combines
> all of the steps above into one, at the expense of client latency.
>
>
> In any case, it's awesome that you have a working prototype.  However,
> it's not going to be practical to take a huge patch(set) like this and
> merge it all at once.  It's too much code to review, too complex, and too
> hard to test.  Also, it's changing 5000 in ReplicatedPG.cc (since renamed
> PrimaryLogPG.cc), which is slated for a big refactor right after luminous.
>
> The way to approach this to get it upstream is to break this down into
> different logical components and design/review/test/merge each of them
> indepdendently.  Having a prototype is useful in that it will be easier to
> answer a lot of the questions we'll have deciding how each part should
> work and what it needs to be able to handle, but don't expect that most
> of that code will end up in the final version!
>
> I'm guessing we can break this down into a few logical components:
>
> 1) How do we store chunks.  We know we want refcounted objects for each
> chunk.  We don't know how we'll manage the refcounts, whether we want/need
> backpointers, whether we are willing to tolerate "leaking" references in
> failure cases (so that we fail to clean up all chunks if we e.g. delete
> all data), whether we want to implement it as a rados class or a native
> rados op, whether we want to support EC, compression, etc.  This whole
> discussion one is a great place to start because it is self-contained and
> doesn't break anything else.
>
> 2) How do we do the dedup manifists (and redirects) in object_info_t.  We
> want the solution to include or be compatible with simpler tiering, like
> having the object_info_t simply be a pointer to a different (colder) pool.
> In fact, I think this is the thing to do first becuase it will make us
> fix/solve all the basic problems with flush and promote.  And extending
> this to include dedup (object is composed of many little bits in other
> pools) is then a matter of making that 'manifest' (or whatever we call it)
> a generic and extensible description.  Remember we also want to support
> pushing objects into external systems (say, glacier, or some other
> external object store like a backup system).
>
> 3) How do we chunk.  You have some classes that handle aligned chunking.
> We'll probably eventually want content-based chunking (based on Rabin
> fingerprinting or whatever the new hotness is).  Real users will probably
> want adjustable policies based on what they know of the content they're
> storing, and the system will probably want to support multiple CAS pools
> based on which policy is being used (as that determines chunk sizes
> etc and whether we'll actually have any dedup happening).
>
> 4) How to drive the dedup process itself.  An async agent that's part of
> the exiting tier_agent?  An external process?  Something inline in the
> write path?  This is the hardest question to answer, and the one that is
> most likely to collide with other planned OSD work.  It can also come
> last, IMO!  We can start with a simple offline agent and perhaps
> eventually do something more clever or efficient.
>
> In any case, I think #1 and #2 are the key discussions we should have now.
> I suggest starting a pad and email thread for each (pad.ceph.com) so we
> can brainstorm design options, weight trade-offs, and come to some
> consensus.  (I had some thoughts, for example, on a hybrid scheme
> somewhere between explicit backpointers and a simple refcount that could
> consume fixed overhead but still provide information that would enable a
> moderately efficient scrub/audit.)
>
> Thanks!
> sage
>
>
>
>
>> Write sequence (writeback mode) is
>>
>> a.  Read object data and do fingerprinting (if data is not calculated).
>> b. Send reference count decrement message (for previous chunk) to osd
>> (in CAS pool) and updates local object metadata
>> c. Send copy_from message to osd (in CAS pool) and send copy_from
>> message (in order to copy the dedup metadata) to a osd (in original
>> pool)
>>
>> Writeback mode also increase the number of operation. Can we reduce?
>>
>>
>>
>> 4. Performance.
>>
>> Performance is improved compared to previous results. But It still
>> seems to be improving. (512KB block, Seq. workload, fio, KRBD, single
>> thread, target_max_objects = 4)
>>
>> Major concerns are first is fingerprint overhead and second is
>> writeback performance in cache tier. When the chunk size is large
>> (>512KB), SHA1 takes more than 3ms. (This can be reduced if we use
>> small chunk.)
>>
>> Regarding writeback performance, Flush need two more operations than
>> proxy mode. First is "marking clean state". Second is "reading dedup
>> metadata and data from storage". Therefore, actual read and write
>> occur. These cause that flush completion is delayed.
>>
>> Small chunk performance in the writeback mode is significantly
>> degraded because single flush thread handles multiple copy_from
>> message. It seems that we should improve basic flushing performance.
>>
>>
>> Write performance (MB/s)
>>
>> Dedup ratio     0         60       100
>>
>> Proxy             55       64       73
>>
>> Writeback       48       50       50
>>
>> Original           120      120      122
>>
>>
>>
>> Read performance (MB/s)
>>
>> Dedup ratio     0         60       100
>>
>> Proxy             117      130      141
>>
>> Writeback       198      197      200
>>
>> Original           280      276      285
>>
>>
>>
>>
>> 5. Command to enable dedup
>>
>> Ceph osd pool create sds-hot 1024
>> Ceph osd pool create sds-cas 1024
>> Ceph osd tier add_cas rbd sds-hot sds-cas
>> Ceph osd tier sds-hot (proxy or writeback)
>> Ceph osd tier dedup_block rbd sds-hot sds-cas (chunk size. e.g. 65536, 131072..)
>> Ceph osd tier set-overlay rbd sds-hot
>>
>>
>>
>> Thanks
>> Myoungwon Oh
>> (omwmw@sk.com)
>>
>> 2017-02-07 23:50 GMT+09:00 Sage Weil <sweil@redhat.com>:
>> > On Tue, 7 Feb 2017, myoungwon oh wrote:
>> >> Hi sage.
>> >>
>> >> I uploaded the document which describe my overall appoach.
>> >> please see it and give me feedback.
>> >> slide: https://www.slideshare.net/secret/JZcy3yYEDIHPyg
>> >
>> > This approach looks pretty close to what we have been planning.  A few
>> > comments:
>> >
>> > 1) I think it may be better to view the tier/pool that has the object
>> > metadata as the "base" pool, and the CAS pool with the refcounted
>> > object chunks as as tier below that.
>> >
>> > 2) I think we can use an object class or a handful of new native rados
>> > operations to make the CAS pool read/write operations more efficient.  In
>> > your slides you describe a process something like
>> >
>> >   rados(getattr)
>> >   if exists
>> >      rados(increment ref count)
>> >   else
>> >      rados(write object and set ref count to 1)
>> >
>> > This could be collapsed into a single optimistic operation that sends the
>> > data and a command that says "create or increment ref count" so that the
>> > conditional behavior is handled at the OSD.  This will be more efficient
>> > for small chunks.  (For large chunks, or in cases where we have some
>> > confidence that the chunk probably already exists, the pessimistic
>> > approach might still make sense.)  Either way, we should probably support
>> > both.
>> >
>> > 3) We'd like to generalize the first pool behavior so that it is just a
>> > special case of the new tiering functionality.  The idea is that an
>> > object_info_t can have a 'manifest' that described where and how the
>> > object is really stored instead of the object data itself (much like it
>> > can already be a whiteout, etc.).  In the simplest case, the manifest
>> > would just say "this object is stored in pool X" (simple tiering).  In
>> > this case, the manifest would a structure like
>> >
>> >   map<offset, tuple<length, cas object, pool>>
>> >
>> > I think it'll be worth the effort to build a general struture here that we
>> > can use for basic tiering (not just dedup).
>> >
>> > sage
>> >
>> >
>> >
>> >>
>> >> thanks
>> >>
>> >>
>> >> 2017-01-31 23:24 GMT+09:00 Sage Weil <sage@newdream.net>:
>> >> > On Thu, 26 Jan 2017, myoungwon oh wrote:
>> >> >> I have two questions.
>> >> >>
>> >> >> 1. I would like to ask about CAS location. current our implementation store
>> >> >> content address object in storage tier.However, If we store the CAO in the
>> >> >> cache tier, we can get a performance advantage. Do you think we can create
>> >> >> CAO in cachetier? or create a separate storage pool for CAS?
>> >> >
>> >> > It depends on the design.  If the you are naming the objects at the
>> >> > librados client side, then you can use the rados cluster itself
>> >> > unmodified (with or without a cache tier).  This is roughly how I have
>> >> > anticipated implementing the CAS storage portion.  If you are doing the
>> >> > chunking hashing and within the OSD itself, then you can't do the CAS
>> >> > at the first tier because the requests won't be directed at the right OSD.
>> >> >
>> >> >> 2. The results below are performance result for our current implementation.
>> >> >> experiment setup:
>> >> >> PROXY (inline dedup), WRITEBACK (lazy dedup, target_max_bytes: 50MB),
>> >> >> ORIGINAL(without dedup feature and cache tier),
>> >> >> fio, 512K block, seq. I/O, single thread
>> >> >>
>> >> >> One thing to note is that the writeback case is slower than the proxy.
>> >> >> We think there are three problems as follows.
>> >> >>
>> >> >> A. The current implementation creates a fingerprint by reading the entire
>> >> >> object when flushing. Therefore, there is a problem that read and write are
>> >> >> mixed.
>> >> >
>> >> > I expect this is a small factor compared to the fact that in writeback
>> >> > mode you have to *write* to the cache tier, which is 3x replicated,
>> >> > whereas in proxy mode those writes don't happen at all.
>> >> >
>> >> >> B. When client request read, the promote_object function reads the object
>> >> >> and writes it back to the cache tier, which also causes a mix of read and
>> >> >> write.
>> >> >
>> >> > This can be mitigated by setting the min_read_recency_for_promote pool
>> >> > property to something >1.  Then reads will be proxied unless the object
>> >> > appears to be hot (because it has been touched over multiple
>> >> > hitset intervals).
>> >> >
>> >> >> C. When flushing, the unchanged part is rewritten because flush operation
>> >> >> perform per-object based.
>> >> >
>> >> > Yes.
>> >> >
>> >> > Is there a description of your overall approach somewhere?
>> >> >
>> >> > sage
>> >> >
>> >> >
>> >> >>
>> >> >> Do I have something wrong? or Could you give me a suggestion to improve
>> >> >> performance?
>> >> >>
>> >> >>
>> >> >> a. Write performance (KB/s)
>> >> >>
>> >> >> dedup_ratio  0 20 40 60 80 100
>> >> >>
>> >> >> PROXY  45586 47804 51120 52844 56167 55302
>> >> >>
>> >> >> WRITEBACK  13151 11078 9531 13010 9518 8319
>> >> >>
>> >> >> ORIGINAL  121209 124786 122140 121195 122540 132363
>> >> >>
>> >> >>
>> >> >> b. Read performance (KB/s)
>> >> >>
>> >> >> dedup_ratio  0 20 40 60 80 100
>> >> >>
>> >> >> PROXY  112231 118994 118070 120071 117884 132748
>> >> >>
>> >> >> WRITEBACK  34040 29109 19104 26677 24756 21695
>> >> >>
>> >> >> ORIGINAL  285482 284398 278063 277989 271793 285094
>> >> >>
>> >> >>
>> >> >> thanks,
>> >> >> Myoungwon Oh
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> >>
>> >> >>
>> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
