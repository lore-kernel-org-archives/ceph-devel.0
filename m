From: Sage Weil <sage@newdream.net>
Subject: rbd layering
Date: Fri, 25 Feb 2011 14:27:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102251347400.23080@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37286 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab1BYWZb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 17:25:31 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8EC0BBC75B
	for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 14:27:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 58E9FBC75B
	for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 14:27:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I wanted to follow up on the thread a couple weeks back and summarize 
where we're currently at.  The goal is to be flexible, so that we don't 
impose any performance limits for features we don't use.  

The use cases are:

 - (fast) image creation from gold master (probably followed by growing 
the image/fs)
 - image migration (create child in new location; copyup old data 
asynchronously)


Here are the pieces we currently have:

(image == rbd image
 object == one object in the image, normally 4MB)

- Parent image pointer

Each image has an option parent pointer that names a parent image.  The 
parent must be part of the same cluster, but can be in a different pool.  
It can be larger or smaller than the current image. 

It is assumed the parent is read-only.  I don't think anything sane can 
come out of doing a COW overlay over something that is changing.

- Object Bitmap

Each object in an image may have an OPTIONAL bitmap that represents 
transparency.  If the bit is set, then it is defined by this image layer 
(it can be either object data or, if the object has a hole, zeros).  If 
the bit is not set, then the content is defined by the parent image.  The 
resolution can be sector, 4KB block, or anything else.  If it is larger 
than the smallest write unit, a write may require copy-up from the lower 
layer, so using the block size is recommended.

If the object bitmap does not exist, we assume the object is NOT 
transparent (i.e. bitmap is fully colored).  That gives us compatibility 
with old images, and lets us drop the bitmap once it gets fully colored.  
Only new images that support layering will create/use it.  

- Image bitmap

Each image may have an OPTIONAL bitmap that indicates which image objects 
(may) exist.  On write, a bit is set prior to creating the each object.  
On read, if a bitmap exists but the bit for an object is not set, we can 
go directly to the parent image.  If the bitmap does not exist, reads must 
always check for the child object before falling through to the parent 
image.  Writes in the no-bitmap case write to the child object.  If The 
bitmap size need not match the image size; it may, e.g., match the size of 
a smaller parent image.

Having two bitmaps is a design tradeoff.  We could a sector/block 
resolution bitmap for the whole image, but it would increase memory use, 
and would require more "update image bitmap, wait, then write to object" 
cycles.  Having a per-object bitmap means we can atomically update the 
object bitmap for free when we do the write, and minimize the image bitmap 
updates to the first time each object is touched.

On read:
	if there is an image bitmap
		if bit is set
			read child object
			if there's an object bitmap that indicates transparency
				read holes from parent object
		else
			read parent object (*)
	else
		read child object
		if there is no child object, or bitmap indicates transparency
			read holes from parent object (*)

On write:
	if there is an image bitmap and bit is not set
		color image bitmap bit for this object
	if object bitmaps are enabled
		write to object
		color object bits too
	else
		if we are not writing the entire object    (*)
			read unwritten parts from parent   (*)
		write our data (+ copyup data from parent)

(*) These steps can be skipped if the parent image has holes here.  We 
would know that if the parent image bitmap bits are not set, or if we are 
past the end of the parent image size.

On trim/discard:
	if there is an image bitmap
		if bit is not set
			set image bitmap bit		
	truncate or zero object
	if object bitmap
		color appropriate bits


Also: the image bitmap could be created after the fact.  I.e. once we 
decide to use something as a gold image/parent, we would generate the 
image bitmap (just check which objects exist) so that overlays would 
operate more efficiently.  We'll probably want a read-only flag in the 
image header too to help keep admins from shooting themselves in the foot.


- OSD copyup/merge operation

The last piece would be an OSD method to atomically copy a parent object 
up to the overlay image.  The goal is for the copyup to be a background, 
maybe low-priority process.  We would read the parent object, then submit 
it to the child object, only write the parts that correspond to non-set 
bits in the object bitmap, and then color in all bits.


That's the current design.  Thoughts on or errors with the above?

sage

