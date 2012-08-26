From: Samuel Just <sam.just@inktank.com>
Subject: Re: On tmap, omap, xattr physical layout
Date: Sun, 26 Aug 2012 11:08:13 -0700
Message-ID: <CA+4uBUZc1YKEUVyLHLiKFrTfs+jz9vD5V68e4QATZBP=7xxWBg@mail.gmail.com>
References: <CAPrxi58O6PTgQ70GGrQbcvkOTwN6212=wGWaRNo+9-GFGqCGHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43246 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab2HZSIO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 14:08:14 -0400
Received: by vcbfk26 with SMTP id fk26so3700155vcb.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 11:08:13 -0700 (PDT)
In-Reply-To: <CAPrxi58O6PTgQ70GGrQbcvkOTwN6212=wGWaRNo+9-GFGqCGHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Tmap simply places the keys and values in order in the normal object data.  The
only advantage of tmap over simply writing the values out sequentially using
normal operations is that you don't need to read in the the tmap to do
an insertion.
Tmap probably shouldn't be used at this stage.

Omaps are stored separately in a leveldb store and can be used independently
of the actual object contents.

Xattrs are stored either as filesystem xattrs or in the leveldb store
alongside the
omap depending on:
filestore_xattr_use_omap, filestore_max_inline_xattr_size, and
filestore_max_inline_xattrs.
-Sam

On Sun, Aug 26, 2012 at 10:09 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Would anyone mind giving a short overview of the difference between
> tmap, omap, and xattrs, and the physical layout of these with respect
> to the object payload?
>
> Thanks,
> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
