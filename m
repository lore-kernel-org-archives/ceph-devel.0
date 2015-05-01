From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: K/V store optimization
Date: Fri, 1 May 2015 14:57:06 +0800
Message-ID: <CACJqLyZ74xR_nBcKHUPieanCvfHzFw4ELRDn4oc_b9Cusm05Jw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84052@SACMBXIP01.sdcorp.global.sandisk.com>
	<CACJqLybYKSKmwNtvTpRKDk-Hu47NrL7DJ23UaGTC8+cZoOyhzg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84086@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34758 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbEAG5H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 May 2015 02:57:07 -0400
Received: by pdbqa5 with SMTP id qa5so84615234pdb.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 23:57:06 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84086@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 1, 2015 at 2:37 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Thanks Haomai !
> Response inline..
>
> Regards
> Somnath
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Thursday, April 30, 2015 10:49 PM
> To: Somnath Roy
> Cc: ceph-devel
> Subject: Re: K/V store optimization
>
> On Fri, May 1, 2015 at 12:55 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Hi Haomai,
>> I was doing some investigation with K/V store and IMO we can do the following optimization on that.
>>
>> 1. On every write KeyValueStore is writing one extra small attribute with prefix _GHOBJTOSEQ* which is storing the header information. This extra write will hurt us badly in case flash WA. I was thinking if we can get rid of this in the following way.
>>
>>       Seems like persisting headers during creation time should be sufficient. The reason is the following..
>>        a. The header->seq for generating prefix will be written only when header is generated. So, if we want to use the _SEQ * as prefix, we can read the header and use it during write.
>>        b. I think we don't need the stripe bitmap/header->max_len/stripe_size as well. The bitmap is required to determine the already written extents for a write. Now, any K/V db supporting range queries (any popular db does), we can always send down
>>            range query with prefix say _SEQ_0000000000039468_STRIP_ and it should return the valid extents. No extra reads here since anyway we need to read those extents in read/write path.
>>
>
> From my mind, I think normal IO won't always write header! If you notice lots of header written, maybe some cases wrong and need to fix.
>
> We have a "updated" field to indicator whether we need to write ghobject_t header for each transaction. Only  "max_size" and "bits"
> changed will set "update=true", if we write warm data I don't we will write header again.
>
> Hmm, maybe "bits" will be changed often so it will write the whole header again when doing fresh writing. I think a feasible way is separate "bits" from header. The size of "bits" usually is 512-1024(or more for larger object) bytes, I think if we face baremetal ssd or any backend passthrough localfs/scsi, we can split bits to several fixed size keys. If so we can avoid most of header write.
>
> [Somnath] Yes, because of bitmap update, it is rewriting header on each transaction. I don't think separating bits from header will help much as any small write will induce flash logical page size amount write for most of the dbs unless they are doing some optimization internally.

Yeah, but we can't get rid of it if we want to implement a simple
logic mapper in keyvaluestore layer. Otherwise, we need to read all
keys go down to the backend.

>>
>> 2. I was thinking not to read this GHobject at all during read/write path. For that, we need to get rid of the SEQ stuff and calculate the object keys on the fly. We can uniquely form the GHObject keys and add that as prefix to attributes like this.
>>
>>                 _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head     -----> for header (will be created one time)
>>
>> _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e0000000000
>> 00c18a!head __OBJOMAP * -> for all omap attributes
>>
>>         _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head__OBJATTR__*  -> for all attrs
>>         _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head__STRIP_<stripe-no> -> for all strips.
>>
>>  Also, keeping the similar prefix to all the keys for an object will be helping k/v dbs in general as lot of dbs do optimization based on similar key prefix.
>
> We can't get rid of header look I think, because we need to check this object is existed and this is required by ObjectStore semantic. Do you think this will be bottleneck for read/write path? From my view, if I increase keyvaluestore_header_cache_size to very large number like 102400, almost of header should be cached inmemory. KeyValueStore uses RandomCache to store header cache, it should be cheaper. And header in KeyValueStore is alike "file descriptor" in local fs, a large header cache size is encouraged since "header" is  lightweight compared to inode.
>
> [Somnath] Nope, so far I am not seeing this as a bottleneck, but thinking if we can get rid of extra read always..In our case one OSD will serve ~8TB of storage, so, to cache all these headers in memory we need ~420MB (considering default 4MB rados object size and header size is ~200bytes), which is kind of big. So, I think there will be some disk read always.
> I think just querying the particular object should reveal whether object exists or not. Not sure if we need to verify headers always in the io path to determine if object exists or not. I know in case of omap it is implemented like that, but, I don't know what benefit we are getting by doing that.
>
>>
>> 3. We can aggregate the small writes in the buffer transaction and issue one single key/value write to the dbs. If dbs are already doing small write aggregation , this won't help much though.
>
> Yes, it could be done just like NewStore did! So keyvaluestore's process flaw will be this:
>
> several pg threads: queue_transaction
>               |
>               |
> several keyvaluestore op threads: do_transaction
>               |
> keyvaluestore submit thread: call db->submit_transaction_sync
>
> So the bandwidth should be better.
>
> Another optimization point is reducing lock granularity to object-level(currently is pg level), I think if we use a separtor submit thread it will helpful because multi transaction in one pg will be queued in ordering.
> [Somnath] Yeah..That I raised earlier, but, it seems quite a few impact for that. But, it worth trying..May be need to discuss with Sage/Sam.

Cool!

>
>
>>
>> Please share your thought around this.
>>
>
> I always rethink to improve keyvaluestore performance, but I don't have a good backend still now. A ssd vendor who can provide with FTL interface would be great I think, so we can offload lots of things to FTL layer.
>
>> Thanks & Regards
>> Somnath
>>
>>
>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
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
