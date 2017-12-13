From: Sage Weil <sweil@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Wed, 13 Dec 2017 17:36:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712131732290.2838@piezo.novalocal>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com> <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com> <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com> <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
 <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753666AbdLMRgy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Dec 2017 12:36:54 -0500
In-Reply-To: <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <mbroz@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 13 Dec 2017, Milan Broz wrote:
> On 12/12/2017 09:47 PM, Sage Weil wrote:
> > On Tue, 12 Dec 2017, Alfredo Deza wrote:
> >> On Tue, Dec 12, 2017 at 2:38 PM, Wyllys Ingersoll
> >> <wyllys.ingersoll@keepertech.com> wrote:
> >>> Its useful for legacy systems that installed with "plain" back when
> >>> that was the only option. Since there is no easy migration path for
> >>> re-keying an encrypted OSD to use a new encryption scheme, keeping
> >>> support for legacy "plain" is still very useful and desirable.
> >>
> >> Yes, for sure we are going to support that legacy option. But for
> >> *newly* created OSDs, I was looking forward to follow
> >> the preferred way with LUKS only.
> > 
> > It's worth mentioning that the "new" way for new ceph-volume OSD 
> > deployments will also be using LVM, and (presumably?) allow layering 
> > dm-crypt on top of an LV--not just a PV or raw device.  So this is more a 
> > question of what, clean slate, we want to do to deploy dm-crypt when the 
> > end result that we're after is an LV to feed to bluestore or filestore.  
> > I'm not sure how/where LUKS fits in in the LVM world...
> 
> I think LUKS fits in LVM world quite well.
> 
> Standard Fedora (and most other distors as well) install stacks LVM over LUKS
> (so you activate only one encrypted device and then the partitioning is up to LVM.
> Also LVM metadata are then encrypted.)
> 
> You can of course stack LUKS over LV as well, but for example LV resize
> will be two-step operation (well, fsadm can automate it but it is still two-steps).

The problem I see is that we frequently carve up a single phsycial device 
across lots of OSDs (usually for the journal or wal/db), and the key 
management is currently structured around OSDs, not devices.  We can 
either (1) switch it all around so the key management is based on physical 
devices instead of OSDs, or (2) carve the physical device into raw LVs, 
dm-crypt those, and then consume the result.

We don't really have a need to resize devices, generally, so that's 
probably not an issue... but I wonder if (1) is going to be an 
easier/smaller change to make this work.  It maps more directly onto the 
threat model (a lost *device*) and probably also avoids some DM layers, 
and so ought to be slightly faster?

sage
