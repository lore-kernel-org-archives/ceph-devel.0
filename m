From: Sage Weil <sweil@redhat.com>
Subject: RE: fadvise status
Date: Thu, 4 Dec 2014 07:08:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412040706460.18213@cobra.newdream.net>
References: <6AA21C22F0A5DA478922644AD2EC308C8F9021@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1412022136370.24518@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8F9EA7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbaLDPIF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Dec 2014 10:08:05 -0500
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C8F9EA7@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 4 Dec 2014, Ma, Jianpeng wrote:
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Thursday, December 4, 2014 2:57 PM
> > To: Ma, Jianpeng
> > Cc: sjust@redhat.com; ceph-devel@vger.kernel.org
> > Subject: fadvise status
> > 
> > Hey,
> > 
> > I'm getting caught up after being out most of last week.  I see:
> > 
> > https://github.com/ceph/ceph/pull/2964
> > 
> > 	client side librados and librbd changes.  ready to go
> > 
> > https://github.com/ceph/ceph/pull/2988
> > 
> > 	osd changes.  look good, but needs a rebase (merge conflict?) and a test.
> > I think at this point you should rebase everything into a single branch so that
> > you can use the client-side stuff to add some simple functional tests in
> > ceph_test_rados_api_[a]io.
> Yes,  merge into a single branch(met one conflict) and WIP on test case.
> > 
> > https://github.com/ceph/ceph/pull/2817
> > 
> > 	I think this is superceded by the above changes.. can we just close it?
> > 
>  In my two pull requests don't contain this. I think they are independent. 
> If you don't have disagreement on 2817. I think you can merge.

Can you review https://github.com/ceph/ceph/pull/3080 ?

I rebased this into a different patch and combined this with the old 
filestore_replica_fadvise.  THis will need to go through the test suite 
(and possibly powercycle suite) to make sure it's safe; we original 
stopped doing this because the comobination of sync_file_range and fadvise 
was triggering a corruption in XFS on power loss, but we don't do 
sync_file_range anymore.

Thanks!
sage
