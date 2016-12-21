From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: Orphaned objects after deleting rbd images
Date: Wed, 21 Dec 2016 17:17:21 +0100
Message-ID: <CAPed3OF31ms6M3cMeNqVC9Grj5zS4dA=acUTQrN4Y+UwaE1Wqw@mail.gmail.com>
References: <CAPed3OHxy2r0RvPANMRwSAtxUsWEVDHtjHSD+dAeiYgrmTbv7g@mail.gmail.com>
 <CA+aFP1A2ASge_F53eV2N9J688YLr-CUe0z16u9TyJr51rUzJrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35723 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbcLUQZJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 11:25:09 -0500
Received: by mail-ua0-f182.google.com with SMTP id 2so82609329uax.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2016 08:25:09 -0800 (PST)
In-Reply-To: <CA+aFP1A2ASge_F53eV2N9J688YLr-CUe0z16u9TyJr51rUzJrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jason,

On Wed, Dec 21, 2016 at 4:53 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> On Wed, Dec 21, 2016 at 10:06 AM, Ruben Kerkhof <ruben@rubenkerkhof.com> wrote:
>> $ sudo rbd rm test-root
>> 2016-12-21 14:46:38.479281 7fa1e17d8760 -1 librbd: Image uses
>> unsupported features: 48
>> Removing image: 100% complete...done.
>> $ echo $?
>> $ 0
>
> This isn't an known issue and is an odd corner case of the image
> removal logic.  The older client isn't able to open the image created
> with new features, so it just assumes that the image was already
> (partially) removed and that it just needs to clean up the rbd image
> directory.

Thanks for the confirmation.
>
> I'll open a tracker ticket against the hammer branch, but in the
> meantime, either don't use a hammer rbd CLI against images using jewel
> features or disable all features that are incompatible w/ the older
> releases.

Will do. But first I'll have to get rid of all these orphaned objects.
I was thinking of creating a new pool, rbd cp all the images and then
rbd rm them from the old pool.
After that's done I could drop the old pool. Or do you perhaps know of
a better way?

>
>
> --
> Jason

Kind regards,

Ruben
