From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-disk and dmcrypt
Date: Tue, 12 Aug 2014 13:46:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408121345430.32572@cobra.newdream.net>
References: <alpine.DEB.2.00.1408120936270.13051@cobra.newdream.net> <CADXiVcrXqduZs02a2qtDa5vpk7eTUvTegPtaob+AEEqAO0O9Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49851 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaHLUqC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 16:46:02 -0400
In-Reply-To: <CADXiVcrXqduZs02a2qtDa5vpk7eTUvTegPtaob+AEEqAO0O9Sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steve Taylor <steveftaylor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 12 Aug 2014, Steve Taylor wrote:
> Hi Sage,
> 
> I set up a simple virtual cluster to test this today, and it appears
> that all is well. The issue I was attempting to fix doesn't appear to
> be present in wip-firefly-dmcrypt's ceph-disk.

Great.  Thanks for testing!

sage



> 
> Steve
> 
> On Tue, Aug 12, 2014 at 10:39 AM, Sage Weil <sage@inktank.com> wrote:
> > Hi Steve,
> >
> > We ran into a problem with the ceph-disk changes back in 67339470 (they
> > were breaking dmcrypt when the journal was on a separate device).  At the
> > same time we resolved another bug.  With your change reverted, and the new
> > fix, and other changes to ceph-disk since then, it appears to be working
> > fine for all of my tests.
> >
> > Do you mind testing the ceph-disk from wip-firefly-dmcrypt in your
> > environment to verify that you don't see the original problem?  The
> > explanation in your original commit sounds plausible (that the kernel
> > wouldn't refresh the partition table if dmcrypt was consuming one of the
> > partitions), but it just doesn't seem to be the case for me.
> >
> > Thanks!
> > sage
> 
> 
