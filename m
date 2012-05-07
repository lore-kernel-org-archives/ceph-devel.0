From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd caching
Date: Mon, 07 May 2012 00:09:30 -0700
Message-ID: <4FA7752A.9060502@inktank.com>
References: <Pine.LNX.4.64.1205051640540.28748@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53125 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab2EGHJb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 May 2012 03:09:31 -0400
Received: by obbtb18 with SMTP id tb18so7903253obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 May 2012 00:09:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205051640540.28748@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/05/2012 04:51 PM, Sage Weil wrote:
> The second set of patches restructure the way the cache itself is managed.
> One goal is to be able to control cache behavior on a per-image basis
> (this one write-thru, this was write-back, etc.).  Another goal is to
> share a single pool of memory for several images.  The librbd.h calls to
> do this currently look something like this:
>
> int rbd_cache_create(rados_t cluster, rbd_cache_t *cache, uint64_t max_size,
> 		     uint64_t max_dirty, uint64_t target_dirty);
> int rbd_cache_destroy(rbd_cache_t cache);
> int rbd_open_cached(rados_ioctx_t io, const char *name, rbd_image_t image,
> 		 const char *snap_name, rbd_cache_t cache);
>
> Setting the cache tunables should probably be broken out into several
> different calls, so that it is possible to add new ones in the future.
> Beyond that, though, the limitation here is that you can set the
> target_dirty or max_dirty for a _cache_, and then have multiple images
> share that cache, but you can't then set a max_dirty limit for an
> individual image.

I'm not sure that these should be separate API calls. We can
already control per-image caches via different rados_conf
settings when the image is opened. We're already opening
a new rados_cluster_t (which can have its own settings)
for each image in qemu.

> Does it matter?  Ideally, I supposed, you could set:
>
>   - per-cache size
>   - per-cache max_dirty
>   - per-cache target_dirty
>   - per-image max_dirty  (0 for write-thru)
>   - per-image target_dirty
>
> and then share a single cache for many images, and the flushing logic
> could observe both sets of dirty limits.  That just means calls to set
> max_dirty and target_dirty for individual images, too.

I don't think all this flexibility is necessary. If we did want
to add it, it could be done with configuration settings instead
of pushing the complexity to the librbd caller. For example, there
could be a 'rbd_cache_name' option, and the images using the same
cache name could share the same underlying cache. Alternatively,
there could be an option to make all rbd images use the same cache
with their own limits.

What use cases do you see for single-vm cache sharing? I can't think
of any common ones off the top of my head. It seems like ksm
will provide much more benefit (especially with layering).

> Is it worth the complexity?  In the end, this will be wired up to the qemu
> writeback options, so the range of actual usage will fall within
> whatever is doable with those options and generic 'rbd cache size = ..'
> tunables, most likely...

There's no notion of shared caches or cache size, since it's
designed for using the host page cache. I think leaving any
extra cache configuration in rbd-specific options makes sense
for now.

Josh
