From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 0/2] ceph osd: initial VMware VAAI support
Date: Fri, 11 Mar 2016 11:03:45 +0100
Message-ID: <20160311110345.33d8028c@echidna.suse>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
	<1457591672-17430-1-git-send-email-mchristi@redhat.com>
	<56E11607.8070200@redhat.com>
	<20160310130423.1383631a@echidna.suse>
	<56E1F912.1000509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59790 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbcCKKDr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Mar 2016 05:03:47 -0500
In-Reply-To: <56E1F912.1000509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>, ceph-devel@vger.kernel.org

Hi Josh,

On Thu, 10 Mar 2016 14:45:38 -0800, Josh Durgin wrote:

> On 03/10/2016 04:04 AM, David Disseldorp wrote:
> > On Thu, 10 Mar 2016 00:36:55 -0600, Mike Christie wrote:
> >
> > ...
> >>> This does not include support for XCOPY/extended copy. I
> >>> am still looking into this, but it seems it might be
> >>> difficult to support due to rbd being more tuned to cloning
> >>> entire devices. When we implement VASA, the cloneVirtualVolume
> >>> might be something we can support though.
> >
> > I suppose the src-and-dest-in-same-pg requirement would complicate
> > things quite a bit, but wouldn't clonerange be an option for XCOPY
> > offloads?
> 
> It's not a good fit, since with multiple clones putting data on the
> same set of osds, the workload and space utilization gets skewed for
> that set of osds compared to the rest of the cluster.
> 
> It also won't give you fast cloning - it's a full copy on xfs, and
> you'd need to do one for every object affected.

Currently the copy is being done on the LIO iSCSI gateway, so offloading
any of that to the OSDs would save a lot of network traffic.

Also as Ric mentioned, XFS has clone-range support coming, so Ceph's
dedupe COW optimisations need not only be limited the Btrfs Filestore.

> Due to these limitations, lack of existing clonerange use, and the
> complications it brings to the osd as the only op affecting more than
> one object, we've talked about removing the clonerange op.

Okay, fair enough. Thanks for the details.

Cheers, David
