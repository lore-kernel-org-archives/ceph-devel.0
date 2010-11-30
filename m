From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Mon, 29 Nov 2010 22:33:29 -0800
Message-ID: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:43137 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab0K3Glw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 01:41:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

Hi Alex,

I have some feedback for this patch. The first is a question about the correctness of your method of retrieving block locations, and what the notion of a Hadoop block means in the context of Ceph, and the second is a design suggestion. 

Correctness of Block Location Retrieval
===============================

The following example is in relation to the JNI c++ code that creates the list of block locations by querying the IOCTL interface of a file in Ceph:

+  jlong loopinit=j_start/blocksize;
+  jlong i=loopinit;
+  for (jlong imax=j_start+j_len; i*blocksize < imax; i++) {
+    //Note <=; we go through the last requested byte.
+    //Set up the data location object
+    curoffset = i*blocksize;
+    dl.file_offset = curoffset;

It appears to me that this code does not fully consider the striping strategy that Ceph implements. More specifically this code appears to only work when the object size and striping unit are equal for a given file (something that is likely set by default). The following is for the case in which object size is not equal to the stripe unit.

Consider the following contrived setup for a file in Ceph from which Hadoop tries to acquire all object locations (i.e. Hadoop blocks):

Object size: 3 MB
Stripe unit: 1 MB
Stripe count: 3
File size: 18 MB
==> Thus, 6 objects (0, 1, ..., 5)

If j_start = 0 and j_len = 18 MB then the loop above queries Ceph about the objects containing the following offsets:

0 * blocksize = 0 MB
1 * blocksize = 3 MB
2 * blocksize = 6 MB
3 * blocksize = 9 MB
4 * blocksize = 12 MB
5 * blocksize = 15 MB

However, given that the object size and stripe unit are not equal, the objects don't fill up uniformly as a multiple of object size:

The above would result in Ceph reporting the following object numbers, missing objects (1, 2, 4, 5):

Offset --> Object Number
0 MB --> 0
3 MB --> 0
6 MB --> 0
9 MB --> 3
12 MB --> 3
15 MB  --> 3

This is easy to remedy by implementing the striping strategy in your code, but I think is also an opportunity for cleaning up the design a bit.

What is a Hadoop Block in Ceph?
==========================

Hadoop considers blocks to be contiguous extents, however, from the above example we can see that an object can have data from multiple, non-consecutive, contiguous extents, thus the object itself doesn't represent a fully contiguous extent.

The more natural (and general) solution is to consider the stripe unit to be the _unit_ of Hadoop blocks, not entire objects. When stripe unit and block size are the same the result is analogous to HDFS's treatment of blocks.

Design Suggestion
===============

I would propose moving the functionality of mapping offsets to object locations into a library managed in the Ceph tree, and either 1) use JNI as a thin layer to this library, or 2) scrap JNI altogether for JNA.

Either way, the motivation for moving this functionality into the Ceph tree is important because from the point of view of Hadoop object/block location is independent of striping strategy. Future Ceph enhancements and research may use alternative striping strategies which would thus have to be re-duplicated into the Hadoop code base.

Thanks,
Noah