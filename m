From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: HSM
Date: Tue, 12 Nov 2013 09:47:20 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE69DEBF@PLOXCHG03.cern.ch>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:11314 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758Ab3KLJrZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 04:47:25 -0500
In-Reply-To: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, 
I think you need to support the following functionality to support HSM (file not block based):

1 implement a trigger on file creation/modification/deletion

2 store the additional HSM identifier for recall as a file attribute

3 policy based purging of file related blocks (LRU cache etc.)

4 implement an optional trigger to recall a purged file and block the IO (our experience is that automatic recalls are problematic for huge installations if the aggregation window for desired recalls is short since they create inefficient and chaotic access on tapes)

5 either snapshot a file before migration, do an exclusive lock or freeze it to avoid modifications during migration (you need to have a unique enough identifier for a file, either inode/path + checksum or also inode/path + modification time works)

The interesting part is the policy engine:

Ideally one supports time based and volume triggered policies with meta data matching e.g. 

a) time based : one needs to create a LRU list e.g. have a view of all files matching a policy by creation and or  access time. 
Example: "evict files from the filesystem when they are not accessed since 1 month"

b) volume triggered : one needs to create a LRU list by creation and or access time and files are evicted from disks when a certain high-watermark is reached until the volume goes under a low-watermark
Example "evict files matching size/name/... criteria if the pool volume or subtree exceeds 95% to reach 90% usage"

Backup and archiving is simple compared to the above LRU policies.

You need the possibility to create this LRU view from scratch (e.g. full-table scan) and afterwards you could use incremental updates via trigger. 

Ideally one has a central view (on a subtree) and apply the policy there but this is not scalable as the rest of CEPH. It has the same problem like quota accounting by uid/gid on a subtree with the complication that you have to maintain a possibly huge file list sorted by ctime/mtime and or atime. CEPHFS stores directories as objects but you cannot apply policies on a the individual directory level, so it has to be at least at pool level or subtree level. If one trades the flexibility of policies one can keep the LRU view small. There is also no need to track each change of an atime, one could track atime for the LRU view with a granularity of days to avoid too many updates.

Now if you don't want to implement this LRU view you can outsource it to an external DB and ship the scalability issue and update frequency issue to the DB :-) and just provide the migration/recall hooks and attribute support. Maybe your idea was to integrate with RobinHood ... currently it seems tightly integrated with Lustre internals.

The HSM logic looks similiar to the peering logic you need for erasure coding to trigger eviction and recall. If you have the ctime/mtime/atime information on entries in directory objects and not on data objects it is sort of corresponding. With ctime/mtime only it is much more lightweight.

I actually wanted to make a BluePrint proposal for meta data searches in subtrees running as a method on the MDS objects which would provide the needed functionality for the HSM views. Although this is a full subtree scan it would be actually nicely distributed on the MDS backend pool and not on the MDS itself. The output of the search could go into temporary objects which are then converted into HSM actions like migration/deletion trigger etc.

I would favour this approach rather than relying on more and more external components since it is easy to do in CEPH.

FYI: there was a paper about migration policy scanning performance by IBM two years ago: 
http://domino.watson.ibm.com/library/CyberDig.nsf/papers/4A50C2D66A1F90F7852578E3005A2034/$File/rj10484.pdf

Cheers Andreas.




 





________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Sage Weil [sage@inktank.com]
Sent: 09 November 2013 09:33
To: ceph-devel@vger.kernel.org
Subject: HSM

The latest Lustre just added HSM support:

        http://archive.hpcwire.com/hpcwire/2013-11-06/lustre_scores_business_class_upgrade_with_hsm.html

Here is a slide deck with some high-level detail:

        https://jira.hpdd.intel.com/secure/attachment/13185/Lustre_HSM_Design.pdf

Is anyone familiar with the interfaces and requirements of the file system
itself?  I don't know much about how these systems are implemented, but I
would guess there are relatively lightweight requirements on the fs (ceph
mds in our case) to keep track of file state (online or archived
elsewhere).  And some hooks to trigger migrations?

If anyone is interested in this area, I would be happy to help figure out
how to integrate things cleanly!

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
