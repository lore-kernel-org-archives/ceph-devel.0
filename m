From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph_setattr mask
Date: Tue, 14 Feb 2012 08:50:43 -0800
Message-ID: <CAF3hT9A-n9yVWQExONF2T0ODwZRLeoVe6bi3qTFY9EEGeWBv+A@mail.gmail.com>
References: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47450 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab2BNQun (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 11:50:43 -0500
Received: by iacb35 with SMTP id b35so155696iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 08:50:43 -0800 (PST)
In-Reply-To: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, Feb 13, 2012 at 4:05 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Howdy,
>
> It looks like ceph_fs.h contains the mask flags (e.g. CEPH_SETATTR_MODE) used in ceph_setattr, but I do not see these flags in any header installed from .deb files (grep /usr/include/*).
>
> Am I missing a location? Should these flags be part of the installed headers?

You're right, those flags are only specified in ceph_fs.h. I don't
think it's appropriate to include that file in user-facing stuff as
it's mostly things that I'd consider to be Ceph internals, but the
CEPH_SETATTR_* stuff is obviously public since you need them for
ceph_setattr. My inclination would be to either move or duplicate them
into a header that's already installed, but I'm not sure which one is
best for that. Do you have any thoughts as a user? :)
-Greg
