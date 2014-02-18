From: Guilhem Lettron <guilhem@lettron.fr>
Subject: Re: chef cookbooks
Date: Tue, 18 Feb 2014 10:17:23 +0100
Message-ID: <CAMQoE_34vsm-ap-9A-bTWbUKAK5CUbmGcUnTW04O108xc7y6=Q@mail.gmail.com>
References: <alpine.DEB.2.00.1402031135180.10986@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43782 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbaBRJRs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2014 04:17:48 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so16414850pad.25
        for <ceph-devel@vger.kernel.org>; Tue, 18 Feb 2014 01:17:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402031135180.10986@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Sorry I didn't see this thread until tomorrow (Loic ping me this
discussion during Paris meetup).

I already do a lot of work on Ceph coobook last years, when I see the
inactivity on repository, I review PR, merge and add tests on my own.
Here is my repo: https://github.com/guilhem/ceph-cookbook

I also have registered ceph on chef community repository:
http://community.opscode.com/cookbooks/ceph

I will be happy to merge it back on official repository and commit new
version on chef community site.

Guilhem Lettron


On Mon, Feb 3, 2014 at 8:36 PM, Sage Weil <sage@inktank.com> wrote:
> Hi everyone,
>
> We have a huge backlog of pull requests on ceph-cookbooks.git on github.
> At the moment Inktank doesn't have a lot of spare cycles to review and
> test these changes.  Are there any chef+ceph users that are interested in
> helping maintain these cookbooks?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
