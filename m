From: Sage Weil <sage@newdream.net>
Subject: Re: Suggestion for deduplication
Date: Wed, 14 Dec 2016 15:20:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612141456100.10615@piezo.novalocal>
References: <CAFNt83b8gSKxBG0c+aeW0-X7sT765NoQMZO8J2Nhtmp_=gDa-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-712950696-1481728861=:10615"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37433 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755534AbcLNPVD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 10:21:03 -0500
In-Reply-To: <CAFNt83b8gSKxBG0c+aeW0-X7sT765NoQMZO8J2Nhtmp_=gDa-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: myoungwon oh <ohmyoungwon@gmail.com>
Cc: ceph-devel@vger.kernel.org, =?EUC-KR?B?v8C47b/4?= <omwmw@sk.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-712950696-1481728861=:10615
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Myoungwon,

I'm excited to see someone working on this.  We've discussed approaches in 
the past but until now nobody has had time to devote to the project.  If 
you haven't already, you might be interested in

Apr 6 CDM discussion
	http://tracker.ceph.com/projects/ceph/wiki/CDM_06-APR-2016
	http://pad.ceph.com/p/dedup
	https://youtu.be/3CABed6o_o4

On Wed, 14 Dec 2016, myoungwon oh wrote:
> Hi sage, ceph developers
> 
> I am a system software engineer working at SK telecom.
> We are developing Data deduplication in Ceph, based on discussions of
> Ceph community and our own research.
> Current status is as below, we implemented prototype, and we want to
> share our result to Ceph community and want to get your feedback.
> 
> 1. Motivation
> We studied which structure deduplication is suitable for Ceph, the
> distributed file system of shared-nothing architecture. As a result,
> it seems the most reasonable method is to utilize data distribution
> using hash value, which is used in Shared-nothing architecture and
> tiering.
> The reason is as follows
> 1- There is no change in current structure, and there is no big
> additional change.
> 2- There is no need to develop and configure a separated deduplication
> metadata server.
> 3- EC and Replication can be selected and used. That is, since
> deduplication is performed in cache tier, existing features of below
> layer can be utilized as it is.
> 4- Don't need to consider data placement, load balancing and recovery.
> Because existing structure is used, features mentioned above will be
> handled as in original Ceph. So only the metadata part need to be
> handled.
> 
> 2. Design concept
> Main design concept is double CRUSH + cache tier. (http://imgur.com/9F3jQA6)
> 
> "double CRUSH"
> Hash the incoming data to an OID, and assign that hash value as a new OID.
> For example, OID : DATA -->(hash)--> FP_OID : DATA
> 
> "cache tier"
> Redirection is required for new OID(hash value). If we use cache tier
> which is currently implemented, we can receive request at Cache tier
> first and then, can redirecting the request to the actual storage
> tier.
> Currently inline processing is possible using the proxy mode of cache
> tier. And also inline+post processing is possible using the writeback
> mode of cache tier.

The way I've been thinking about this so far is as a two-tier system of 
rados pools.  The first pool has objects with their "real" names, but 
instead of the data content, they have a manifest of CAS objects: objects 
named by their fingerprint (e.g., sha1) and a map from logical offset to 
cas object name.  Then a second pool stores the cas objects with actual 
data and reference counts.

> 3. Design detail
> (http://imgur.com/qUQ5e44)
> 
> "I/O flow (inline mode)
> Write : write request -> fingerprint calculation -> search lookup
> table(OID <-> Fingerprint(FP) OID mapping) ->
>  (If data exist) for old FP_OID, decrease reference count through
> setattr of Objecter -> Increase reference count
>  through setxattr with new FP_OID -> update lookup table – complete
> 
> Read : read request -> search lookup table -> (If data exist) Request
> data with mapped FP_OID

I would s/lookup table/base pool/.  Our main idea is that you can treat
a deduped object as a special case of a regular object or a tiered object.  
e.g., foo might be stored normally.  bar might be a redirect that says 
"bar is stored in this cold rados pool over there."  And baz's 
object_info_t might say "i'm composed of these logical chunks at these 
offsets stored in this cas rados pool over there."
 
> "I/O flow (inline+post processing)
> Write : flush event occur -> Request COPY_FROM by dividing object into
> fixed size chunk -> update lookup table

I've mostly ignored the inline case just to keep an initial version 
simple, although in principle I'm not sure one is actually needed.  If we 
just chunk as soon as we have enough data the op to the CAS pool can we 
"write this data or, if the object already exists, just increment the ref 
count".

> Read : promote_object requests a COPY_GET, with chunk as unit.
> 
> "chunking"
> Currently, 4K, 128K, 256K, and 512K chunk size are available as fixed
> chunk size.

This is fine for a prototype, although eventually I think we'll want to do 
some form of Rabin fingerprinting to pick chunk boundaries.

> "Lookup table"
> Lookup table manages the OID and fingerprint mapping and status(number
> of chunks, state) of deduped object.
> The matching of OID, offset and fingerprint for each request is
> processed through this table.

Our main idea is to think of the index as the rados pool (which is already 
scalable, elastic, can be mapped to SSDs, etc.).  I think this is what 
you're saying as well but I'm not sure from your choice of words!

> "metadata recovery & replication"
> Data recovery is done by the existing Ceph structure. Therefore,
> additional implementation is needed for deduplication metadata
> management. Newly added data structure is only a lookup table.
> We can secure the reliability by using existing replication
> structure.(When lookup table updated, request it to another OSDs, that
> having same  replicated table in them for syncing of entries)
> 
> "metadata cache"
> Metadata & data cache is one of the important structures that
> determine the performance of deduplication. Currently it is
> implemented through simple LRU and Level-DB,but we are planning to
> develop additional improved algorithms and data structures.

If we consider the first tier (which contains the redirects) as a regular 
pool, I think caching becomes a normal-ish case of cache tiering, and can 
reuse the infrastructure that rados cache tiering already uses (or replace 
it with something better).  A 'writeback' caching behavior would just be
offline (not inline) dedup.  If we see many reads on a deduped object, 
we'd just promote it into the base tier (just like we do with cache 
tiering).  And the tiering agent can walk the tier PGs demoting (deduping) 
objects that appear cold based on pool usage thresholds.

> 4. Prototype evaluation (inline mode, 512K chunk, RBD, Seq. write)
> 
> "Experiment 1 (http://imgur.com/Fdq7mWr)”
> 
> X axis represents the number of stored OS images, and the Y axis
> represents the total storage capacity as the X axis value increases.
> (Images are based on Cent OS 7.0) In addition to being able to remove
> the same block from the same image
> (if the OS image number is 1), can see only an additional 50MB is
> stored if stores similar image.
> 
> "Experiment 2 (http://imgur.com/wHGVNMq)"
> 
> The actual data rate, is the data stored in the ceph cluster / data
> stored by the client. In case of Dedup ratio 20, the actual storage
> ratio is slightly higher because of ceph and dedup metadata, but in
> the remaining cases we can see it is close to ideal value.
> In performance perspective, we can see the performance become half,
> because of additional computations of Proxy structure and
> deduplication.(current implementation (inline) must redirect write
> message to storage tier. dedupe is done at storage tier. This can be
> fixed later)

Cool!

Do my comments above align with what you have in mind?  I'd love to 
discuss this here (and follow up at the next CDM) so we can converge on an 
approach and set milestones.  I suspect those are probably something like 
the below, but I don't fully understand what you're proposing above, so 
take this with a grain of salt!

- build standard approach for a CAS rados pool with refcounted objects 
named by their hash.  (Probably a rados cls?)

- add a basic redirect mechanism so that a rados object can store no data, 
just a object_info_t placeholder, with a new field/component that says 
"data is over there in this other pool."  That 'redirect' structure should 
be modular/pluggable so that we can extend it later for other types of 
backends and mappings of logical extents to CAS dedup objects.

- implement read path for above (basically proxy read)
- promote path for above
- trivial demote path (push entire object to other tier)

(At this point we have something very similar to the current cache 
tiering, but more flexible.)

- plug in dedup logic (chunk object, push all chunks to cas pool, write 
complicated manifest).

There are lots of lingering issues about how we should implement this, 
though.  In particular, we want to revisit many of the choices we made 
doing cache tiering and (probably) implement things differently here.  
The upshot, though, is that if we do this right I think dedup can just be 
a special case of tiering in general, and we can address a bunch of other 
tiering scenarios at the same time.

sage
--8323329-712950696-1481728861=:10615--
