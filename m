From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Question about writeback performance and content address obejct
 for deduplication
Date: Tue, 18 Apr 2017 19:04:56 +0900
Message-ID: <CAFNt83a4Gr7u=Ox4isJgaY2HcOjNGOCuftv1f3Yz3Hv=Fvbnkg@mail.gmail.com>
References: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com>
 <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal> <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com>
 <alpine.DEB.2.11.1702071442411.3654@piezo.novalocal> <CAFNt83ZUHKxPZJiFO0MEbj+BNgQo6PxmfFQWdQ=E5fnq-w+Piw@mail.gmail.com>
 <alpine.DEB.2.11.1703160249260.10776@piezo.novalocal> <CAFNt83aS0hOWQuairQkKvregr_FCho1__kNqPjM5TMg85oKF5A@mail.gmail.com>
 <alpine.DEB.2.11.1703241932310.10776@piezo.novalocal> <CAFNt83b-X701_oio4UzDdy_-UGqrzF-zG0_MWLzzCkPajbHhSA@mail.gmail.com>
 <alpine.DEB.2.11.1703271357000.10776@piezo.novalocal> <CAFNt83bgCHpLZxriPVgyswiAHsNPTKaS7-y7z-ju68WEpUtp7Q@mail.gmail.com>
 <CAFNt83YuGDLQ20312vVoG3vSDjaybVae7UyZSBXQ02B5Ohsg5Q@mail.gmail.com> <alpine.DEB.2.11.1704121550520.10661@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33332 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdDRKE7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Apr 2017 06:04:59 -0400
Received: by mail-vk0-f49.google.com with SMTP id j127so66112905vkh.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 03:04:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1704121550520.10661@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

Hi sage

I am refactoring the source code in order to support the extensible
tier (support redirect, dedup, external system)

I have a few question.

1. My understanding is that base pool contains all metadata for all
objects (do not evicted), and dedup pool or external systems contain
the object data.
Therefore, The big difference between the cache tier and the
extensible tier is whether  base pool contains metadata (such as
object_info_t ) or not. Am i wrong?


2. Do you think the extensible tier should belong to cache_mode_t (in
maybe_handle_cache_detail()) ? or is it better to work independently
from cache tier.


3. Regarding promotion object and flushing work, I think start_copy() (in
promote_object()) and start_fush() can be reused in a simple
redirection case ("the object is in that other pool"), if we modify
the object (only metadata) is not evicted (removed). Is this right
way?


Thanks.
Myoungwon.

2017-04-13 0:51 GMT+09:00 Sage Weil <sweil@redhat.com>:
> On Wed, 29 Mar 2017, myoungwon oh wrote:
>> Hi sage,
>>
>> I made two pads in order to discuss #3, #4.
>>
>> #3: http://pad.ceph.com/p/deduplication_how_do_we_chunk
>> #4: http://pad.ceph.com/p/deduplication_how_to_drive_dedup_process
>
> Updated!
> sage
