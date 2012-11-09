From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: bobtail timing
Date: Thu, 8 Nov 2012 17:30:18 -0800
Message-ID: <CAC-hyiE5NABU4gyf22D3csbu+xnLB54dqaqyVTVr1GRsG-DXRg@mail.gmail.com>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58272 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2KIBaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 20:30:19 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so1442849bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 17:30:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 31, 2012 at 1:46 PM, Sage Weil <sage@inktank.com> wrote:
> I would like to freeze v0.55, the "bobtail" stable release, at the end of
> next week.  If there is any functionality you are working on that should
> be included, we need to get it into master (preferably well) before that.
> There will be several weeks of testing in the 'next' branch after that
> (probaly 3 weeks) before it is released.

I merged (against current master) and pushed all the pending rgw stuff
to wip-rgw-integration. This includes:

wip-post-cleaned
wip-stripe
wip-keystone
wip-3452
wip-3453
wip-swift-token

All that stuff needs to go into bobtail, but still waiting for review.
The bottom 3 are trivial.

Yehuda
