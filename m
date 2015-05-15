From: Sage Weil <sweil@redhat.com>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Fri, 15 May 2015 12:05:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505151205220.10788@cobra.newdream.net>
References: <55362279.5060105@dachary.org> <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net> <5555F85B.3000407@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-900831217-1431716758=:10788"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbbEOTF7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 May 2015 15:05:59 -0400
In-Reply-To: <5555F85B.3000407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>, dzafman@redhat.com, sjust@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-900831217-1431716758=:10788
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 May 2015, Loic Dachary wrote:
> Hi Sage,
> 
> On 21/04/2015 17:52, Sage Weil wrote:
> > The bulk of it is ceph-objectstore-tool, which is important to get into a 
> > release, IMO.  David, are these being tested in the firefly thrashing 
> > tests yet?
> > 
> > The only other one I'm worried about is
> > 
> > 6fd3dfa osd: do not ignore deleted pgs on startup
> > 
> > Sam, I assume the recent hammer upgrade issue is would bite firefly folks 
> > who upgrade too?
> 
> A backport of "OSD::load_pgs: we need to handle the case where an upgrade from earlier versions which ignored non-existent pgs resurrects a pg with a prehistoric osdmap" http://tracker.ceph.com/issues/11429 found at https://github.com/ceph/ceph/pull/4556 has been successfully tested on firefly at http://pulpito.ceph.com/loic-2015-05-13_00:01:26-rados-firefly-backports---basic-multi/ and in a rados suite run that completed today http://tracker.ceph.com/issues/11090#rados.
> 
> Provided https://github.com/ceph/ceph/pull/4556 is merged, do you think we should prepare to release firefly v0.80.10 ?

As Yehuda mentioned the other open issue is the rgw multipart corruption.  
I'm guessing we want to include that?

sage

> 
> Cheers
> 
> > 
> > sage
> > 
> > 
> > On Tue, 21 Apr 2015, Loic Dachary wrote:
> > 
> >> Hi Sage,
> >>
> >> The firefly branch has a number of fixes ( http://tracker.ceph.com/issues/11090#Release-information ) and has been used for upgrade tests in the past few weeks. A few other issues have been backported since and are being tested in the integration branch ( http://tracker.ceph.com/issues/11090#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f79-integration-branch-april-2015 ). 
> >>
> >> Do you think these changes deserve a firefly v0.80.10 release ? Should we ask each lead for their approval ? Or is it better to keep backporting what needs to be and wait a few weeks ?
> >>
> >> Cheers
> >>
> >> -- 
> >> Loïc Dachary, Artisan Logiciel Libre
> >>
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--557981400-900831217-1431716758=:10788--
