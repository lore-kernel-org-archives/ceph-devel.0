From: Sage Weil <sage@newdream.net>
Subject: Roadmap update
Date: Sat, 3 Sep 2011 16:03:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109031533550.12865@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54009 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab1ICW62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Sep 2011 18:58:28 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 49D1DBC749
	for <ceph-devel@vger.kernel.org>; Sat,  3 Sep 2011 16:03:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0B1D3BC749
	for <ceph-devel@vger.kernel.org>; Sat,  3 Sep 2011 16:03:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

We spent some time this week working on our technical roadmap for the next 
few months.  It's all been mostly translated into issues and priorities in 
the tracker (see http://tracker.newdream.net/rb/master_backlogs/ceph for a 
sorted priority list), but from that level of gory detail it's hard to see 
the forest for the trees.

At a high level, the basic priorities are:

 - osd, librados, RGW, single-mds stabilization
 - RBD (rados block device) and virtualization
 - packaging, general usability of tools, better docs
 - OpenStack integration (mainly RBD, but also RGW)
 - Hadoop integration
 - clustered MDS stability

A bit more specifically, the priority list goes something like:

 - expand OSD QA coverage
 - RPMs, documentation, tools
 - RBD performance improvements
 - expand QA coverage to include (non-failure) multi-mds configurations
 - basic RBD layering (copy-on-write images)
 - OpenStack integration (starting with RBD backend for glance)
 - Hadoop testing, QA coverage
 - libvirt support for kernel RBD driver (and with it support for 
   RBD with non-KVM hypervisors)
 - improved RBD layering (various optimizations to improve performance)
 - libvirt support for RBD pools (and with it e.g. gui support via 
   virt-manager)
 - RGW support for object versioning, google storage api

There are several mostly parallel goals we are pursuing here, so in the 
end figuring out which pieces to work on at any point of time is always a 
bit of a challenge (especially when it comes to features vs bugs vs qa).  
There will inevitably be some shift in what ends up in each release (every 
2-3 weeks).

In case it isn't clear from the above, improving stability and testing 
coverage continues to be a key goal. We tend to focus on bugs we currently 
see (or users are seeing), and expand testing on the core systems first.  
Although there isn't much about the file system on this list, cfuse and 
kclient testing are already fairly well covered in our test suite, and 
that continues to expand.  It just isn't our primary focus at this point.

Questions/comments welcome!  If any of these areas interests you in 
particular (from a technical, business, or potential employment 
perspective), we would of course love to hear from you.

sage
