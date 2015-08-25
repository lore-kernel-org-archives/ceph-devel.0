From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: rados bench object not correct errors on v9.0.3
Date: Tue, 25 Aug 2015 21:14:29 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91924D7FFC@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1508251041260.13116@cobra.newdream.net>
 <BC97738F8E7C8742BABED7F06FB9DF91924D7ECD@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0136.outbound.protection.outlook.com ([207.46.100.136]:24209
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751865AbbHYVOf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2015 17:14:35 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91924D7ECD@SATLEXDAG01.amd.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "piotr.dalek@ts.fujitsu.com" <piotr.dalek@ts.fujitsu.com>



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Deneau, Tom
> Sent: Tuesday, August 25, 2015 1:24 PM
> To: Sage Weil
> Cc: ceph-devel@vger.kernel.org; ceph-users@ceph.com;
> piotr.dalek@ts.fujitsu.com
> Subject: RE: rados bench object not correct errors on v9.0.3
> 
> 
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Tuesday, August 25, 2015 12:43 PM
> > To: Deneau, Tom
> > Cc: ceph-devel@vger.kernel.org; ceph-users@ceph.com;
> > piotr.dalek@ts.fujitsu.com
> > Subject: Re: rados bench object not correct errors on v9.0.3
> >
> > On Tue, 25 Aug 2015, Deneau, Tom wrote:
> > > > -----Original Message-----
> > > > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > > owner@vger.kernel.org] On Behalf Of Sage Weil
> > > > Sent: Monday, August 24, 2015 12:45 PM
> > > > To: ceph-announce@ceph.com; ceph-devel@vger.kernel.org;
> > > > ceph-users@ceph.com; ceph-maintainers@ceph.com
> > > > Subject: v9.0.3 released
> > > >
> > > > This is the second to last batch of development work for the
> > > > Infernalis cycle.  The most intrusive change is an internal (non
> > > > user-visible) change to the OSD's ObjectStore interface.  Many
> > > > fixes and improvements elsewhere across RGW, RBD, and another big
> > > > pile of
> > CephFS scrub/repair improvements.
> > > >
> > > >
> > > > Getting Ceph
> > > > ------------
> > > >
> > > > * Git at git://github.com/ceph/ceph.git
> > > > * Tarball at http://ceph.com/download/ceph-9.0.3.tar.gz
> > > > * For packages, see
> > > > http://ceph.com/docs/master/install/get-packages
> > > > * For ceph-deploy, see
> > > > http://ceph.com/docs/master/install/install-ceph-
> > > > deploy
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > >
> > > I have built rpms from the tarball http://ceph.com/download/ceph-
> > 9.0.3.tar.bz2.
> > > Have done this for fedora 21 x86_64 and for aarch64.  On both
> > > platforms when I run a single node "cluster" with a few osds and run
> > > rados bench read tests (either seq or rand) I get occasional reports
> > > like
> > >
> > > benchmark_data_myhost_20729_object73 is not correct!
> > >
> > > I never saw these with similar rpm builds on these platforms from
> > > 9.0.2
> > sources.
> > >
> > > Also, if I go to an x86-64 system running Ubuntu trusty for which I
> > > am able to install prebuilt binary packages via
> > >     ceph-deploy install --dev v9.0.3
> > >
> > > I do not see the errors there.
> >
> > Hrm.. haven't seen it on this end, but we're running/testing master
> > and not
> > 9.0.2 specifically.  If you can reproduce this on master, that'd be
> > very helpful!
> >
> > There have been some recent changes to rados bench... Piotr, does this
> > seem like it might be caused by your changes?
> >
> > sage
> >
> 
> Just as a reminder this is with 9.0.3, not 9.0.2.
> 
> I just tried with the osds running on the fedora machine (with rpms that I
> built from the tarball) and rados bench running on the Ubuntu machine (with
> pre-built binary packages) and I do not see the errors with that combination.
> 
> Will see what happens with master.
> 
> -- Tom
>

For making a tarball to build rpms from master, I did the following steps:
 
#  git checkout master
#  ./autogen.sh
#  ./configure
#  make dist-bzip2

then put the  .bz2 file in the rpmbuild/SOURCES and put the spec file in rpmbuild/SPECS

Are those the correct steps?  Asking because when I do rpmbuild from the above I eventually get

Processing files: ceph-9.0.3-0.fc21.x86_64
error: File not found: /root/rpmbuild/BUILDROOT/ceph-9.0.3-0.fc21.x86_64/usr/sbin/ceph-disk-activate
error: File not found: /root/rpmbuild/BUILDROOT/ceph-9.0.3-0.fc21.x86_64/usr/sbin/ceph-disk-prepare

-- Tom

