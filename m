From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Orphaned objects after deleting rbd images
Date: Wed, 21 Dec 2016 10:53:28 -0500
Message-ID: <CA+aFP1A2ASge_F53eV2N9J688YLr-CUe0z16u9TyJr51rUzJrA@mail.gmail.com>
References: <CAPed3OHxy2r0RvPANMRwSAtxUsWEVDHtjHSD+dAeiYgrmTbv7g@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33026 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934495AbcLUPxa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 10:53:30 -0500
Received: by mail-lf0-f41.google.com with SMTP id c13so100682078lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2016 07:53:29 -0800 (PST)
In-Reply-To: <CAPed3OHxy2r0RvPANMRwSAtxUsWEVDHtjHSD+dAeiYgrmTbv7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06 AM, Ruben Kerkhof <ruben@rubenkerkhof.com> wrote:
> $ sudo rbd rm test-root
> 2016-12-21 14:46:38.479281 7fa1e17d8760 -1 librbd: Image uses
> unsupported features: 48
> Removing image: 100% complete...done.
> $ echo $?
> $ 0

This isn't an known issue and is an odd corner case of the image
removal logic.  The older client isn't able to open the image created
with new features, so it just assumes that the image was already
(partially) removed and that it just needs to clean up the rbd image
directory.

I'll open a tracker ticket against the hammer branch, but in the
meantime, either don't use a hammer rbd CLI against images using jewel
features or disable all features that are incompatible w/ the older
releases.


-- 
Jason
