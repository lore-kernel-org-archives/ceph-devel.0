From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] rbd: set discard alignment to zero
Date: Thu, 2 Nov 2017 00:43:38 +0100
Message-ID: <20171102004338.39d87dea@suse.de>
References: <20171101122439.9923-1-ddiss@suse.de>
        <CAOi1vP_Qt4NMG+8Hi_He6PBiCoJgfg6JBL53Ty=iJtmSRF4cTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932964AbdKAXnm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Nov 2017 19:43:42 -0400
In-Reply-To: <CAOi1vP_Qt4NMG+8Hi_He6PBiCoJgfg6JBL53Ty=iJtmSRF4cTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

Thanks for the feedback, Ilya.

On Wed, 1 Nov 2017 18:14:04 +0100, Ilya Dryomov wrote:

> Yeah, discard_alignment == discard_granularity seems bogus.  The name
> is misleading too, but that probably comes from SBC, which talks about
> OPTIMAL UNMAP GRANULARITY and UNMAP GRANULARITY ALIGNMENT.
> 
> 0 is the default -- let's just drop discard_alignment assignment?

Works for me, if you'd prefer. I'll send through a v2 with this.

> Also, you quoted <disk>/<partition>/discard_alignment description, but
> this is about <disk>/discard_alignment.  This had me confused for
> a moment.

Oops, my bad. Will use the <disk> only description in the next round.

Cheers, David
