From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: tendrl stragegy for ceph cluster map hierarchy
Date: Wed, 8 Mar 2017 14:52:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703081442540.1727@piezo.novalocal>
References: <bf3c1e56-5355-7b68-69ac-e2082089542b@redhat.com> <85cfd1d7-d808-69a4-4258-44acf8ae1be9@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48251 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdCHPCj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 10:02:39 -0500
In-Reply-To: <85cfd1d7-d808-69a4-4258-44acf8ae1be9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Bukatovic <mbukatov@redhat.com>
Cc: ceph-devel@vger.kernel.org, tendrl-devel@redhat.com

Hi Martin,

On Wed, 8 Mar 2017, Martin Bukatovic wrote:
> Dear Ceph community,
> 
> I'm trying to understand how ceph cluster hierarchy feature relates
> and affects Tendrl project (http://tendrl.org/), which tries to
> provide web UI and API for ceph (and gluster) management.
> 
> The problem is that my understanding is based solely on reading
> Sage's thesis, documentation and playing around with toy sized
> clusters. So I would definitely appreciated someone with better
> understanding of ceph to check my thinking here. I'm forwarding
> my tendrl post below.
> 
> Btw: Tendrl project definitely welcomes you to show your
> opinions about tendrl plans/ides on tendrl-devel list :)

Joined!

> -------- Forwarded Message --------
> Subject: tendrl stragegy for ceph cluster map hierarchy
> Date: Wed, 8 Mar 2017 11:08:23 +0100
> From: Martin Bukatovic <mbukatov@redhat.com>
> Organization: Red Hat
> To: tendrl-devel@redhat.com
> 
> Dear Tendrl community,
> 
> I recently reviewed chapter 5 "Data Distribution" from Sage's Ceph
> thesis[1],
> (since I try to improve my understanding of Ceph in general) and noticed the
> importance of "cluster map hierarchy" (aka CRUSH Map Bucket Hierarchy[2]).
> 
> In short, it's a tree structure in which:
> 
> * nodes are called "buckets"
> * leaf nodes represent OSDs
> * inner (non leaf) nodes has a "bucket type", which influences efficiency
>   and performance of cluster operations on OSDs and data stored there
> 
> Design of this structure is important for performance, planned usage 
> patterns, cluster expansion and failure domains (which means that poorly 
> designed hierarchy could result in data loss which could be prevented if 
> proper design had been used instead).
> 
> Eg. one could define bucket node for each rack, which would make 
> possible to define crash rules to make sure that at least one replica is 
> placed in different rack to prevent data loss when particular rack is 
> down/lost. Without proper cluster hierarchy, it's not possible to 
> achieve that.
> 
> If you are not familiar with the concept and are working or interested 
> in features dealing with cluster import or creation, I would suggest to 
> definitely check either mentioned chapter from the thesis or ceph 
> documentation.
> 
> So the big question here is *how is Tendrl planning to work with this 
> feature*?
> 
> We definitely can't ignore this now. Tendrl needs to have a clear 
> strategy here from the beginning as this is something which can't be 
> added or changed later easily.
> 
> Since this is core low level feature, there is no particular use case JIRA
> for it. That said handling of cluster hierarchy is imho core part of the
> following JIRAs:
> 
> * TEN-2 Install Ceph 2.x Cluster
> * TEN-4 Import a Ceph 2.x Cluster
> * TEN-164 UX: Create Ceph Cluster Design
> * TEN-190 Create Ceph cluster via UI
> 
> My opinion is that we need to be able at least:
> 
> * import any valid/supported cluster cluster with it's hierarchy, without
>   breaking ceph or tendrl
> * communicate clearly with tendrl admin user how the cluster hierarchy created
>   during ceph cluster creation would look like
> * make it possible for admin to define cluster hierarchy manually if he decides
>   that what tendrl provides doesn't fit his needs
> * design the tendrl architecture/code so that it's possible to add additional
>   cluster map setup features, validation later without significant refactoring
>   of tendrl code

The "master" copy of the cluster hierarchy (datacenters, rows, racks, 
hosts, devices) is the CRUSH map.  Ceph makes this easily accessible in 
JSON form, and provides a series of commands that let you adjust the 
hierachy (moving nodes of the tree around), so I think this is primarily a 
UI issue.

Usually the OSDs know enough to put the devices under the correct host, 
but usually hosts don't know where they exist within the larger cluster.  
(There are hooks to do this on the host, but it currently relies on 
something like ansible or chef or puppet to put this somewhere in /etc so 
that we can tell which rack etc the host lives in.)  That means it's 
usually the admin who ensure the hosts are positioned properly in the 
overall hierarchy.  So probably teh first thing would be to make the GUI 
let you create racks/rows/datacenters/whatever and drag parts of the tree 
around.

As far as visualizing the cluster, the key thing I think we should address 
from the get-go is how to do it in a way that will scale gracefully to 
clusters with 100s, 1000s, and 10000s of OSDs.  The most promising 
thing I've seen (and admittedly I haven't seen much) was from a 
paper someone (Loic?) sent around a few weeks ago:

	http://www.aviz.fr/wiki/uploads/Teaching2014/bundles_infovis.pdf

See, for example Fig 1 and Fig 13a.  The circle grouping can scale down as 
the cluster scales up (or you zoom in/out).  (And the actual subject 
of the paper--data flows--can be applied to show things like data movement 
during rebalancing/recovery or proposed CRUSH changes.)

sage
