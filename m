From: Sage Weil <sage@newdream.net>
Subject: rbd caching
Date: Sat, 5 May 2012 16:51:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205051640540.28748@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49741 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab2EEXvz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 May 2012 19:51:55 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1FA1ABC7F7
	for <ceph-devel@vger.kernel.org>; Sat,  5 May 2012 16:51:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D7098BC7F7
	for <ceph-devel@vger.kernel.org>; Sat,  5 May 2012 16:51:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The wip-rbd-wt branch has some potential changes to the rbd cache code.  
Currently, each image gets its own separate cache using its own pool of 
memory.  The ObjectCacher module has essentially three knobs:

 max size -- total bytes we'll cache
 max dirty -- max dirty bytes before a write will block and wait for writeback
 target dirty -- threshold at which we'll start writing back older buffers

(There's also a hard-coded max age value (~1 second) after which a dirty 
buffer will be written; that needs to be turned into a tunable.)

The first several patches add 'write-thru' caching support.  This is done 
by simply setting the max_dirty value to 0.  A write will then block until 
it is written to the cluster, but we still get the benefits of the read 
cache.

The second set of patches restructure the way the cache itself is managed.  
One goal is to be able to control cache behavior on a per-image basis 
(this one write-thru, this was write-back, etc.).  Another goal is to 
share a single pool of memory for several images.  The librbd.h calls to 
do this currently look something like this:

int rbd_cache_create(rados_t cluster, rbd_cache_t *cache, uint64_t max_size,
		     uint64_t max_dirty, uint64_t target_dirty);
int rbd_cache_destroy(rbd_cache_t cache);
int rbd_open_cached(rados_ioctx_t io, const char *name, rbd_image_t image,
		 const char *snap_name, rbd_cache_t cache);

Setting the cache tunables should probably be broken out into several 
different calls, so that it is possible to add new ones in the future.  
Beyond that, though, the limitation here is that you can set the 
target_dirty or max_dirty for a _cache_, and then have multiple images 
share that cache, but you can't then set a max_dirty limit for an 
individual image.

Does it matter?  Ideally, I supposed, you could set:

 - per-cache size
 - per-cache max_dirty
 - per-cache target_dirty
 - per-image max_dirty  (0 for write-thru)
 - per-image target_dirty

and then share a single cache for many images, and the flushing logic 
could observe both sets of dirty limits.  That just means calls to set 
max_dirty and target_dirty for individual images, too.

Is it worth the complexity?  In the end, this will be wired up to the qemu 
writeback options, so the range of actual usage will fall within 
whatever is doable with those options and generic 'rbd cache size = ..' 
tunables, most likely...

sage

