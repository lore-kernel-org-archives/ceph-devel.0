From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore blobs
Date: Fri, 19 Aug 2016 06:38:00 -0500
Message-ID: <441975fb-f02d-67f1-9527-4b753dfea03d@redhat.com>
References: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
 <BLUPR0201MB1524D88B4FD92E208DF840B0E8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608181459500.2394@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbcHSLiE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 07:38:04 -0400
In-Reply-To: <alpine.DEB.2.11.1608181459500.2394@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 08/18/2016 10:10 AM, Sage Weil wrote:
> On Thu, 18 Aug 2016, Allen Samuels wrote:
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Sage Weil
>>> Sent: Wednesday, August 17, 2016 7:26 AM
>>> To: ceph-devel@vger.kernel.org
>>> Subject: bluestore blobs
>>>
>>> I think we need to look at other changes in addition to the encoding
>>> performance improvements.  Even if they end up being good enough, these
>>> changes are somewhat orthogonal and at least one of them should give us
>>> something that is even faster.
>>>
>>> 1. I mentioned this before, but we should keep the encoding
>>> bluestore_blob_t around when we load the blob map.  If it's not changed,
>>> don't reencode it.  There are no blockers for implementing this currently.
>>> It may be difficult to ensure the blobs are properly marked dirty... I'll see if
>>> we can use proper accessors for the blob to enforce this at compile time.  We
>>> should do that anyway.
>>
>> If it's not changed, then why are we re-writing it? I'm having a hard
>> time thinking of a case worth optimizing where I want to re-write the
>> oNode but the blob_map is unchanged. Am I missing something obvious?
>
> An onode's blob_map might have 300 blobs, and a single write only updates
> one of them.  The other 299 blobs need not be reencoded, just memcpy'd.
>
>>> 2. This turns the blob Put into rocksdb into two memcpy stages: one to
>>> assemble the bufferlist (lots of bufferptrs to each untouched blob) into a
>>> single rocksdb::Slice, and another memcpy somewhere inside rocksdb to
>>> copy this into the write buffer.  We could extend the rocksdb interface to
>>> take an iovec so that the first memcpy isn't needed (and rocksdb will instead
>>> iterate over our buffers and copy them directly into its write buffer).  This is
>>> probably a pretty small piece of the overall time... should verify with a
>>> profiler before investing too much effort here.
>>
>> I doubt it's the memcpy that's really the expensive part. I'll bet it's
>> that we're transcoding from an internal to an external representation on
>> an element by element basis. If the iovec scheme is going to help, it
>> presumes that the internal data structure essentially matches the
>> external data structure so that only an iovec copy is required. I'm
>> wondering how compatible this is with the current concepts of
>> lextext/blob/pextent.
>
> I'm thinking of the xattr case (we have a bunch of strings to copy
> verbatim) and updated-one-blob-and-kept-99-unchanged case: instead
> of memcpy'ing them into a big contiguous buffer and having rocksdb
> memcpy *that* into it's larger buffer, give rocksdb an iovec so that they
> smaller buffers are assembled only once.
>
> These buffers will be on the order of many 10s to a couple 100s of bytes.
> I'm not sure where the crossover point for constructing and then
> traversing an iovec vs just copying twice would be...
>
>>> 3. Even if we do the above, we're still setting a big (~4k or more?) key into
>>> rocksdb every time we touch an object, even when a tiny amount of
>>> metadata is getting changed.  This is a consequence of embedding all of the
>>> blobs into the onode (or bnode).  That seemed like a good idea early on
>>> when they were tiny (i.e., just an extent), but now I'm not so sure.  I see a
>>> couple of different options:
>>>
>>> a) Store each blob as ($onode_key+$blobid).  When we load the onode, load
>>> the blobs too.  They will hopefully be sequential in rocksdb (or definitely
>>> sequential in zs).  Probably go back to using an iterator.
>>>
>>> b) Go all in on the "bnode" like concept.  Assign blob ids so that they are
>>> unique for any given hash value.  Then store the blobs as
>>> $shard.$poolid.$hash.$blobid (i.e., where the bnode is now).  Then when
>>> clone happens there is no onode->bnode migration magic happening--we've
>>> already committed to storing blobs in separate keys.  When we load the
>>> onode, keep the conditional bnode loading we already have.. but when the
>>> bnode is loaded load up all the blobs for the hash key.  (Okay, we could fault
>>> in blobs individually, but that code will be more complicated.)
>>>
>>> In both these cases, a write will dirty the onode (which is back to being pretty
>>> small.. just xattrs and the lextent map) and 1-3 blobs (also now small keys).
>>> Updates will generate much lower metadata write traffic, which'll reduce
>>> media wear and compaction overhead.  The cost is that operations (e.g.,
>>> reads) that have to fault in an onode are now fetching several nearby keys
>>> instead of a single key.
>>>
>>>
>>> #1 and #2 are completely orthogonal to any encoding efficiency
>>> improvements we make.  And #1 is simple... I plan to implement this shortly.
>>>
>>> #3 is balancing (re)encoding efficiency against the cost of separate keys, and
>>> that tradeoff will change as encoding efficiency changes, so it'll be difficult to
>>> properly evaluate without knowing where we'll land with the (re)encode
>>> times.  I think it's a design decision made early on that is worth revisiting,
>>> though!
>>
>> It's not just the encoding efficiency, it's the cost of KV accesses. For
>> example, we could move the lextent map into the KV world similarly to
>> the way that you're suggesting the blob_maps be moved. You could do it
>> for the xattrs also. Now you've almost completely eliminated any
>> serialization/deserialization costs for the LARGE oNodes that we have
>> today but have replaced that with several KV lookups (one small Onode,
>> probably an xAttr, an lextent and a blob_map).
>>
>> I'm guessing that the "right" point is in between. I doubt that
>> separating the oNode from the xattrs pays off (especially since the
>> current code pretty much assumes that they are all cheap to get at).
>
> Yep.. this is why it'll be a hard call to make, esp when the encoding
> efficiency is changing at the same time.  I'm calling out blobs here
> because they are biggish (lextents are tiny) and nontrivial to encode
> (xattrs are just strings).
>
>> I'm wondering if it pays off to make each lextent entry a separate
>> key/value vs encoding the entire extent table (several KB) as a single
>> value. Same for the blobmap (though I suspect they have roughly the same
>> behavior w.r.t. this particular parameter)
>
> I'm guessing no because they are so small that the kv overhead will dwarf
> the encoding cost, but who knows.  I think implementing the blob case
> won't be so bad and will give us a better idea (i.e., blobs are bigger and
> more expensive and if it's not a win there then certainly don't bother
> with lextents).

This is certainly what I'm seeing in perf while I walk through and 
change the existing encoding in bluestore to use safe_appender. 
lextents are way down on the list.

>
>> We need to temper this experiment with the notion that we change the
>> lextent/blob_map encoding to something that doesn't require transcoding
>> -- if possible.
>
> Right.  I don't have any bright ideas here, though.  The variable length
> encoding makes this really hard and we still care about keeping things
> small.

Back in the onode diet thread I was wondering about the way cap'n 
protocol does encoding.  It's basically focused on speed first, 
compression 2nd.  It still does a reasonably good job with the common 
cases where you are just trying to avoid a bunch of empty space, and 
optionally uses compression to deal with the rest.

https://capnproto.org/encoding.html

FWIW the guy that wrote that used to be the lead on google's protocol 
buffers.

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
