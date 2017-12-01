From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: ceph-disk removal roadmap (was ceph-disk is now deprecated)
Date: Fri, 1 Dec 2017 09:17:57 +0100
Message-ID: <20171201081757.qwfo2lrhpmg77jgd@nora.maurer-it.com>
References: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:36179 "EHLO
        proxmox-new.maurer-it.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750921AbdLAISF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Dec 2017 03:18:05 -0500
Content-Disposition: inline
In-Reply-To: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 30, 2017 at 11:25:03AM -0500, Alfredo Deza wrote:
> Thanks all for your feedback on deprecating ceph-disk, we are very
> excited to be able to move forwards on a much more robust tool and
> process for deploying and handling activation of OSDs, removing the
> dependency on UDEV which has been a tremendous source of constant
> issues.
> 
> Initially (see "killing ceph-disk" thread [0]) we planned for removal
> of Mimic, but we didn't want to introduce the deprecation warnings up
> until we had an out for those who had OSDs deployed in previous
> releases with ceph-disk (we are now able to handle those as well).
> That is the reason ceph-volume, although present since the first
> Luminous release, hasn't been pushed forward much.
> 
> Now that we feel like we can cover almost all cases, we would really
> like to see a wider usage so that we can improve on issues/experience.
> 
> Given that 12.2.2 is already in the process of getting released, we
> can't undo the deprecation warnings for that version, but we will
> remove them for 12.2.3, add them back again in Mimic, which will mean
> ceph-disk will be kept around a bit longer, and finally fully removed
> by N.
> 
> To recap:
> 
> * ceph-disk deprecation warnings will stay for 12.2.2
> * deprecation warnings will be removed in 12.2.3 (and from all later
> Luminous releases)
> * deprecation warnings will be added again in ceph-disk for all Mimic releases
> * ceph-disk will no longer be available for the 'N' release, along
> with the UDEV rules
> 
> I believe these four points address most of the concerns voiced in
> this thread, and should give enough time to port clusters over to
> ceph-volume.
> 
> [0] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-October/021358.html

Thank you for listening to the feedback - I think most of us know the
balance that needs to be struck between moving a project forward and
decrufting a code base versus providing a stable enough interface for
users is not always easy to find.

I think the above roadmap is a good compromise for all involved parties,
and I hope we can use the remainder of Luminous to prepare for a
seam- and painless transition to ceph-volume in time for the Mimic
release, and then finally retire ceph-disk for good!

