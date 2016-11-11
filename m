From: Sage Weil <sage@newdream.net>
Subject: Re: A way to reduce compression overhead
Date: Fri, 11 Nov 2016 23:42:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611112330530.29579@piezo.us.to>
References: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com> <alpine.DEB.2.11.1611082019530.29278@piezo.us.to> <a2381759-4f9b-97dc-53cb-279e51337056@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54224 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933797AbcKKXm3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 18:42:29 -0500
In-Reply-To: <a2381759-4f9b-97dc-53cb-279e51337056@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 9 Nov 2016, Igor Fedotov wrote:
> > I think this is pretty reasonable!  We have a couple options... we could
> > (1) just expose a compression alignment via ObjectStore, (2) take
> > compression alignment from a pool property, or (3) have an explicit
> > per-write call into ObjectStore so that it can chunk it up however it
> > likes.
> > 
> > Whatever we choose, the tricky bit is that there may be different stores
> > on different replicas.  Or we could let the primary just decide locally,
> > given that this is primarily an optimization; in the worst case we
> > compress something on the primary but one replica doesn't support
> > compression and just decompresses it before doing the write (i.e., we get
> > on-the-wire compression but no on-disk compression).
> IMHO different stores on different replicas is rather a corner case and it's
> better (or simpler) to disable compression optimization when it takes place.
> Doing compression followed by decompression seems ugly a bit unless we're
> talking about traffic compression only.
> To disable compression preprocessing we can either have a manual switch in the
> config or collect remote OSD capabilities at primary and disable preprocessing
> automatically. This can be made just once hence it wouldn't impact request
> handling performance.
> > I lean toward the simplicity of get_compression_alignment() and
> > get_compression_alg() (or similar) and just make a local (primary)
> > decision.  Then we just have a simple compatibility write_compressed()
> > implementation (or helper) that decompresses the payload so that we can do
> > a normal write.
> As for me I always stand for better functionality encapsulation - hence I'd
> prefer (3): store do whatever it can and transparently passes results to
> replicas. This allows to modify or extend the logic smoothly, e.g. optimize
> csum calculation for big chunks etc.
> Contrary in (1) we expose most of this functionality to store's client (i.g.
> replicated backend stuff,  not a real Ceph client). In fact for (1) we'll have
> 2 potentially evolving APIs:
> - compressed(optimized) write request delivery
> - store optimization description provided to client ( i.e. mentioned algorithm
> + alignment retrieval initially).
> The latter isn't needed for (3)

The concern I have here is that it probably won't map well onto EC.  The 
primary can't easily have the local ObjectStore chunking things up and 
then "pass it to the replica".. there's an intermediate layer between the 
replication code and the ObjectStore (and is getting a bit more 
sophisticated with the coming EC changes).

I think the simplest approach here would be to keep it simple.  For 
example, a min_alloc_size and max compressed chunk size specified for the 
pool.  The intermediate layer can apply the EC striping parameters, and 
then chunk/compress accordingly.

I agree that worrying about client-side compression seems like a lot at 
this stage, but it's going to be the very next thing we ask about, so we 
should consider it to make sure we don't put up any major roadblocks.

Either way, though, we should probably wait for the EC overwrite changes 
to land...


As for GC,

> > I'm curious what you have in mind!  The blob_depth as currently
> > implemented is not terribly reliable...
> General idea is to estimate allocated vs stored ratio for the blob(s) under
> the extent being written.
> Where stored and allocated are measured in allocation units. And can be
> calculated using blobs ref_map.
> If that ratio is greater than 1 (+-some correction) - we need to perform GC
> for these blobs. Given the fact we do that after compression preprocessing
> it's expensive to merge the compressed extent being written and old shards.
> Hence that shards are written as standalone extents as opposed to current
> implementation when we try to merge both new and existing extents into  a
> single entity. Not a big drawback IMHO. Evidently this is valid for new
> compressed extents (that are AU aligned) only. Uncompressed ones can be merged
> in any fashion.
> This is just a draft hence comments are highly appreciated.

Yeah, I think this is a more sensible approach (focusing on allocated vs 
referenced).  It seems like the most straightforward thing to do is 
actually look at the old_extents in the wctx--since those are the ref_maps 
that will become less referenced than before--in order to identify which 
blobs might need rewriting.  Avoiding the merge case vastly simplifies it.  
That also isn't any persistent metadata that we have to maintain (that 
might become incorrect or inconsistent).

We'd probably do the _do_write_data (which will do the various 
punch_hole's), then check for any gc work, then do the final 
_do_alloc_write and _wctx_finish?

sage

