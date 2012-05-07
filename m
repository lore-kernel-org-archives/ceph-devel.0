From: Sage Weil <sage@inktank.com>
Subject: Re: rbd caching
Date: Mon, 7 May 2012 09:44:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205070940450.29722@cobra.newdream.net>
References: <Pine.LNX.4.64.1205051640540.28748@cobra.newdream.net>
 <4FA7752A.9060502@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55049 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249Ab2EGQoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 May 2012 12:44:30 -0400
In-Reply-To: <4FA7752A.9060502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 7 May 2012, Josh Durgin wrote:
> On 05/05/2012 04:51 PM, Sage Weil wrote:
> > The second set of patches restructure the way the cache itself is managed.
> > One goal is to be able to control cache behavior on a per-image basis
> > (this one write-thru, this was write-back, etc.).  Another goal is to
> > share a single pool of memory for several images.  The librbd.h calls to
> > do this currently look something like this:
> > 
> > int rbd_cache_create(rados_t cluster, rbd_cache_t *cache, uint64_t max_size,
> > 		     uint64_t max_dirty, uint64_t target_dirty);
> > int rbd_cache_destroy(rbd_cache_t cache);
> > int rbd_open_cached(rados_ioctx_t io, const char *name, rbd_image_t image,
> > 		 const char *snap_name, rbd_cache_t cache);
> > 
> > Setting the cache tunables should probably be broken out into several
> > different calls, so that it is possible to add new ones in the future.
> > Beyond that, though, the limitation here is that you can set the
> > target_dirty or max_dirty for a _cache_, and then have multiple images
> > share that cache, but you can't then set a max_dirty limit for an
> > individual image.
> 
> I'm not sure that these should be separate API calls. We can
> already control per-image caches via different rados_conf
> settings when the image is opened. We're already opening
> a new rados_cluster_t (which can have its own settings)
> for each image in qemu.

If we don't want or care about cache sharing, then yeah.  The advantage is 
that, generally speaking, the caches will be more effective if they are 
pooled and share an LRU.  It may not be worth it, especially if qemu won't 
use it.

If that's the case, I think we should merge through 
385142305a83f58f8aa0a93c98679c4018f98a28, which moves the rbd cache 
settings to

  rbd cache size
  rbd cache max dirty
  rbd cache target dirty

distinct from the fs client settings (client oc *).  
77f9dbbafb7f21fb20892b2ebc38e83a55f828ad might be worth taking as well.

sage


> > Does it matter?  Ideally, I supposed, you could set:
> > 
> >   - per-cache size
> >   - per-cache max_dirty
> >   - per-cache target_dirty
> >   - per-image max_dirty  (0 for write-thru)
> >   - per-image target_dirty
> > 
> > and then share a single cache for many images, and the flushing logic
> > could observe both sets of dirty limits.  That just means calls to set
> > max_dirty and target_dirty for individual images, too.
> 
> I don't think all this flexibility is necessary. If we did want
> to add it, it could be done with configuration settings instead
> of pushing the complexity to the librbd caller. For example, there
> could be a 'rbd_cache_name' option, and the images using the same
> cache name could share the same underlying cache. Alternatively,
> there could be an option to make all rbd images use the same cache
> with their own limits.
> 
> What use cases do you see for single-vm cache sharing? I can't think
> of any common ones off the top of my head. It seems like ksm
> will provide much more benefit (especially with layering).
> 
> > Is it worth the complexity?  In the end, this will be wired up to the qemu
> > writeback options, so the range of actual usage will fall within
> > whatever is doable with those options and generic 'rbd cache size = ..'
> > tunables, most likely...
> 
> There's no notion of shared caches or cache size, since it's
> designed for using the host page cache. I think leaving any
> extra cache configuration in rbd-specific options makes sense
> for now.
> 
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
