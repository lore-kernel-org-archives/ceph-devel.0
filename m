From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] Status of snapshots in CephFS
Date: Fri, 19 Sep 2014 08:25:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409190820570.18018@cobra.newdream.net>
References: <CAPUexz_pGTXdjbw90HKDQPzfXQNY=vormfxwvDLWpMvhD+eOYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44170 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbaISPZq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 11:25:46 -0400
In-Reply-To: <CAPUexz_pGTXdjbw90HKDQPzfXQNY=vormfxwvDLWpMvhD+eOYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

On Fri, 19 Sep 2014, Florian Haas wrote:
> Hello everyone,
> 
> Just thought I'd circle back on some discussions I've had with people
> earlier in the year:
> 
> Shortly before firefly, snapshot support for CephFS clients was
> effectively disabled by default at the MDS level, and can only be
> enabled after accepting a scary warning that your filesystem is highly
> likely to break if snapshot support is enabled. Has any progress been
> made on this in the interim?
> 
> With libcephfs support slowly maturing in Ganesha, the option of
> deploying a Ceph-backed userspace NFS server is becoming more
> attractive -- and it's probably a better use of resources than mapping
> a boatload of RBDs on an NFS head node and then exporting all the data
> from there. Recent snapshot trimming issues notwithstanding, RBD
> snapshot support is reasonably stable, but even so, making snapshot
> data available via NFS, that way, is rather ugly. In addition, the
> libcephfs/Ganesha approach would obviously include much better
> horizontal scalability.

We haven't done any work on snapshot stability.  It is probably moderately 
stable if snapshots are only done at the root or at a consistent point in 
the hierarcy (as opposed to random directories), but there are still some 
basic problems that need to be resolved.  I would not suggest deploying 
this in production!  But some stress testing woudl as always be very 
welcome.  :)

> In addition, https://github.com/nfs-ganesha/nfs-ganesha/wiki/ReleaseNotes_2.0#CEPH
> states:
> 
> "The current requirement to build and use the Ceph FSAL is a Ceph
> build environment which includes Ceph client enhancements staged on
> the libwipcephfs development branch. These changes are expected to be
> part of the Ceph Firefly release."
> 
> ... though it's not clear whether they ever did make it into firefly.
> Could someone in the know comment on that?

I think this is referring to the libcephfs API changes that the cohortfs 
folks did.  That all merged shortly before firefly.

By the way, we have some basic samba integration tests in our regular 
regression tests, but nothing based on ganesha.  If you really want this 
to the work, the most valuable thing you could do would be to help 
get the tests written and integrated into ceph-qa-suite.git.  Probably the 
biggest piece of work there is creating a task/ganesha.py that installs 
and configures ganesha with the ceph FSAL.

sage
