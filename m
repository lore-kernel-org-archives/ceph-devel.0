From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: 2 related bluestore questions
Date: Tue, 10 May 2016 15:17:58 +0300
Message-ID: <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36128 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbcEJMSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 08:18:02 -0400
Received: by mail-lf0-f47.google.com with SMTP id u64so12541688lff.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 05:18:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, allen.samuels@sandisk.com
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Please find my comments below.

WRT 1. there is an alternative approach that doesn't need persistent 
refmap. It works for non-shared bnode only though. In fact one can build 
such a refmap using onode's lextents map pretty easy. It looks like any 
procedure that requires such a refmap has a logical offset as an input. 
This provides an appropriate lextent referring to some blob we need 
refmap for. What we need to do for blob's refmap building is to 
enumerate lextents within +-max_blob_size range from the original 
loffset. I suppose we are going to avoid small lextent entries most of 
time by merging them thus such enumeration should be short enough. Most 
probably such refmap build is needed for background wal procedure (or 
its replacement - see below) thus it wouldn't affect primary write path 
performance. And this procedure will require some neighboring lxtent 
enumeration to detect  lextents to merge anyway.

Actually I don't have strong opinion which approach is better.  Just a 
minor point that tracking persistent refmap is a bit more complex and 
space consuming.

WRT to 2. IMO single  byte granularity is OK. Initial write request 
handling can create lextents of any size depending on the input data 
blocks. But we will try to eliminate it during wal processing to have 
larger extents and better space usage though.

WRT WAL changes. My idea is to replace WAL with a bit different extent 
merge (defragmenter, garbage collector, space optimizer - whatever name 
of your choice) process. The main difference - current WAL 
implementation tracks some user data and thus it's a part of the 
consistency model (i.e. one has to check if data block is in the WAL). 
In my approach data is always consistent without such a service. At the 
first write handling step we always write data to the store by 
allocating new blob and modifying lextent map. And apply corresponding 
checksum using regular means if needed. Thus we always have consistent 
data in lextent/blob structures. And defragmenter process is just a 
cleanup/optimization thread that merges sparse lextents to improve space 
utilization. To avoid full lextent map enumeration during 
defragmentation ExtentManager (or whatever entity that handles writes) 
may return some 'hints' where space optimization should be applied. This 
is to be done at initial write processing. Such hint is most probably 
just a logical offset or some interval within object logical space. 
Write handler provides such a hint if it detects (by lextent map 
inspection) that optimization is required, e.g. in case of partial 
lextent overwrite, big hole punch, sparse small lextents etc. Pending 
optimization tasks (list of hints) are maintained by the BlueStore and 
passed to EM (or another corresponding entity) for processing in the 
context of a specific thread. Based of such hints defragmenter locates 
lextents to merge and do the job: Read/Modify/Write multiple lextents 
and/or blobs. Optionally this can be done with with some delay to care 
write burst within a specific object region. Another point is that hint 
list can be potentially tracked without KV store (some in-memory data 
structure is enough) as there is no mandatory need for its replay in 
case of OSD failure - data are always consistent at the store and 
failure can lead to some local space ineffectiveness only. That's a rare 
case though.

What do you think about this approach?

Thanks,
Igor

On 09.05.2016 21:31, Sage Weil wrote:
> 1. In 7fb649a3800a5653f5f7ddf942c53503f88ad3f1 I added an extent_ref_map_t
> to the blob_t.  This lets us keep track, for each blob, of references to
> the logical blob extents (in addition to the raw num_refs that just counts
> how many lextent_t's point to us).  It will let us make decisions about
> deallocating unused portions of the blob that are no longer referenced
> (e.g., when we are uncompressed).  It will also let us sanely reason
> about whether we can write into the blob's allocated space that is not
> referenced (e.g., past end of object/file, but within a min_alloc_size
> chunk).
>
> The downside is that it's a bit more metadata to maintain.  OTOH, we need
> it in many cases, and it would be slow/tedious to create it on the fly.
>
> I think yes, though some minor changes to the current extent_ref_map_t are
> needed, since it currently has weird assumptoins about empty meaning a ref
> count of 1.
>
> 2. Allow lextent_t's to be byte-granularity.
>
> For example, if we write 10 bytes into the object, we'd have a blob of
> min_alloc_size, and an lextent_t that indicates [0,10) points to that
> blob.
>
> The upside here is that truncate and zero are trivial updates to the
> lextent map and never need to do any IO--we just punch holes in our
> mapping.
>
> The downside is that we might get odd mappings like
>
>   0: 0~10->1
>   4000: 4000~96->1
>
> after a hole (10~3990) has been punched, and we may need to piece the
> mapping back together.  I think we will need most of this complexity
> (e.g., merging adjacent lextents that map to adjacent regions of the same
> blob) anyway.
>
> Hmm, there is probably some other downside but now I can't think of a good
> reason not to do this.  It'll basically put all of the onus on the write
> code to do the right thing... which is probably a good thing.
>
> Yes?
>
>
> Also, one note on the WAL changes: we'll need to have any read portion of
> a wal event include the raw pextents *and* the associated checksum(s).
> This is because the events need to be idempotent and may overwrite the
> read region, or interact with wal ops that come before/after.
>
> sage

