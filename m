From: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 09:38:32 -0800
Message-ID: <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from services.cse.ucsc.edu ([128.114.48.10]:37659 "EHLO
	services.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab0K3Rig convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 12:38:36 -0500
In-Reply-To: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

Noah,

There shouldn't be too much redundancy between here and the forked thread.


On Nov 29, 2010, at 22:33 , Noah Watkins wrote:

> Hi Alex,
> 
> I have some feedback for this patch. The first is a question about the correctness of your method of retrieving block locations, and what the notion of a Hadoop block means in the context of Ceph, and the second is a design suggestion. 
> 
> Correctness of Block Location Retrieval
> ===============================
> 
> The following example is in relation to the JNI c++ code that creates the list of block locations by querying the IOCTL interface of a file in Ceph:
> 
> +  jlong loopinit=j_start/blocksize;
> +  jlong i=loopinit;
> +  for (jlong imax=j_start+j_len; i*blocksize < imax; i++) {
> +    //Note <=; we go through the last requested byte.
(As always, the code evolves past the (inline) documentation.)
> +    //Set up the data location object
> +    curoffset = i*blocksize;
> +    dl.file_offset = curoffset;
> 
> It appears to me that this code does not fully consider the striping strategy that Ceph implements. More specifically this code appears to only work when the object size and striping unit are equal for a given file (something that is likely set by default).
You're correct, I didn't put in any assumptions for fl_stripe_unit and fl_object_size being different.  The matching defaults are in <ceph>/src/config.cc, in the struct ceph_file_layout g_default_file_layout.

> The following is for the case in which object size is not equal to the stripe unit.
> 
> Consider the following contrived setup for a file in Ceph from which Hadoop tries to acquire all object locations (i.e. Hadoop blocks):
> 
> Object size: 3 MB
> Stripe unit: 1 MB
> Stripe count: 3
> File size: 18 MB
> ==> Thus, 6 objects (0, 1, ..., 5)
> 
> If j_start = 0 and j_len = 18 MB then the loop above queries Ceph about the objects containing the following offsets:
> 
> 0 * blocksize = 0 MB
> 1 * blocksize = 3 MB
> 2 * blocksize = 6 MB
> 3 * blocksize = 9 MB
> 4 * blocksize = 12 MB
> 5 * blocksize = 15 MB
> 
> However, given that the object size and stripe unit are not equal, the objects don't fill up uniformly as a multiple of object size:
> 
> The above would result in Ceph reporting the following object numbers, missing objects (1, 2, 4, 5):
> 
> Offset --> Object Number
> 0 MB --> 0
> 3 MB --> 0
> 6 MB --> 0
> 9 MB --> 3
> 12 MB --> 3
> 15 MB  --> 3
> 
> This is easy to remedy by implementing the striping strategy in your code, but I think is also an opportunity for cleaning up the design a bit.
> 
> What is a Hadoop Block in Ceph?
> ==========================
> 
> Hadoop considers blocks to be contiguous extents, however, from the above example we can see that an object can have data from multiple, non-consecutive, contiguous extents, thus the object itself doesn't represent a fully contiguous extent.
I didn't follow your numeric examples above---I missed how you mapped Offsets to Object Numbers---but I follow you on striping meaning different data locations for what Hadoop would think would be one Ceph object in one place.
> 
> The more natural (and general) solution is to consider the stripe unit to be the _unit_ of Hadoop blocks, not entire objects. When stripe unit and block size are the same the result is analogous to HDFS's treatment of blocks.
I agree with you, and push forward one more step:  Ceph and Hadoop should just think of a block/object as the same size.  One of the TODO's is exposing Ceph's object size to Hadoop, and that "read" interface for block size will probably need to expand to a "write" interface to reduce confusion with folks configuring Hadoop to use a block size of N bytes.  (This train of thought spawned the resolved Ceph tracker item here: http://tracker.newdream.net/issues/185 .)  The Hadoop configuration block size would have to propagate down to the Ceph file layout configuration.  It may be that the functionality's already there in Hadoop and Ceph and just needs glue, I'm not sure.

> 
> Design Suggestion
> ===============
> 
> I would propose moving the functionality of mapping offsets to object locations into a library managed in the Ceph tree, and either 1) use JNI as a thin layer to this library, or 2) scrap JNI altogether for JNA.
After writing this code, I do like seeing the words "scrap" and "JNI" so close in the same sentence.  That's more up to the Hadoop community, though; I don't know how well-accepted JNA is in their code base.

The ioctl struct ceph_ioctl_dataloc already returns the primary copy's object offset for an input file offset, though I think it would be a little more useful if it included replica offsets.  Since that interface won't change (referencing the forked message thread), getting a single offset shouldn't mean any new code for Ceph.  If it looks like it's clumsy to actually _get_ the block offset judging from my code, just consider that code inflation from all my safety/debug JNI checks.  I'm not calling it pretty or elegant by any stretch.
> 
> Either way, the motivation for moving this functionality into the Ceph tree is important because from the point of view of Hadoop object/block location is independent of striping strategy.
I wasn't aware Hadoop had a built-in consideration for striping strategy.  grep'ing over the Hadoop code for "stripe" and "stripi" returns 0 hits.

> Future Ceph enhancements and research may use alternative striping strategies which would thus have to be re-duplicated into the Hadoop code base.
It sounds to me like Hadoop needs some code to determine or set striping strategy (independent of Ceph's logistics), if this technical point is going to come up repeatedly in future research.  Maybe the Ceph file system class would be a good place to try this out?  Going up higher in the class hierarchy may mean confusion for HDFS.

--Alex


> 
> Thanks,
> Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

