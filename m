From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Machine hangs while writing to ceph filesystem
Date: Fri, 21 Sep 2012 16:23:48 -0400
Message-ID: <201209212023.q8LKNm45003481@ayesha.phys.virginia.edu>
Reply-To: bryan@Virginia.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:40631 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab2IUUfj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Sep 2012 16:35:39 -0400
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id q8LKNm45003481
	for <ceph-devel@vger.kernel.org>; Fri, 21 Sep 2012 16:23:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

	I've just started working with ceph, and I'm finding that
whenever a 32-bit client mounts the ceph filesystem and tries
to copy something into it, the client host hangs after some
random, small, amount of data has been copied.  The last error
messages displayed are:

 kernel:Process kworker/0:0 (pid: 4913, ti=f6042000 task=f6008a90 task.ti=f6042000)
 kernel:Stack:
 kernel:Call Trace:
 kernel:Code: 15 48 95 70 c1 81 ea 00 c0 5c 00 81 e2 00 00 e0 ff 29 d0 c1 e8 0c 8b 14 85 a0 82 8e c1 83 ea 01 85 d2 89 14 85 a0 82 8e c1 75 04 <0f> 0b eb fe 31 c0 83 fa 01 75 0f 31 c0 81 3d f0 cc 71 c1 f0 cc
 kernel:EIP: [<c1116fff>] kunmap_high+0x4f/0xa0 SS:ESP 0068:f6043e6c

The client host is running 32-bit Centos 6.3, with the elrepo 3.5.4
kernel.  The osd, mon and mds machines are all 64-bit Centos 6.3, with
the stock Centos 2.6.32 kernel.  The ceph version in all cases is
0.48.2.  The OSDS are using XFS for their data stores.

	There are no error messages in the ceph logs.

	After rebooting the client machine and re-mounting the
ceph filesystem, I can see that some files were, indeed, copied,
but "du" gives an error message indicating that there are circular
directory references, and that the filesystem is probably corrupt.

	After wiping out the osds and re-creating the ceph cluster,
the same thing happens.

	Any advice about how to debug this would be appreciated.

					Thanks,
					Bryan


-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================

