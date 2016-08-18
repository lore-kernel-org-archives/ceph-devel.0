From: Haomai Wang <haomai@xsky.com>
Subject: Re: bluestore blobs
Date: Fri, 19 Aug 2016 01:09:00 +0800
Message-ID: <CACJqLyaWydZyWLDF1RofmMcBTyZh=Sofy9dnvrRDwGycwstwhQ@mail.gmail.com>
References: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
 <CACJqLyZeE7zH-TFX_e5N7x1drWheyUQ08SVeeAEYBK=Yau4OkA@mail.gmail.com>
 <alpine.DEB.2.11.1608171522210.17762@piezo.us.to> <CACJqLybeGmFuV9yJtH2i7KiRu6q+6+PsN+xdeFm+Addw0KXTFA@mail.gmail.com>
 <alpine.DEB.2.11.1608171538040.17762@piezo.us.to> <CACJqLyZ_M4KZRxOVy8a58Vz=dj2SHQ5LWUkkkOHt9Q-wRjeJyQ@mail.gmail.com>
 <alpine.DEB.2.11.1608171604100.17762@piezo.us.to> <CACJqLybJ6VMRabC_xFT5NS=+P=YyFn4JOZLXRcs9gvwo0MJ4dg@mail.gmail.com>
 <alpine.DEB.2.11.1608171637190.17762@piezo.us.to> <CACJqLyZ8TcmrNHqczDzP1kFH6pnVB1_1vzgdvUjeyHeTeu1_ew@mail.gmail.com>
 <alpine.DEB.2.11.1608181550450.2394@piezo.us.to> <CACJqLybLDYo+H=yN+yTusdZ9sTerNypa9vHsYE5UBbrxe24rrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0106.outbound.protection.outlook.com ([104.47.93.106]:62816
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754073AbcHSDqO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Aug 2016 23:46:14 -0400
Received: by mail-ua0-f181.google.com with SMTP id k90so38679857uak.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Aug 2016 10:09:08 -0700 (PDT)
In-Reply-To: <CACJqLybLDYo+H=yN+yTusdZ9sTerNypa9vHsYE5UBbrxe24rrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Varada Kari <varada.kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 19, 2016 at 12:53 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Thu, Aug 18, 2016 at 11:53 PM, Sage Weil <sweil@redhat.com> wrote:
>> On Thu, 18 Aug 2016, Haomai Wang wrote:
>>> This is my perf program https://github.com/yuyuyu101/ceph/tree/wip-wal
>>
>> Looks right...
>>
>>> It mainly simulate WAL workload and compare rocksdb wal to filejournal
>>> Summary:
>>>
>>>
>>> iodepth 1 4096 payload:
>>> filejournal: 160 us
>>> rocksdb: 3300 us
>>>
>>> iodepth 1 2048 payload:
>>> filejournal: 180us
>>> rocksdb: 3000 us
>>>
>>> iodepth 1 5124 payload:
>>> filejournal: 240us
>>> rocksdb: 3200us
>>>
>>> iodepth 16 4096 payload:
>>> filejournal: 550us
>>> rocksdb: 27000us
>>>
>>> iodepth 16 5124 payload:
>>> fiejournal: 580us
>>> rocksdb: 27100us
>>>
>>> I'm not sure, do we observe outstanding op latency in bluestore
>>> compare to filestore?
>>>
>>> From my logs, it shows BlueFS::_fsync occur 1/2 latency which contains
>>> two aio_write and two aio_wait(data and metadata).
>>
>> Note that this will change once rocksdb warms up and starts recycling
>> existing log files.  You can force this by writing a few 10s of MB
>> of keys.  After that it will be one aio_write, aio_wait, and flush.
>>
>> Even so, the numbers don't look very good.  Want to repeat with the
>> preconditioning?
>
> OH, I forget about this....
>
> To be simply, I add "if (0 && old_dirty_seq)" to disable metadata update.
>
> It's amazing.... Now iodepth 1 cases all better than filejournal
> because of shorter path(filejournal has three threads to handle one
> io).
>
> iodepth 16 shows filejournal 3x better than rocksdb which is expected...
>
> I'm not sure why disable _flush_and_sync_log can benefit so much. And
> why it will cause another 1ms missing....

Oh, I know another 1ms from. rocksdb will flush log and call fsync. So
there will be _flush(false) and _fsync..... Looks good enough!

>
>>
>>> And I also found DBImpl::WriteImpl prevents multi sync writes via
>>> "log.getting_synced" flag, so multi rocksdb writers may not make
>>> sense.
>>
>> Hrm, yeah.
>>
>> sage
>>
>>
>>> I don't find another 1/2 latency now. Is my test program missing
>>> something or have a wrong mock for WAL behavior?
>>>
>>> On Thu, Aug 18, 2016 at 12:42 AM, Sage Weil <sweil@redhat.com> wrote:
>>> > On Thu, 18 Aug 2016, Haomai Wang wrote:
>>> >> On Thu, Aug 18, 2016 at 12:10 AM, Sage Weil <sweil@redhat.com> wrote:
>>> >> > On Thu, 18 Aug 2016, Haomai Wang wrote:
>>> >> >> On Wed, Aug 17, 2016 at 11:43 PM, Sage Weil <sweil@redhat.com> wrote:
>>> >> >> > On Wed, 17 Aug 2016, Haomai Wang wrote:
>>> >> >> >> On Wed, Aug 17, 2016 at 11:25 PM, Sage Weil <sweil@redhat.com> wrote:
>>> >> >> >> > On Wed, 17 Aug 2016, Haomai Wang wrote:
>>> >> >> >> >> another latency perf problem:
>>> >> >> >> >>
>>> >> >> >> >> rocksdb log is on bluefs and mainly uses append and fsync interface to
>>> >> >> >> >> complete WAL.
>>> >> >> >> >>
>>> >> >> >> >> I found the latency between kv transaction submitting isn't negligible
>>> >> >> >> >> and limit the transaction throughput.
>>> >> >> >> >>
>>> >> >> >> >> So what if we implement a async transaction submit in rocksdb side
>>> >> >> >> >> using callback way? It will decrease kv in queue latency. It would
>>> >> >> >> >> help rocksdb WAL performance close to FileJournal. And async interface
>>> >> >> >> >> will help control each kv transaction size and make transaction
>>> >> >> >> >> complete smoothly instead of tps spike with us precious.
>>> >> >> >> >
>>> >> >> >> > Can we get the same benefit by calling BlueFS::_flush on the log whenever
>>> >> >> >> > we have X bytes accumulated (I think there is an option in rocksdb that
>>> >> >> >> > drives this already, actually)?  Changing the interfaces around will
>>> >> >> >> > change the threading model (= work) but doesn't actually change who needs
>>> >> >> >> > to wait and when.
>>> >> >> >>
>>> >> >> >> why we need to wait after interface change?
>>> >> >> >>
>>> >> >> >> 1. kv thread submit transaction with callback.
>>> >> >> >> 2. rocksdb append and call bluefs aio_submit with callback
>>> >> >> >> 3. bluefs submit aio write with callback
>>> >> >> >> 4. KernelDevice will poll linux aio event and execute callback inline
>>> >> >> >> or queue finish
>>> >> >> >> 5. callback will notify we complete the kv transaction
>>> >> >> >>
>>> >> >> >> the main task is implement logics in rocksdb log*.cc and bluefs aio
>>> >> >> >> submit interface....
>>> >> >> >>
>>> >> >> >> Is anything I'm missing?
>>> >> >> >
>>> >> >> > That can all be done with callbacks, but even if we do the kv thread will
>>> >> >> > still need to wait on the callback before doing anything else.
>>> >> >> >
>>> >> >> > Oh, you're suggesting we have multiple batches of transactions in flight.
>>> >> >> > Got it.
>>> >> >>
>>> >> >> I don't think so.. because bluefs has lock for fsync and flush. So
>>> >> >> multi rocksdb thread will be serial to flush...
>>> >> >
>>> >> > Oh, this was fixed recently:
>>> >> >
>>> >> >         10d055d65727e47deae4e459bc21aaa243c24a7d
>>> >> >         97699334acd59e9530d36b13d3a8408cabf848ef
>>> >>
>>> >> Hmm, looks better!
>>> >>
>>> >> The only thing is I notice we don't have FileWriter lock for "buffer",
>>> >> so multi rocksdb writer will result in corrupt? I haven't look at
>>> >> rocksdb to check, but I think if posix backend, rocksdb don't need to
>>> >> have a look to protect log append racing.
>>> >
>>> > Hmm, there is this option:
>>> >
>>> >         https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueRocksEnv.cc#L224
>>> >
>>> > but that doesn't say anything about more than one concurrent Append.
>>> > You're probably right and we need some extra locking here...
>>> >
>>> > sage
>>> >
>>> >
>>> >
>>> >>
>>> >> >
>>> >> >> and another thing is the single thread is help for polling case.....
>>> >> >> from my current perf, compared queue filejournal class, rocksdb plays
>>> >> >> 1.5x-2x latency, in heavy load it will be more .... Yes, filejournal
>>> >> >> exactly has a good pipeline for pure linux aio job.
>>> >> >
>>> >> > Yeah, I think you're right.  Even if we do the parallel submission, we
>>> >> > don't want to do parallel blocking (since the callers don't want to
>>> >> > block), so we'll still want async completion/notification of commit.
>>> >> >
>>> >> > No idea if this is something the rocksdb folks are already interested in
>>> >> > or not... want to ask them on their cool facebook group?  :)
>>> >> >
>>> >> >         https://www.facebook.com/groups/rocksdb.dev/
>>> >>
>>> >> sure
>>> >>
>>> >> >
>>> >> > sage
>>> >> >
>>> >> >
>>> >> >>
>>> >> >> >
>>> >> >> > I think we will get some of the benefit by enabling the parallel
>>> >> >> > transaction submits (so we don't funnel everything through
>>> >> >> > _kv_sync_thread).  I think we should get that merged first and see how it
>>> >> >> > behaves before taking the next step.  I forgot to ask Varada is standup
>>> >> >> > this morning what the current status of that is.  Varada?
>>> >> >> >
>>> >> >> > sage
>>> >> >> >
>>> >> >> >>
>>> >> >> >> >
>>> >> >> >> > sage
>>> >> >> >> >
>>> >> >> >> >
>>> >> >> >> >
>>> >> >> >> >>
>>> >> >> >> >>
>>> >> >> >> >> On Wed, Aug 17, 2016 at 10:26 PM, Sage Weil <sweil@redhat.com> wrote:
>>> >> >> >> >> > I think we need to look at other changes in addition to the encoding
>>> >> >> >> >> > performance improvements.  Even if they end up being good enough, these
>>> >> >> >> >> > changes are somewhat orthogonal and at least one of them should give us
>>> >> >> >> >> > something that is even faster.
>>> >> >> >> >> >
>>> >> >> >> >> > 1. I mentioned this before, but we should keep the encoding
>>> >> >> >> >> > bluestore_blob_t around when we load the blob map.  If it's not changed,
>>> >> >> >> >> > don't reencode it.  There are no blockers for implementing this currently.
>>> >> >> >> >> > It may be difficult to ensure the blobs are properly marked dirty... I'll
>>> >> >> >> >> > see if we can use proper accessors for the blob to enforce this at compile
>>> >> >> >> >> > time.  We should do that anyway.
>>> >> >> >> >> >
>>> >> >> >> >> > 2. This turns the blob Put into rocksdb into two memcpy stages: one to
>>> >> >> >> >> > assemble the bufferlist (lots of bufferptrs to each untouched blob)
>>> >> >> >> >> > into a single rocksdb::Slice, and another memcpy somewhere inside
>>> >> >> >> >> > rocksdb to copy this into the write buffer.  We could extend the
>>> >> >> >> >> > rocksdb interface to take an iovec so that the first memcpy isn't needed
>>> >> >> >> >> > (and rocksdb will instead iterate over our buffers and copy them directly
>>> >> >> >> >> > into its write buffer).  This is probably a pretty small piece of the
>>> >> >> >> >> > overall time... should verify with a profiler before investing too much
>>> >> >> >> >> > effort here.
>>> >> >> >> >> >
>>> >> >> >> >> > 3. Even if we do the above, we're still setting a big (~4k or more?) key
>>> >> >> >> >> > into rocksdb every time we touch an object, even when a tiny amount of
>>> >> >> >> >> > metadata is getting changed.  This is a consequence of embedding all of
>>> >> >> >> >> > the blobs into the onode (or bnode).  That seemed like a good idea early
>>> >> >> >> >> > on when they were tiny (i.e., just an extent), but now I'm not so sure.  I
>>> >> >> >> >> > see a couple of different options:
>>> >> >> >> >> >
>>> >> >> >> >> > a) Store each blob as ($onode_key+$blobid).  When we load the onode, load
>>> >> >> >> >> > the blobs too.  They will hopefully be sequential in rocksdb (or
>>> >> >> >> >> > definitely sequential in zs).  Probably go back to using an iterator.
>>> >> >> >> >> >
>>> >> >> >> >> > b) Go all in on the "bnode" like concept.  Assign blob ids so that they
>>> >> >> >> >> > are unique for any given hash value.  Then store the blobs as
>>> >> >> >> >> > $shard.$poolid.$hash.$blobid (i.e., where the bnode is now).  Then when
>>> >> >> >> >> > clone happens there is no onode->bnode migration magic happening--we've
>>> >> >> >> >> > already committed to storing blobs in separate keys.  When we load the
>>> >> >> >> >> > onode, keep the conditional bnode loading we already have.. but when the
>>> >> >> >> >> > bnode is loaded load up all the blobs for the hash key.  (Okay, we could
>>> >> >> >> >> > fault in blobs individually, but that code will be more complicated.)
>>> >> >> >> >> >
>>> >> >> >> >> > In both these cases, a write will dirty the onode (which is back to being
>>> >> >> >> >> > pretty small.. just xattrs and the lextent map) and 1-3 blobs (also now
>>> >> >> >> >> > small keys).  Updates will generate much lower metadata write traffic,
>>> >> >> >> >> > which'll reduce media wear and compaction overhead.  The cost is that
>>> >> >> >> >> > operations (e.g., reads) that have to fault in an onode are now fetching
>>> >> >> >> >> > several nearby keys instead of a single key.
>>> >> >> >> >> >
>>> >> >> >> >> >
>>> >> >> >> >> > #1 and #2 are completely orthogonal to any encoding efficiency
>>> >> >> >> >> > improvements we make.  And #1 is simple... I plan to implement this
>>> >> >> >> >> > shortly.
>>> >> >> >> >> >
>>> >> >> >> >> > #3 is balancing (re)encoding efficiency against the cost of separate keys,
>>> >> >> >> >> > and that tradeoff will change as encoding efficiency changes, so it'll be
>>> >> >> >> >> > difficult to properly evaluate without knowing where we'll land with the
>>> >> >> >> >> > (re)encode times.  I think it's a design decision made early on that is
>>> >> >> >> >> > worth revisiting, though!
>>> >> >> >> >> >
>>> >> >> >> >> > sage
>>> >> >> >> >> > --
>>> >> >> >> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> >> >> >> >> > the body of a message to majordomo@vger.kernel.org
>>> >> >> >> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >> >> >> >> --
>>> >> >> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> >> >> >> >> the body of a message to majordomo@vger.kernel.org
>>> >> >> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >> >> >> >>
>>> >> >> >> >>
>>> >> >> >>
>>> >> >> >>
>>> >> >> --
>>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> >> >> the body of a message to majordomo@vger.kernel.org
>>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >> >>
>>> >> >>
>>> >>
>>> >>
>>>
>>>
