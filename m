From: Sage Weil <sage@newdream.net>
Subject: Re: [Ceph-qa] QE validation hammer v0.94.7 finished (needs
 approval)
Date: Fri, 6 May 2016 13:31:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605061331090.15518@cpach.fuggernut.com>
References: <CAMMFjmFE6NTPA-DkTRubYPeyy+Qk0gHU_da3g97+zK9=Xm+DJA@mail.gmail.com> <CAOi1vP9g0asaad8=7EA+XJm19DuwBhA2x8qG1bpQ0M-eHBvVNw@mail.gmail.com> <CAMMFjmFo=jro5em66HrUXwH7Cug4vGerHWw8cQ0Bwi31LPM8EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57158 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212AbcEFRbD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 13:31:03 -0400
In-Reply-To: <CAMMFjmFo=jro5em66HrUXwH7Cug4vGerHWw8cQ0Bwi31LPM8EA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Deza, Alfredo" <adeza@redhat.com>, Gregory Meno <gmeno@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "Just, Samuel" <sjust@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>

On Fri, 6 May 2016, Yuri Weinstein wrote:
> Great thx !
> 
> Sage, assuming you are OK to re-use approvals from the previous hammer
> point release we are ready to publish this release.

Yep!
sage

> 
> Alfredo FYI
> 
> Thx
> YuriW
> 
> On Fri, May 6, 2016 at 10:13 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Fri, May 6, 2016 at 6:26 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> >> Hello
> >>
> >> Detailed summary of the QE Validation can be found here
> >> http://tracker.ceph.com/issues/14692#note-61
> >>
> >> The following suites were in scope of this point release testing:
> >>
> >> rados (subset 1/7)
> >> rbd
> >> rgw
> >> fs
> >> krbd
> >> kcephfs
> >> hadoop
> >> samba
> >> rest
> >> ceph-deploy
> >> upgrade/client-upgrade
> >> upgrade/dumpling-firefly-x (hammer)
> >> upgrade/firefly-x (hammer)
> >> upgrade/hammer
> >> upgrade/hammer-x (infernalis)
> >> powercycle
> >>
> >> Known issues (approved for release):
> >>
> >> fs:
> >> http://tracker.ceph.com/issues/14716 - (same as in v0.94.6 was
> >> approved by Greg, Josh)
> >>
> >> samba:
> >> http://tracker.ceph.com/issues/14714 - (same as in v0.94.6 was approved by Greg)
> >>
> >> krbd:
> >> see failed runs, Jason/Josh pls review and approve or suggest next steps.
> >
> > krbd based on
> >
> >     http://pulpito.ovh.sepia.ceph.com:8081/teuthology-2016-04-24_18:06:02-krbd-hammer-testing-basic-openstack/
> >
> > looks OK to me - known xfstests failures, under-provisioned OSDs (97%
> > full) and a huge-tickets failure.
> >
> > huge-tickets seems to be failing consistently on ovh, I'll investigate
> > later.
> >
> > Thanks,
> >
> >                 Ilya
> _______________________________________________
> Ceph-qa mailing list
> Ceph-qa@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
> 
> 
