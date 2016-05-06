From: Sage Weil <sweil@redhat.com>
Subject: bluestore update
Date: Fri, 6 May 2016 18:01:39 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605061742550.6867@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57218 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758916AbcEFWB3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 18:01:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ifedotov@mirantis.com

I'm spent some time this week updating the current IO code to use the new 
extent and blob structures. The result is in

	https://github.com/ceph/ceph/pull/8928

It builds, and runs through the ceph_test_objectstore Synthetic test for a 
a few thousand iterations before blowing up.  There are bugs in the 
COW-related code that I haven't tracked down, and I'm not sure it's worth 
doing that since most of it will get rewritten again anyway.

This is based on Igor's original type patch, with some cleanups and 
updates (e.g., the bluestore_blob_t::map and mapbl helpers).

I'm flipping back and forth between looking over how the current write 
path is structures (allocate everything, squirrel away some magic 
flags to guide cow behavior, iterate over allocated extents and write them 
out) vs how Igor's ExtentManager is structured (punch lextent holes, 
allocate blob, write into blob) and I'm not very happy with either one.  
The new code doesn't capture almost any of the hard parts the old one 
handled (when to COW vs WAL vs write to new extent, partial block 
updates, etc.).

I think what would make the most sense is a simple breakdown of the write 
into three parts:

 middle - the portion of the write that is min_alloc_size aligned and can 
be written to a fresh region of disk.  this is the easy part.
 front - anything before middle that must either wal or cow+wal
 tail - anything after middle that must either wal or cow+wal (or take a 
special append path)

Then the process would be something like

 - separate into the 3 regions
 - prepare blobs, lextents, and wal events for each region
 - allocate pextents for any new blobs
 - deref old blobs
 - submit io

That way the second step can do the compression and we'll end up with a 
list of new blobs and their associated buffers.  either we allocate the 
full size for a raw write, or compress and allocate something smaller.

The lextent+blob representation is a lot more flexible than what we had 
before, allowing things like zero() and truncate() to be trivial updates 
of the lextent map.  The question is whether we want to allow sparse, 
byte-granuarlity lextent -> blob mappings.  It'll make the code a bit more 
complex when deciding whether we can write data into an existing blob.  
(OTOH, I think we have to have much of that anyway.)

I experimented a bit with a Checksummer class that captures what the 
ChecksumInterface was describing and plugs in crc32c and xxhash32 (so 
far).  Not sure yet if we should add blob_t methods that use it directly 
(it has all the csum_data and related fields, so it'd be easier to use 
that way).

Anyway, I think there are a couple of ways to proceed...

 - the read path is unrelated to any of the write complexities--it just 
needs to faithfully return data based on the extent/blob structures.  We 
can focus on structuring that nicely, since it's a simpler case.

 - I added a ref_map to blob_t to track which portions of a blob are 
still referenced (so that parts of it can be deallocated, or we can 
split, or whatever).  Nothing in place to do that, though.. we'll want 
something like ExtentManager::deref_blob, I think.

 - get an ExtentManager-like interface in place so that it is easier to 
experiment with read/write/truncate strategies.  i'm still not convinced 
we need the block_* methods if all IO is planned in a structured way 
before being submitted.

Igor, I think you said you're back from vacation next week?  Let's touch 
base on Monday to make a plan?

sage
