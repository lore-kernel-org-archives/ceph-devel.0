From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: A way to reduce compression overhead
Date: Wed, 9 Nov 2016 16:35:13 +0300
Message-ID: <a2381759-4f9b-97dc-53cb-279e51337056@mirantis.com>
References: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com>
 <alpine.DEB.2.11.1611082019530.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36796 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932540AbcKINfR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 08:35:17 -0500
Received: by mail-lf0-f50.google.com with SMTP id t196so164903943lff.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2016 05:35:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611082019530.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage


On 11/8/2016 11:27 PM, Sage Weil wrote:
> On Tue, 8 Nov 2016, Igor Fedotov wrote:
>> Hi Sage, et al.
>>
>> Let me share some ideas about possible compression burden reduction on the
>> cluster.
>>
>> As known we perform block compression at BlueStore level for each replica
>> independently. This triples compression CPU overhead for the cluster. Looks
>> like significant CPU resource waste IMHO.
>>
>> We can probably eliminate this overhead by introduction write request
>> preprocessing performed at ObjectStore level synchronously. This preprocessing
>> parses transaction, detects write requests and transforms them into different
>> ones aligned with current store allocation unit. At the same time resulting
>> extents that span more than single AU are compressed if needed. I.e.
>> preprocessing do some of the job performed at BlueStore::_do_write_data that
>> splits write request into _do_write_small/_do_write_big calls. But after the
>> split and big blob compression preprocessor simply updates the transaction
>> with new write requests.
>>
>> E.g.
>>
>> with AU = 0x1000
>>
>> Write Request (1~0xffff) is transformed into the following sequence:
>>
>> WriteX 1~0xfff (uncompressed)
>>
>> WriteX 0x1000~E000 (compressed if needed)
>>
>> WriteX 0xf000~0xfff (uncompressed)
>>
>> Then updated transaction is passed to all replicas including the master one
>> using regular apply_/queue_transaction mechanics.
>>
>>
>> As a bonus one receives automatic payload compression when transporting
>> request to remote store replicas.
>> Regular write request path should be preserved for EC pools and other needs as
>> well.
>>
>> Please note that almost no latency is introduced for request handling.
>> Replicas receive modified transaction later but they do not spend time on
>> doing split/compress stuff.
> I think this is pretty reasonable!  We have a couple options... we could
> (1) just expose a compression alignment via ObjectStore, (2) take
> compression alignment from a pool property, or (3) have an explicit
> per-write call into ObjectStore so that it can chunk it up however it
> likes.
>
> Whatever we choose, the tricky bit is that there may be different stores
> on different replicas.  Or we could let the primary just decide locally,
> given that this is primarily an optimization; in the worst case we
> compress something on the primary but one replica doesn't support
> compression and just decompresses it before doing the write (i.e., we get
> on-the-wire compression but no on-disk compression).
IMHO different stores on different replicas is rather a corner case and 
it's better (or simpler) to disable compression optimization when it 
takes place. Doing compression followed by decompression seems ugly a 
bit unless we're talking about traffic compression only.
To disable compression preprocessing we can either have a manual switch 
in the config or collect remote OSD capabilities at primary and disable 
preprocessing automatically. This can be made just once hence it 
wouldn't impact request handling performance.
> I lean toward the simplicity of get_compression_alignment() and
> get_compression_alg() (or similar) and just make a local (primary)
> decision.  Then we just have a simple compatibility write_compressed()
> implementation (or helper) that decompresses the payload so that we can do
> a normal write.
As for me I always stand for better functionality encapsulation - hence 
I'd prefer (3): store do whatever it can and transparently passes 
results to replicas. This allows to modify or extend the logic smoothly, 
e.g. optimize csum calculation for big chunks etc.
Contrary in (1) we expose most of this functionality to store's client 
(i.g. replicated backend stuff,  not a real Ceph client). In fact for 
(1) we'll have  2 potentially evolving APIs:
- compressed(optimized) write request delivery
- store optimization description provided to client ( i.e. mentioned 
algorithm + alignment retrieval initially).
The latter isn't needed for (3)

>
> Before getting to carried away, though, we should consider whether we're
> going to want to take a further step to allow clients to compress data
> before it's sent.  That isn't necessarily in conflict with this if we go
> with pool properties to inform the alignment and compression alg
> decision.  If we assume that the ObjectStore on the primary gets to decide
> everything it will work less well...
Firstly let's agree on the terminology. Here we're talking about Ceph 
cluster clients. While it were store clients (PG backends) above.
Well, this case is a bit different comparing to the above. (3) isn't a 
viable option here. Ceph client definitely relies on (1) or (2) if any 
(I'm afraid bringing compression to client will be a headache).
But at the same time IMHO it might be an argument against having (1) for 
the store client. There appears three entities that a aware of 
compression optimization: Ceph client, store client(PG backend) and 
store itself. Not good...
In case of (1) + (3) intermediate layer can be probably unburden from 
that awareness - it simply has to pass compressed blocks transparently 
from client to store and from primary store to replicas.
>> There is a potential conflict with the current garbage collection stuff though
>> - we can't perform GC during preprocessing due to possible race with preceding
>> unfinished transactions and consequently we're unable to merge and compress
>> merged data. Well, we can do that when applying transaction but this will
>> produce a sequence like this at each replica:
>>
>> decompress original request + decompress data to merge -> compress merged
>> data.
>>
>> Probably this limitation isn't that bad - IMHO it's better to have compressed
>> blobs aligned with original write requests.
>>
>> Moreover I have some ideas how to get rid of blob_depth notion that makes life
>> a bit easier. Will share shortly.
> I'm curious what you have in mind!  The blob_depth as currently
> implemented is not terribly reliable...
General idea is to estimate allocated vs stored ratio for the blob(s) 
under the extent being written.
Where stored and allocated are measured in allocation units. And can be 
calculated using blobs ref_map.
If that ratio is greater than 1 (+-some correction) - we need to perform 
GC for these blobs. Given the fact we do that after compression 
preprocessing it's expensive to merge the compressed extent being 
written and old shards. Hence that shards are written as standalone 
extents as opposed to current implementation when we try to merge both 
new and existing extents into  a single entity. Not a big drawback IMHO. 
Evidently this is valid for new compressed extents (that are AU aligned) 
only. Uncompressed ones can be merged in any fashion.
This is just a draft hence comments are highly appreciated.

>
> sage

