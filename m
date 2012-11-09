From: Samuel Just <sam.just@inktank.com>
Subject: Re: bobtail timing
Date: Thu, 8 Nov 2012 19:23:48 -0800
Message-ID: <CA+4uBUYim-aqhoP64tNqxKXui8ms+TEB_eJUaZv8ro8E4v=ekw@mail.gmail.com>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net>
	<CAC-hyiE5NABU4gyf22D3csbu+xnLB54dqaqyVTVr1GRsG-DXRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41518 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436Ab2KIDXt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 22:23:49 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so3390511vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 19:23:48 -0800 (PST)
In-Reply-To: <CAC-hyiE5NABU4gyf22D3csbu+xnLB54dqaqyVTVr1GRsG-DXRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've got wip_recovery_qos and wip_persist_missing that should go into bobtail.

wip_recovery_qos passed regression (mostly, failures due to fsx, a bug
fixed in master, and timeouts waiting for machines), and is waiting on
review.

wip_persist_missing has a teuthology test I'll push tomorrow
(wip_divergent_priors).  The second commit in wip_persist_missing I
think still needs review (formerly wip_divergent_entries).
-Sam

On Thu, Nov 8, 2012 at 5:30 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Wed, Oct 31, 2012 at 1:46 PM, Sage Weil <sage@inktank.com> wrote:
>> I would like to freeze v0.55, the "bobtail" stable release, at the end of
>> next week.  If there is any functionality you are working on that should
>> be included, we need to get it into master (preferably well) before that.
>> There will be several weeks of testing in the 'next' branch after that
>> (probaly 3 weeks) before it is released.
>
> I merged (against current master) and pushed all the pending rgw stuff
> to wip-rgw-integration. This includes:
>
> wip-post-cleaned
> wip-stripe
> wip-keystone
> wip-3452
> wip-3453
> wip-swift-token
>
> All that stuff needs to go into bobtail, but still waiting for review.
> The bottom 3 are trivial.
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
