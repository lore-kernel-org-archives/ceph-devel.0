From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Suggestion for deduplication
Date: Fri, 16 Dec 2016 00:32:28 +0900
Message-ID: <CAFNt83a-YwaRPPKM_rzP7asYZZR=-sk+RjH_M=z=wR0-c-twGg@mail.gmail.com>
References: <CAFNt83b8gSKxBG0c+aeW0-X7sT765NoQMZO8J2Nhtmp_=gDa-A@mail.gmail.com>
 <alpine.DEB.2.11.1612141456100.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33787 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbcLOPcz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 10:32:55 -0500
Received: by mail-ua0-f182.google.com with SMTP id 20so10461521uak.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 07:32:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612141456100.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

Thank you for your valuable feedback. I will prepare Jan. CDM or
Feb. CDM (because prototype evaluation and submitting paper)
and also uploading source code. Please see my comment as below.

2016-12-15 0:20 GMT+09:00 Sage Weil <sage@newdream.net>:
> Hi Myoungwon,
>
> I'm excited to see someone working on this.  We've discussed approaches i=
n
> the past but until now nobody has had time to devote to the project.  If
> you haven't already, you might be interested in
>
> Apr 6 CDM discussion
>         http://tracker.ceph.com/projects/ceph/wiki/CDM_06-APR-2016
>         http://pad.ceph.com/p/dedup
>         https://youtu.be/3CABed6o_o4
>
> On Wed, 14 Dec 2016, myoungwon oh wrote:
>> Hi sage, ceph developers
>>
>> I am a system software engineer working at SK telecom.
>> We are developing Data deduplication in Ceph, based on discussions of
>> Ceph community and our own research.
>> Current status is as below, we implemented prototype, and we want to
>> share our result to Ceph community and want to get your feedback.
>>
>> 1. Motivation
>> We studied which structure deduplication is suitable for Ceph, the
>> distributed file system of shared-nothing architecture. As a result,
>> it seems the most reasonable method is to utilize data distribution
>> using hash value, which is used in Shared-nothing architecture and
>> tiering.
>> The reason is as follows
>> 1- There is no change in current structure, and there is no big
>> additional change.
>> 2- There is no need to develop and configure a separated deduplication
>> metadata server.
>> 3- EC and Replication can be selected and used. That is, since
>> deduplication is performed in cache tier, existing features of below
>> layer can be utilized as it is.
>> 4- Don't need to consider data placement, load balancing and recovery.
>> Because existing structure is used, features mentioned above will be
>> handled as in original Ceph. So only the metadata part need to be
>> handled.
>>
>> 2. Design concept
>> Main design concept is double CRUSH + cache tier. (http://imgur.com/9F3j=
QA6)
>>
>> "double CRUSH"
>> Hash the incoming data to an OID, and assign that hash value as a new OI=
D.
>> For example, OID : DATA -->(hash)--> FP_OID : DATA
>>
>> "cache tier"
>> Redirection is required for new OID(hash value). If we use cache tier
>> which is currently implemented, we can receive request at Cache tier
>> first and then, can redirecting the request to the actual storage
>> tier.
>> Currently inline processing is possible using the proxy mode of cache
>> tier. And also inline+post processing is possible using the writeback
>> mode of cache tier.
>
> The way I've been thinking about this so far is as a two-tier system of
> rados pools.  The first pool has objects with their "real" names, but
> instead of the data content, they have a manifest of CAS objects: objects
> named by their fingerprint (e.g., sha1) and a map from logical offset to
> cas object name.  Then a second pool stores the cas objects with actual
> data and reference counts.
>

Our implementation is exactly same as your thought.


>> 3. Design detail
>> (http://imgur.com/qUQ5e44)
>>
>> "I/O flow (inline mode)
>> Write : write request -> fingerprint calculation -> search lookup
>> table(OID <-> Fingerprint(FP) OID mapping) ->
>>  (If data exist) for old FP_OID, decrease reference count through
>> setattr of Objecter -> Increase reference count
>>  through setxattr with new FP_OID -> update lookup table =E2=80=93 compl=
ete
>>
>> Read : read request -> search lookup table -> (If data exist) Request
>> data with mapped FP_OID
>
> I would s/lookup table/base pool/.  Our main idea is that you can treat
> a deduped object as a special case of a regular object or a tiered object=
.
> e.g., foo might be stored normally.  bar might be a redirect that says
> "bar is stored in this cold rados pool over there."  And baz's
> object_info_t might say "i'm composed of these logical chunks at these
> offsets stored in this cas rados pool over there."
>

Right, current implementation uses some flag in object_info_t, which means
this is deduped object as you said.

>> "I/O flow (inline+post processing)
>> Write : flush event occur -> Request COPY_FROM by dividing object into
>> fixed size chunk -> update lookup table
>
> I've mostly ignored the inline case just to keep an initial version
> simple, although in principle I'm not sure one is actually needed.  If we
> just chunk as soon as we have enough data the op to the CAS pool can we
> "write this data or, if the object already exists, just increment the ref
> count".
>

We need discusstion for Inline processing. Inline processing has some
advantages such as 1. Storage provisioning 2. No dependence on system idle =
time
3. Disk-bandwidth utilization as describe idedup paper.
(https://www.usenix.org/legacy/events/fast12/tech/full_papers/Srinivasan.pd=
f)
also, in terms of flash device, inline processing is efficient because
of flash lifetime and space saving.
(Many flash storage providers adopt inline deduplication such as solidfire)
Therefore, inline or inline+post (writeback) processing is used depending o=
n
what device media is used.



>> Read : promote_object requests a COPY_GET, with chunk as unit.
>>
>> "chunking"
>> Currently, 4K, 128K, 256K, and 512K chunk size are available as fixed
>> chunk size.
>
> This is fine for a prototype, although eventually I think we'll want to d=
o
> some form of Rabin fingerprinting to pick chunk boundaries.
>

Yes. Our plan contains CDC(Contents defined chunking).
Because CDC would be helpful in backup stream workload (because CDC
need =E2=80=9Ccontinuous stream=E2=80=9D).
However, we think fixed size chunking is still useful
when ceph is used as primary data server with flash devices.

>> "Lookup table"
>> Lookup table manages the OID and fingerprint mapping and status(number
>> of chunks, state) of deduped object.
>> The matching of OID, offset and fingerprint for each request is
>> processed through this table.
>
> Our main idea is to think of the index as the rados pool (which is alread=
y
> scalable, elastic, can be mapped to SSDs, etc.).  I think this is what
> you're saying as well but I'm not sure from your choice of words!
>


I understood. (i don=E2=80=99t have to consider replication and recovery)

I think we need discussion about separate metadata for deduplication.
Actually, this implementation use existing rados pool. However,
we need mapping information about original object and deduped object.
For example,
let assume that there are rbd(storage tier) and dedup pool.
If client request read op to dedup pool, dedup pool should redirect
request to rbd pool.
At this time, mapping information will help redirect processing because
it contain (OID, offset) <-> (DEDUPED OID) mapping data.

Dedup metadata (mapping information) can be stored in current object scheme
such as object_info_t (so, original object only has metadata, data size is =
0)

However, if storage capacity reach hundreds of PB, dedup metadata cause
a performance problem due to size.
(4KB fixed chunk cause additional I/O, each chunk need at least
fingerprint, offset and source OID)
Therefore, prior research tried to minimize metadata size in order to
avoid additional I/O
(Silo, https://www.usenix.org/legacy/events/atc11/tech/final_files/Xia.pdf)
or enhanced cache policy (Cachededup,
https://www.usenix.org/system/files/conference/fast16/fast16-papers-li-wenj=
i.pdf)

Because of above reason, we think addtional separated metadata
structure in dedup pool is more helpful
in order to apply optimization (caching, prefetching..). What do you
think of this approach?



>> "metadata recovery & replication"
>> Data recovery is done by the existing Ceph structure. Therefore,
>> additional implementation is needed for deduplication metadata
>> management. Newly added data structure is only a lookup table.
>> We can secure the reliability by using existing replication
>> structure.(When lookup table updated, request it to another OSDs, that
>> having same  replicated table in them for syncing of entries)
>>
>> "metadata cache"
>> Metadata & data cache is one of the important structures that
>> determine the performance of deduplication. Currently it is
>> implemented through simple LRU and Level-DB,but we are planning to
>> develop additional improved algorithms and data structures.
>
> If we consider the first tier (which contains the redirects) as a regular
> pool, I think caching becomes a normal-ish case of cache tiering, and can
> reuse the infrastructure that rados cache tiering already uses (or replac=
e
> it with something better).  A 'writeback' caching behavior would just be
> offline (not inline) dedup.  If we see many reads on a deduped object,
> we'd just promote it into the base tier (just like we do with cache
> tiering).  And the tiering agent can walk the tier PGs demoting (deduping=
)
> objects that appear cold based on pool usage thresholds.
>
>> 4. Prototype evaluation (inline mode, 512K chunk, RBD, Seq. write)
>>
>> "Experiment 1 (http://imgur.com/Fdq7mWr)=E2=80=9D
>>
>> X axis represents the number of stored OS images, and the Y axis
>> represents the total storage capacity as the X axis value increases.
>> (Images are based on Cent OS 7.0) In addition to being able to remove
>> the same block from the same image
>> (if the OS image number is 1), can see only an additional 50MB is
>> stored if stores similar image.
>>
>> "Experiment 2 (http://imgur.com/wHGVNMq)"
>>
>> The actual data rate, is the data stored in the ceph cluster / data
>> stored by the client. In case of Dedup ratio 20, the actual storage
>> ratio is slightly higher because of ceph and dedup metadata, but in
>> the remaining cases we can see it is close to ideal value.
>> In performance perspective, we can see the performance become half,
>> because of additional computations of Proxy structure and
>> deduplication.(current implementation (inline) must redirect write
>> message to storage tier. dedupe is done at storage tier. This can be
>> fixed later)
>
> Cool!
>
> Do my comments above align with what you have in mind?  I'd love to
> discuss this here (and follow up at the next CDM) so we can converge on a=
n
> approach and set milestones.  I suspect those are probably something like
> the below, but I don't fully understand what you're proposing above, so
> take this with a grain of salt!
>
> - build standard approach for a CAS rados pool with refcounted objects
> named by their hash.  (Probably a rados cls?)
>

Current implementation uses existing modified function
(such as promote_object(copy_get), proxy_read, proxy_write,
start_flush(copy_from))
in order to access storage pool.
And store refcount in object xattr and marked this as a deduped object.
What do you think this approach? Do we need additional consideration?


> - add a basic redirect mechanism so that a rados object can store no data=
,
> just a object_info_t placeholder, with a new field/component that says
> "data is over there in this other pool."  That 'redirect' structure shoul=
d
> be modular/pluggable so that we can extend it later for other types of
> backends and mappings of logical extents to CAS dedup objects.
>
> - implement read path for above (basically proxy read)
> - promote path for above
> - trivial demote path (push entire object to other tier)
>
> (At this point we have something very similar to the current cache
> tiering, but more flexible.)
>

I will make a detailed document which describe I/O flow and mechanism
in order to reach a consensus.

> - plug in dedup logic (chunk object, push all chunks to cas pool, write
> complicated manifest).

I think you can give a specific hint after we upload source code.

>
> There are lots of lingering issues about how we should implement this,
> though.  In particular, we want to revisit many of the choices we made
> doing cache tiering and (probably) implement things differently here.
> The upshot, though, is that if we do this right I think dedup can just be
> a special case of tiering in general, and we can address a bunch of other
> tiering scenarios at the same time.
>
> sage
