From: Sage Weil <sage@newdream.net>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 18:02:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706141801170.3646@piezo.novalocal>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com> <20170614170617.GA6164@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57715 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdFNSCY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 14:02:24 -0400
In-Reply-To: <20170614170617.GA6164@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Adam C. Emerson wrote:
> On 14/06/2017, Radoslaw Zarzynski wrote:
> > Thanks for the info, Willem. I'm on it.
> > 
> > BTW: it would be nice to have a Clang builder to find out similar
> > issues as early as possible.
> 
> Oh yes, please Infrastructure Gods.
> 
> Though I admit the more builders we add the slower Jenkins is. Are there
> any older systems or variants we could prune out?

Note that any jenkins checks run in parallel, and how long that takes just 
depends on how many VMs we spin up (in OVH).  I think the main thing to 
watch out for is long duration tests, not the quantity of tests.

sage
