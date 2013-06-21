From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] rbd: link and load librbd dynamically
Date: Fri, 21 Jun 2013 14:13:57 -0500
Message-ID: <87ppvfuvii.fsf@codemonkey.ws>
References: <20130405093124.GA2351@dhcp-200-207.str.redhat.com> <1365552342-22840-1-git-send-email-josh.durgin@inktank.com> <CAJSP0QWy1CUOX+BVB2kfXfRpcdPuwbywZ3tReo83zK23+B4vbQ@mail.gmail.com> <87ip3uctjv.fsf@codemonkey.ws> <alpine.DEB.2.00.1306211138310.454@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:38720 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423672Ab3FUTOA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 15:14:00 -0400
Received: by mail-yh0-f42.google.com with SMTP id c41so3383950yho.1
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jun 2013 12:14:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306211138310.454@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org

Sage Weil <sage@inktank.com> writes:

> Hi Anthony, Stefan, Paolo,
>
> [Resurrecting an old thread, here!]
>
> On Wed, 10 Apr 2013 Anthony Liguori wrote:
>
> Has any progress been made toward a generic dynamic linking solution for 
> block drivers?  It is a conceptually simple change, but non-trivial for 
> anyone unfamiliar with the build system.

There are patches on the list in fact.

> In the mean time, the inability to dynamically link librbd is continuing 
> to cause significant pain for distro users.  Would you consider merging 
> the rbd-specific linking as an interim solution until something is 
> generically available to qemu?

Regards,

Anthony Liguori

>
> sage
