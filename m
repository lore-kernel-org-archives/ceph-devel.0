From: Sage Weil <sage@newdream.net>
Subject: rbd layering
Date: Mon, 31 Jan 2011 22:08:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34377 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab1BAGHt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 01:07:49 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EF390BC7EF
	for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 22:08:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D44A7BC7EF
	for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 22:08:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One idea we've talked a fair bit about is layering RBD images.  The idea 
would be to create a new image in O(1) time that mirrors on old image and 
get copy-on-write type semantics, like a writeable snapshot.

We've come up with a few different approaches for doing this, each with 
somewhat different performance characteristics.  The main consideration is 
that RBD images do not (currently) have an "allocation table."  Image data 
is simply striped over objects (that may or may not exist).  You read the 
object for a given block to see if it exists; if it doesn't (a "hole"), 
the content is defined to be zero-filled.

(I'll use the term "block" and "object" interchangeably to mean the object 
that stores each RBD block.  They're 4MB by default, but can be set to any 
size you want at image creation time.)

1- copy-up on first write
  - reads
    - read child image object.  if it doesn't exist, read parent block.
    -> reads to unchanged data are slower
  - writes
    - write to child image block.  if it doesn't exist, OSD will return 
      ENOENT.  the client would do a copy up (copy parent block to child 
      block), and then redo the write.
    -> first writes are slow, especially if the block existed in the parent.
  - trim/discard
    - truncate the child object to zero, but do not delete it.

2- sparse objects
  - make the OSDs maintain allocation metadata for each objects so that we 
    know which parts of the object are defined and which are holes (a 
    relatively easy thing to do).
  - writes
    - write to modified region of child object.
  - reads
    - read child image object AND allocation map.  read parent object for 
      any holes (or when child object doesn't exist)
    -> more efficient data transfer when objects are sparse.
    -> reads to unchanged data are slower (as above)
  - trim/discard
    - need to somehow distinguish between a hole that falls-thru to parent 
      and a hole that is defined to be zero by the child image.

In both cases, we could add a(n optional) allocation bitmap to the parent 
image to avoid the fall-thru for parts of the images that aren't defined 
by the child image.  That could be an explicit step taken by an 
adminstrator (e.g. after marking the parent read-only) to improve 
performance for overlayed images.  (Maintaining a consistent bitmap for 
all images is non-trivial, and would slow things down considerably.)

A few use cases for all of this:
 - "golden" VM images
 - writeable snapshots
 - image migration between pools
   - pause io
   - mark parent read-only
   - create "child" image
   - unpause io, redirect to the new child
   (these steps are all fast and O(1)!)
   - asynchronously copy-up parent blocks to the child (this is O(n))
   - once this is done, remove the child's parent reference and discard 
     the parent

sage
