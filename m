From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: K/V store optimization
Date: Wed, 6 May 2015 12:59:47 +0800
Message-ID: <CACJqLybKJRP9bKbZ3TeOmKxbasBXpARuh5AifYDC1iP8QOMczw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84052@SACMBXIP01.sdcorp.global.sandisk.com>
	<CACJqLybYKSKmwNtvTpRKDk-Hu47NrL7DJ23UaGTC8+cZoOyhzg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84086@SACMBXIP01.sdcorp.global.sandisk.com>
	<CACJqLyZ74xR_nBcKHUPieanCvfHzFw4ELRDn4oc_b9Cusm05Jw@mail.gmail.com>
	<CACJqLyYMCKA2eZRQ2_J4uyGhGGzO4WBeWvrs-S2y769YU1BnDg@mail.gmail.com>
	<C226B0AB34511445928D9882AA519F601C3F7069@SACMBXIP03.sdcorp.global.sandisk.com>
	<CACJqLyZMfT8Kns57kNBx20zd=N7xDCZkSZCzQXCg7=0TkfcQnA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8431B@SACMBXIP01.sdcorp.global.sandisk.com>
	<C226B0AB34511445928D9882AA519F601C3F755F@SACMBXIP03.sdcorp.global.sandisk.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84485@SACMBXIP01.sdcorp.global.sandisk.com>
	<CACJqLyavrxt1EiPqYN=4R9JW1tdbZQGE7AL64275YxgFouOpuA@mail.gmail.com>
	<6F3FA899187F0043BA1827A69DA2F7CC021EC488@shsmsx102.ccr.corp.intel.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD86BE5@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33298 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbEFE7s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 00:59:48 -0400
Received: by pdbnk13 with SMTP id nk13so219308437pdb.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 21:59:47 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD86BE5@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Varada Kari <Varada.Kari@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Agreed, I think kvstore is aimed to provided with a lightweight
objectstore interface to kv interface translation. The extra "bits"
field maintain is a load for powerful keyvaluedb backend. We need to
consider fully rely to backend implementation and trust it.

On Wed, May 6, 2015 at 3:39 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Xiaoxi,
> Thanks for your input.
> I guess If the db you are planning to integrate is not having an efficient iterator or range query implementation, performance could go wrong in many parts of present k/v store itself.
> If you are saying leveldb/rocksdb range query/iterator implementation of reading 10 keys at once is less efficient than reading 10 keys separately by 10 Gets (I doubt so!) , yes, this may degrade performance in the scheme I mentioned. But, this is really an inefficiency in the DB and nothing in the interface, isn't it ? Yes, we can implement this kind of optimization in the shim layer (deriving from kvdb) or writing a backend deriving from objectstore all together, but I don't think that's the goal. K/V Store layer writing an extra header of ~200 bytes for every transaction will not help in any cases. IMHO, we should be implementing K/Vstore layer keeping in mind what an efficient k/v db can provide value to it and not worrying about how a bad db implementation would suffer.
> Regarding db merge, I don't think it is a good idea to rely on that (again this is db specific) specially when we can get rid of this extra writes probably giving away some RA in some of the db implementation.
>
> Regards
> Somnath
>
>
> -----Original Message-----
> From: Chen, Xiaoxi [mailto:xiaoxi.chen@intel.com]
> Sent: Tuesday, May 05, 2015 2:15 AM
> To: Haomai Wang; Somnath Roy
> Cc: Varada Kari; ceph-devel
> Subject: RE: K/V store optimization
>
> Hi Somnath
> I think we have several questions here, for different DB backend ,the answer might be different, that will be hard for us to implement a general good KVStore interface...
>
> 1.  Whether the DB support range query (i.e cost of read key (1~ 10) << 10* readkey(some key)).
>             This is really different case by case, in LevelDB/RocksDB, the iterator->next() is not that cheap if the two keys are not in a same level, this might happen if one key is updated after another.
> 2.  Will DB merge the small (< page size) updated into big one?
>             This is true in RocksDB/LevelDB since multiple writes will be written to WAL log at the same time(if sync=false), not to mention if the data be flush to Level0 + , So in RocksDB case, the WA inside SSD caused by partial page update is not that big as you estimated.
>
> 3. What's the typical #RA and #WA of the DB, and how they vary vs total data size
>             In Level design DB #RA and #WA is usually a tuning tradeoff...also for LMDB that tradeoff #WA to achieve very small #RA.
>             RocksDB/LevelDB #WA surge up quickly with total data size, but if use the design of NVMKV, that should be different.
>
>
> Also there are some variety in SSD, some new SSDs which will probably appear this year that has very small page size ( < 100 B)... So I suspect if you really want a ultilize the backend KV library run ontop of some special SSD, just inherit from ObjectStore might be a better choice....
>
>                                                                                                         Xiaoxi
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Haomai Wang
>> Sent: Tuesday, May 5, 2015 12:29 PM
>> To: Somnath Roy
>> Cc: Varada Kari; ceph-devel
>> Subject: Re: K/V store optimization
>>
>> On Sat, May 2, 2015 at 1:50 PM, Somnath Roy <Somnath.Roy@sandisk.com>
>> wrote:
>> > Varada,
>> > <<inline
>> >
>> > Thanks & Regards
>> > Somnath
>> >
>> > -----Original Message-----
>> > From: Varada Kari
>> > Sent: Friday, May 01, 2015 8:16 PM
>> > To: Somnath Roy; Haomai Wang
>> > Cc: ceph-devel
>> > Subject: RE: K/V store optimization
>> >
>> > Somnath,
>> >
>> > One thing to note here, we can't get all the keys in one read from
>> > leveldb
>> or rocksdb. Need to get an iterator and get all the keys desired which
>> is the implementation we have now. Though, if the backend supports
>> batch read functionality with given header/prefix your implementation
>> might solve the problem.
>> >
>> > One limitation in your case is as mentioned by Haomi, once the whole
>> > 4MB
>> object is populated if any overwrite comes to any stripe, we will have
>> to read
>> 1024 strip keys(in worst case, assuming 4k strip size) or to the strip
>> at least to check whether the strip is populated or not, and read the
>> value to satisfy the overwrite.  This would involving more reads than desired.
>> > ----------------------------
>> > [Somnath] That's what I was trying to convey in my earlier mail, we
>> > will not
>> be having extra reads ! Let me try to explain it again.
>> > If a strip is not been written, there will not be any key/value
>> > object written
>> to the back-end, right ?
>> > Now, you start say an iterator with lower_bound for the prefix say
>> _SEQ_0000000000039468_STRIP_ and call next() till it is not valid. So,
>> in case of 1024 strips and 10 valid strips, it should only be reading
>> and returning 10 k/v pair, isn't it ? With this 10 k/v pairs out of
>> 1024, we can easily form the extent bitmap.
>> > Now, say you have the bitmap and you already know the key of 10
>> > valid
>> extents, you will do the similar stuff . For example, in the
>> GenericObjectMap::scan(), you are calling lower_bound with exact key
>> (combine_string under say Rocksdbstore::lower_bound is forming exact
>> key) and again matching the key under ::scan() ! ...Basically, we are
>> misusing iterator based interface here, we could have called the direct db::get().
>>
>> Hmm, whether implementing bitmap on object or offloading it to backend
>> is a tradeoff. We got fast path from bitmap and increase write
>> amplification(maybe we can reduce for it). For now, I don't have
>> compellent reason for each one. Maybe we can have a try.:-)
>>
>> >
>> > So, where is the extra read ?
>> > Let me know if I am missing anything .
>> > -------------------------------
>> > Another way to avoid header would be have offset and length
>> > information
>> in key itself.  We can have the offset and length covered in the strip
>> as a part of the key prefixed by the cid+oid. This way we can support
>> variable length extent. Additional changes would be involving to match
>> offset and length we need to read from key. With this approach we can
>> avoid the header and write the striped object to backend.  Haven't
>> completely looked the problems of clones and snapshots in this, but we
>> can work them out seamlessly once we know the range we want to clone.
>> Haomi any comments on this approach?
>> >
>> > [Somnath] How are you solving the valid extent problem here for the
>> partial read/write case ? What do you mean by variable length extent BTW ?
>> >
>> > Varada
>> >
>> > -----Original Message-----
>> > From: Somnath Roy
>> > Sent: Saturday, May 02, 2015 12:35 AM
>> > To: Haomai Wang; Varada Kari
>> > Cc: ceph-devel
>> > Subject: RE: K/V store optimization
>> >
>> > Varada/Haomai,
>> > I thought about that earlier , but, the WA induced by that also is
>> > *not
>> negligible*. Here is an example. Say we have 512 TB of storage and we
>> have 4MB rados object size. So, total objects = 512 TB/4MB =
>> 134217728. Now, if 4K is stripe size , every 4MB object will induce
>> max 4MB/4K = 1024 header writes. So, total of 137438953472 header
>> writes. Each header size is ~200 bytes but it will generate flash page
>> size amount of writes (generally 4K/8K/16K). Considering min 4K , it
>> will overall generate ~512 TB of extra writes in worst case :-) I
>> didn't consider what if in between truncate comes and disrupt the header bitmap. This will cause more header writes.
>> > So, we *can't* go in this path.
>> > Now, Haomai, I don't understand why there will be extra reads in the
>> proposal I gave. Let's consider some use cases.
>> >
>> > 1. 4MB object size and 64K stripe size, so, total of 64 stripes and
>> > 64 entries
>> in the header bitmap. Out of that say only 10 stripes are valid. Now,
>> read request came for the entire 4MB objects, we determined the number
>> of extents to be read = 64, but don't know valid extents. So, send out
>> a range query with _SEQ_0000000000038361_STRIP_* and backend like
>> leveldb/rocksdb will only send out valid 10 extents to us. Rather what
>> we are doing now, we are consulting bit map and sending specific 10
>> keys for read which is *inefficient* than sending a range query. If we
>> are thinking there will be cycles spent for reading invalid objects,
>> it is not true as leveldb/rocksdb maintains a bloom filter for a valid keys and it is in-memory.
>> This is not costly for btree based keyvalue db as well.
>> >
>> > 2. Nothing is different for write as well, with the above way we
>> > will end up
>> reading same amount of data.
>> >
>> > Let me know if I am missing anything.
>> >
>> > Thanks & Regards
>> > Somnath
>> >
>> > -----Original Message-----
>> > From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> > Sent: Friday, May 01, 2015 9:02 AM
>> > To: Varada Kari
>> > Cc: Somnath Roy; ceph-devel
>> > Subject: Re: K/V store optimization
>> >
>> > On Fri, May 1, 2015 at 11:55 PM, Varada Kari
>> > <Varada.Kari@sandisk.com>
>> wrote:
>> >> Hi Haomi,
>> >>
>> >> Actually we don't need to update the header for all the writes, we
>> >> need
>> to update when any header fields gets updated. But we are making
>> header-
>> >updated to true unconditionally in _generic_write(), which is making
>> >the
>> write of header object for all the strip write even for a overwrite,
>> which we can eliminate by updating the header->updated accordingly. If
>> you observe we never make the header->updated false anywhere. We need
>> to make it false once we write the header.
>> >>
>> >> In worst case, we need to update the header till all the strips
>> >> gets
>> populated and when any clone/snapshot is created.
>> >>
>> >> I have fixed these issues, will be sending a PR soon once my unit
>> >> testing
>> completes.
>> >
>> > Great! From Somnath's statements, I just think it may something
>> > wrong
>> with "updated" field. It would be nice to catch this.
>> >
>> >>
>> >> Varada
>> >>
>> >> -----Original Message-----
>> >> From: ceph-devel-owner@vger.kernel.org
>> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
>> >> Sent: Friday, May 01, 2015 5:53 PM
>> >> To: Somnath Roy
>> >> Cc: ceph-devel
>> >> Subject: Re: K/V store optimization
>> >>
>> >> On Fri, May 1, 2015 at 2:57 PM, Haomai Wang <haomaiwang@gmail.com>
>> wrote:
>> >>> On Fri, May 1, 2015 at 2:37 PM, Somnath Roy
>> <Somnath.Roy@sandisk.com> wrote:
>> >>>> Thanks Haomai !
>> >>>> Response inline..
>> >>>>
>> >>>> Regards
>> >>>> Somnath
>> >>>>
>> >>>> -----Original Message-----
>> >>>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> >>>> Sent: Thursday, April 30, 2015 10:49 PM
>> >>>> To: Somnath Roy
>> >>>> Cc: ceph-devel
>> >>>> Subject: Re: K/V store optimization
>> >>>>
>> >>>> On Fri, May 1, 2015 at 12:55 PM, Somnath Roy
>> <Somnath.Roy@sandisk.com> wrote:
>> >>>>> Hi Haomai,
>> >>>>> I was doing some investigation with K/V store and IMO we can do
>> >>>>> the
>> following optimization on that.
>> >>>>>
>> >>>>> 1. On every write KeyValueStore is writing one extra small
>> >>>>> attribute
>> with prefix _GHOBJTOSEQ* which is storing the header information. This
>> extra write will hurt us badly in case flash WA. I was thinking if we
>> can get rid of this in the following way.
>> >>>>>
>> >>>>>       Seems like persisting headers during creation time should
>> >>>>> be
>> sufficient. The reason is the following..
>> >>>>>        a. The header->seq for generating prefix will be written
>> >>>>> only when
>> header is generated. So, if we want to use the _SEQ * as prefix, we
>> can read the header and use it during write.
>> >>>>>        b. I think we don't need the stripe bitmap/header-
>> >max_len/stripe_size as well. The bitmap is required to determine the
>> already written extents for a write. Now, any K/V db supporting range
>> queries (any popular db does), we can always send down
>> >>>>>            range query with prefix say
>> >>>>> _SEQ_0000000000039468_STRIP_
>> and it should return the valid extents. No extra reads here since
>> anyway we need to read those extents in read/write path.
>> >>>>>
>> >>>>
>> >>>> From my mind, I think normal IO won't always write header! If you
>> notice lots of header written, maybe some cases wrong and need to fix.
>> >>>>
>> >>>> We have a "updated" field to indicator whether we need to write
>> ghobject_t header for each transaction. Only  "max_size" and "bits"
>> >>>> changed will set "update=true", if we write warm data I don't we
>> >>>> will
>> write header again.
>> >>>>
>> >>>> Hmm, maybe "bits" will be changed often so it will write the
>> >>>> whole
>> header again when doing fresh writing. I think a feasible way is
>> separate "bits" from header. The size of "bits" usually is 512-1024(or
>> more for larger
>> object) bytes, I think if we face baremetal ssd or any backend
>> passthrough localfs/scsi, we can split bits to several fixed size
>> keys. If so we can avoid most of header write.
>> >>>>
>> >>>> [Somnath] Yes, because of bitmap update, it is rewriting header
>> >>>> on
>> each transaction. I don't think separating bits from header will help
>> much as any small write will induce flash logical page size amount
>> write for most of the dbs unless they are doing some optimization internally.
>> >>
>> >> I just think we may could think metadata update especially "bits"
>> >> as
>> journal. So if we have a submit_transaction which will together all "bits"
>> update to a request and flush to a formate key named like
>> "bits-journal- [seq]". We could actually writeback inplace header very
>> late. It could help I think.
>> >>
>> >>>
>> >>> Yeah, but we can't get rid of it if we want to implement a simple
>> >>> logic mapper in keyvaluestore layer. Otherwise, we need to read
>> >>> all keys go down to the backend.
>> >>>
>> >>>>>
>> >>>>> 2. I was thinking not to read this GHobject at all during read/write path.
>> For that, we need to get rid of the SEQ stuff and calculate the object
>> keys on the fly. We can uniquely form the GHObject keys and add that
>> as prefix to attributes like this.
>> >>>>>
>> >>>>>
>> _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e00
>> 0000000000c18a!head     -----> for header (will be created one time)
>> >>>>>
>> >>>>>
>> _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e00
>> 0000
>> >>>>> 0
>> >>>>> 0
>> >>>>> 00 00c18a!head __OBJOMAP * -> for all omap attributes
>> >>>>>
>> >>>>>
>> _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e00
>> 0000000000c18a!head__OBJATTR__*  -> for all attrs
>> >>>>>
>> _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e00
>> 0000000000c18a!head__STRIP_<stripe-no> -> for all strips.
>> >>>>>
>> >>>>>  Also, keeping the similar prefix to all the keys for an object
>> >>>>> will be
>> helping k/v dbs in general as lot of dbs do optimization based on
>> similar key prefix.
>> >>>>
>> >>>> We can't get rid of header look I think, because we need to check
>> >>>> this
>> object is existed and this is required by ObjectStore semantic. Do you
>> think this will be bottleneck for read/write path? From my view, if I
>> increase keyvaluestore_header_cache_size to very large number like
>> 102400, almost of header should be cached inmemory. KeyValueStore uses
>> RandomCache to store header cache, it should be cheaper. And header in
>> KeyValueStore is alike "file descriptor" in local fs, a large header
>> cache size is encouraged since "header" is  lightweight compared to inode.
>> >>>>
>> >>>> [Somnath] Nope, so far I am not seeing this as a bottleneck, but
>> thinking if we can get rid of extra read always..In our case one OSD
>> will serve ~8TB of storage, so, to cache all these headers in memory
>> we need ~420MB (considering default 4MB rados object size and header
>> size is ~200bytes), which is kind of big. So, I think there will be some disk read always.
>> >>>> I think just querying the particular object should reveal whether
>> >>>> object
>> exists or not. Not sure if we need to verify headers always in the io
>> path to determine if object exists or not. I know in case of omap it
>> is implemented like that, but, I don't know what benefit we are getting by doing that.
>> >>>>
>> >>>>>
>> >>>>> 3. We can aggregate the small writes in the buffer transaction
>> >>>>> and
>> issue one single key/value write to the dbs. If dbs are already doing
>> small write aggregation , this won't help much though.
>> >>>>
>> >>>> Yes, it could be done just like NewStore did! So keyvaluestore's
>> >>>> process
>> flaw will be this:
>> >>>>
>> >>>> several pg threads: queue_transaction
>> >>>>               |
>> >>>>               |
>> >>>> several keyvaluestore op threads: do_transaction
>> >>>>               |
>> >>>> keyvaluestore submit thread: call db->submit_transaction_sync
>> >>>>
>> >>>> So the bandwidth should be better.
>> >>>>
>> >>>> Another optimization point is reducing lock granularity to
>> >>>> object-
>> level(currently is pg level), I think if we use a separtor submit
>> thread it will helpful because multi transaction in one pg will be queued in ordering.
>> >>>> [Somnath] Yeah..That I raised earlier, but, it seems quite a few
>> >>>> impact
>> for that. But, it worth trying..May be need to discuss with Sage/Sam.
>> >>>
>> >>> Cool!
>> >>>
>> >>>>
>> >>>>
>> >>>>>
>> >>>>> Please share your thought around this.
>> >>>>>
>> >>>>
>> >>>> I always rethink to improve keyvaluestore performance, but I
>> >>>> don't
>> have a good backend still now. A ssd vendor who can provide with FTL
>> interface would be great I think, so we can offload lots of things to FTL layer.
>> >>>>
>> >>>>> Thanks & Regards
>> >>>>> Somnath
>> >>>>>
>> >>>>>
>> >>>>>
>> >>>>>
>> >>>>> ________________________________
>> >>>>>
>> >>>>> PLEASE NOTE: The information contained in this electronic mail
>> message is intended only for the use of the designated recipient(s)
>> named above. If the reader of this message is not the intended
>> recipient, you are hereby notified that you have received this message
>> in error and that any review, dissemination, distribution, or copying
>> of this message is strictly prohibited. If you have received this
>> communication in error, please notify the sender by telephone or
>> e-mail (as shown above) immediately and destroy any and all copies of
>> this message in your possession (whether hard copies or electronically stored copies).
>> >>>>>
>> >>>>> --
>> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> >>>>> in the body of a message to majordomo@vger.kernel.org More
>> >>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>>
>> >>>>
>> >>>>
>> >>>> --
>> >>>> Best Regards,
>> >>>>
>> >>>> Wheat
>> >>>
>> >>>
>> >>>
>> >>> --
>> >>> Best Regards,
>> >>>
>> >>> Wheat
>> >>
>> >>
>> >>
>> >> --
>> >> Best Regards,
>> >>
>> >> Wheat
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> >> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> >> info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>> >
>> > --
>> > Best Regards,
>> >
>> > Wheat
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Best Regards,

Wheat
