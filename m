From: John Spray <john.spray@redhat.com>
Subject: Re: wip-objecter
Date: Sun, 27 Jul 2014 13:19:46 +0100
Message-ID: <CAGd4Wr17ds-r8u4ZZfSwptsCV9LV43s206=c_uee5Lp4R7ex3A@mail.gmail.com>
References: <alpine.DEB.2.00.1407251727430.5027@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38583 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaG0MTr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jul 2014 08:19:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so8623913pad.8
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jul 2014 05:19:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407251727430.5027@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I think that for the calls where we check the epoch and then
conditionally call wait_for_map with the context, we have to change
them to do the wait_for_map call first and check the boolean response.
Otherwise, if the map we have is updated between the read of the epoch
and the call to wait_for_map, it could already be ready and never call
back our context.

My version is here (on top a rebase of wip-objecter to master on
branch wip-objecter-rebase):
https://github.com/ceph/ceph/commit/3cd82464ed6f13ec5b44da303849061648b9e3a1

John

On Sat, Jul 26, 2014 at 6:42 AM, Sage Weil <sweil@redhat.com> wrote:
> Hey John,
>
> I fixed up the mds osdmap wait stuff and squashed it into wip-objecter.
> That rebased out from underneath your branch; sorry.  Will try to look at
> the other patches shortly!
>
> sage
