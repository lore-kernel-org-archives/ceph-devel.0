From: Sage Weil <sage@newdream.net>
Subject: Re: Does mon skew really matters?
Date: Sat, 4 Jun 2016 22:35:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606042234410.6221@cpach.fuggernut.com>
References: <CALZt5jypeXGhVhhjur8dpC5KPDqFN-HRC+HbUzOEmVtzO6N1vQ@mail.gmail.com> <CAPpSHbW_bz9b-+BUmX+hJJodh-hF428-2KA9UZ3mcNOUR303gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58964 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbcFECer (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Jun 2016 22:34:47 -0400
In-Reply-To: <CAPpSHbW_bz9b-+BUmX+hJJodh-hF428-2KA9UZ3mcNOUR303gQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Jin <wjin.cn@gmail.com>
Cc: Ning Yao <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 4 Jun 2016, Wei Jin wrote:
> In my opinion, if clock drift is too heavy, the lease protocol inside
> paxos won't work. Lease may be timeout and then triggers monitor to
> bootstrap.

Exactly.

> You could try to shift clock back on the leader node to see what will happen.
> 
> Time check mechanism gives us warning message so that we may take
> actions if possible before things getting worse.

You can also get into situations where the clients loop trying to get a 
new ticket because the one they are issued appears to be expired.

sage

> 
> On Sat, Jun 4, 2016 at 12:06 PM, Ning Yao <zay11022@gmail.com> wrote:
> > Hi, all
> >
> > I find that even if I have mon clock skew warning, under most cases,
> > my cluster still can work properly as expected.
> >
> > I go through the code in mon but do not find any related issue without
> > time_check() to update whether clock skew periodically.
> >
> > can any one tell what is the design purpose of the clock skew between
> > mon and when it will really matter the cluster?
> >
> > Thanks a lots!
> >
> > Regards
> > Ning Yao
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
