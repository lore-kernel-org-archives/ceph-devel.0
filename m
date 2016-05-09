From: Sage Weil <sweil@redhat.com>
Subject: 2 related bluestore questions
Date: Mon, 9 May 2016 14:31:38 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcEISb0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2016 14:31:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ifedotov@mirantis.com, allen.samuels@sandisk.com
Cc: ceph-devel@vger.kernel.org

1. In 7fb649a3800a5653f5f7ddf942c53503f88ad3f1 I added an extent_ref_map_t 
to the blob_t.  This lets us keep track, for each blob, of references to 
the logical blob extents (in addition to the raw num_refs that just counts 
how many lextent_t's point to us).  It will let us make decisions about 
deallocating unused portions of the blob that are no longer referenced 
(e.g., when we are uncompressed).  It will also let us sanely reason 
about whether we can write into the blob's allocated space that is not 
referenced (e.g., past end of object/file, but within a min_alloc_size 
chunk).

The downside is that it's a bit more metadata to maintain.  OTOH, we need 
it in many cases, and it would be slow/tedious to create it on the fly.

I think yes, though some minor changes to the current extent_ref_map_t are 
needed, since it currently has weird assumptoins about empty meaning a ref 
count of 1.

2. Allow lextent_t's to be byte-granularity.

For example, if we write 10 bytes into the object, we'd have a blob of 
min_alloc_size, and an lextent_t that indicates [0,10) points to that 
blob.

The upside here is that truncate and zero are trivial updates to the 
lextent map and never need to do any IO--we just punch holes in our 
mapping.

The downside is that we might get odd mappings like

 0: 0~10->1
 4000: 4000~96->1

after a hole (10~3990) has been punched, and we may need to piece the 
mapping back together.  I think we will need most of this complexity 
(e.g., merging adjacent lextents that map to adjacent regions of the same 
blob) anyway.

Hmm, there is probably some other downside but now I can't think of a good 
reason not to do this.  It'll basically put all of the onus on the write 
code to do the right thing... which is probably a good thing.

Yes?


Also, one note on the WAL changes: we'll need to have any read portion of 
a wal event include the raw pextents *and* the associated checksum(s).  
This is because the events need to be idempotent and may overwrite the 
read region, or interact with wal ops that come before/after.

sage
