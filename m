From: Sage Weil <sweil@redhat.com>
Subject: Re: rados bench object not correct errors on v9.0.3
Date: Tue, 25 Aug 2015 10:42:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508251041260.13116@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbbHYRmn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Aug 2015 13:42:43 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, piotr.dalek@ts.fujitsu.com

On Tue, 25 Aug 2015, Deneau, Tom wrote:
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Monday, August 24, 2015 12:45 PM
> > To: ceph-announce@ceph.com; ceph-devel@vger.kernel.org; ceph-users@ceph.com;
> > ceph-maintainers@ceph.com
> > Subject: v9.0.3 released
> > 
> > This is the second to last batch of development work for the Infernalis
> > cycle.  The most intrusive change is an internal (non user-visible) change to
> > the OSD's ObjectStore interface.  Many fixes and improvements elsewhere
> > across RGW, RBD, and another big pile of CephFS scrub/repair improvements.
> > 
> > 
> > Getting Ceph
> > ------------
> > 
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball at http://ceph.com/download/ceph-9.0.3.tar.gz
> > * For packages, see http://ceph.com/docs/master/install/get-packages
> > * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-
> > deploy
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> > body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> 
> I have built rpms from the tarball http://ceph.com/download/ceph-9.0.3.tar.bz2.
> Have done this for fedora 21 x86_64 and for aarch64.  On both platforms when I run
> a single node "cluster" with a few osds and run rados bench read tests
> (either seq or rand) I get occasional reports like
> 
> benchmark_data_myhost_20729_object73 is not correct!
> 
> I never saw these with similar rpm builds on these platforms from 9.0.2 sources.
> 
> Also, if I go to an x86-64 system running Ubuntu trusty for which I am able to
> install prebuilt binary packages via
>     ceph-deploy install --dev v9.0.3
> 
> I do not see the errors there.

Hrm.. haven't seen it on this end, but we're running/testing master and 
not 9.0.2 specifically.  If you can reproduce this on master, that'd be 
very helpful!

There have been some recent changes to rados bench... Piotr, does this 
seem like it might be caused by your changes?

sage


