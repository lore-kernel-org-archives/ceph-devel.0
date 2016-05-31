From: Sage Weil <sage@newdream.net>
Subject: Re: Random thought: adding a tracker custom field for feature/"topic"
 (separate to category/component)
Date: Tue, 31 May 2016 09:03:42 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605310859020.6221@cpach.fuggernut.com>
References: <CALe9h7eLOBYq+AHQU_kiB97NaPSg5Fmj90xSK7xyqLK8_TOa_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59221 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbcEaNDU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 09:03:20 -0400
In-Reply-To: <CALe9h7eLOBYq+AHQU_kiB97NaPSg5Fmj90xSK7xyqLK8_TOa_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 31 May 2016, John Spray wrote:
> Hi all,
> 
> Currently we have "Category", which is sort of a mixture of physical
> components (e.g. MDS, OSD, client, librados) and higher level
> features/topics.
> 
> Lots of tickets actually refer to both a feature and a component, for
> example in cephfs we have lots of tickets related to FSCK, and some of
> them are MDS changes while some are tool changes.  Currently we sort
> of work around this by prefacing things to subjects.
> 
> I'm thinking that maybe we need two fields, one saying which component
> (i.e. which subdir in the git tree), and one giving a higher level
> category (which I'm imagining calling "topics").
> 
> In a CephFS context, examples of components would be MDS, client,
> ceph-fuse, libcephfs, libcephfs-python, cephfs-volume-client, kernel
> client, hadoop plugin, samba plugin, ganesha plugin, tools,
> MDSMonitor, qa-suite.
> 
> ...whereas topics would be features that affect multiple components
> like: multi-mds, multi-fs, snapshots, fsck.
> 
> Thoughts?

Sounds good to me! This might be slighly tricky to set up in redmine (not 
sure if 'categories' is special or not).

sage
