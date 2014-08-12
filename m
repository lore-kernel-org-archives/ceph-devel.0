From: Steve Taylor <steveftaylor@gmail.com>
Subject: Re: ceph-disk and dmcrypt
Date: Tue, 12 Aug 2014 14:03:28 -0600
Message-ID: <CADXiVcrXqduZs02a2qtDa5vpk7eTUvTegPtaob+AEEqAO0O9Sw@mail.gmail.com>
References: <alpine.DEB.2.00.1408120936270.13051@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:52097 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974AbaHLUDt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 16:03:49 -0400
Received: by mail-ig0-f178.google.com with SMTP id uq10so7866438igb.17
        for <ceph-devel@vger.kernel.org>; Tue, 12 Aug 2014 13:03:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408120936270.13051@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

I set up a simple virtual cluster to test this today, and it appears
that all is well. The issue I was attempting to fix doesn't appear to
be present in wip-firefly-dmcrypt's ceph-disk.

Steve

On Tue, Aug 12, 2014 at 10:39 AM, Sage Weil <sage@inktank.com> wrote:
> Hi Steve,
>
> We ran into a problem with the ceph-disk changes back in 67339470 (they
> were breaking dmcrypt when the journal was on a separate device).  At the
> same time we resolved another bug.  With your change reverted, and the new
> fix, and other changes to ceph-disk since then, it appears to be working
> fine for all of my tests.
>
> Do you mind testing the ceph-disk from wip-firefly-dmcrypt in your
> environment to verify that you don't see the original problem?  The
> explanation in your original commit sounds plausible (that the kernel
> wouldn't refresh the partition table if dmcrypt was consuming one of the
> partitions), but it just doesn't seem to be the case for me.
>
> Thanks!
> sage
