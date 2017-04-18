From: Sage Weil <sweil@redhat.com>
Subject: Re: Question about writeback performance and content address obejct
 for deduplication
Date: Tue, 18 Apr 2017 13:23:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704181321550.6575@piezo.novalocal>
References: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com> <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal> <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com> <alpine.DEB.2.11.1702071442411.3654@piezo.novalocal>
 <CAFNt83ZUHKxPZJiFO0MEbj+BNgQo6PxmfFQWdQ=E5fnq-w+Piw@mail.gmail.com> <alpine.DEB.2.11.1703160249260.10776@piezo.novalocal> <CAFNt83aS0hOWQuairQkKvregr_FCho1__kNqPjM5TMg85oKF5A@mail.gmail.com> <alpine.DEB.2.11.1703241932310.10776@piezo.novalocal>
 <CAFNt83b-X701_oio4UzDdy_-UGqrzF-zG0_MWLzzCkPajbHhSA@mail.gmail.com> <alpine.DEB.2.11.1703271357000.10776@piezo.novalocal> <CAFNt83bgCHpLZxriPVgyswiAHsNPTKaS7-y7z-ju68WEpUtp7Q@mail.gmail.com> <CAFNt83YuGDLQ20312vVoG3vSDjaybVae7UyZSBXQ02B5Ohsg5Q@mail.gmail.com>
 <alpine.DEB.2.11.1704121550520.10661@piezo.novalocal> <CAFNt83a4Gr7u=Ox4isJgaY2HcOjNGOCuftv1f3Yz3Hv=Fvbnkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750893AbdDRNXv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 09:23:51 -0400
In-Reply-To: <CAFNt83a4Gr7u=Ox4isJgaY2HcOjNGOCuftv1f3Yz3Hv=Fvbnkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: myoungwon oh <ohmyoungwon@gmail.com>
Cc: ceph-devel@vger.kernel.org, =?EUC-KR?B?v8C47b/4?= <omwmw@sk.com>

On Tue, 18 Apr 2017, myoungwon oh wrote:
> Hi sage
> 
> I am refactoring the source code in order to support the extensible
> tier (support redirect, dedup, external system)
> 
> I have a few question.
> 
> 1. My understanding is that base pool contains all metadata for all
> objects (do not evicted), and dedup pool or external systems contain
> the object data.
> Therefore, The big difference between the cache tier and the
> extensible tier is whether  base pool contains metadata (such as
> object_info_t ) or not. Am i wrong?

Yeah.  The base pool effectively becomes and index for everything.

> 2. Do you think the extensible tier should belong to cache_mode_t (in
> maybe_handle_cache_detail()) ? or is it better to work independently
> from cache tier.

It should be independent of the cache tiering.  We should probably use the 
tier_of and tiers fields in pg_pool_t but not cache_mode.

> 3. Regarding promotion object and flushing work, I think start_copy() (in
> promote_object()) and start_fush() can be reused in a simple
> redirection case ("the object is in that other pool"), if we modify
> the object (only metadata) is not evicted (removed). Is this right
> way?

Yes!

I suggest focusing on step 1 being the simple redirection tiering case (no 
dedup) since it'll be tricky enough getting that part right.

Thanks!
sage
