From: Sage Weil <sage@newdream.net>
Subject: Re: fs: mandatory client quota
Date: Fri, 5 May 2017 14:57:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705051456250.3646@piezo.novalocal>
References: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com> <CABZ+qqnFwaV9Va-B4WHp=ntPgKZdsDA1P=m67pLPWU7Y9Tyu+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48889 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbdEEO5P (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 May 2017 10:57:15 -0400
In-Reply-To: <CABZ+qqnFwaV9Va-B4WHp=ntPgKZdsDA1P=m67pLPWU7Y9Tyu+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 5 May 2017, Dan van der Ster wrote:
> On Fri, May 5, 2017 at 4:36 PM, Dan van der Ster <dan@vanderster.com> wrote:
> > Hi all,
> >
> > It would be really nice if for Luminous client quotas were always
> > enabled -- it should be impossible to disable quota enforcement on the
> > client side.
> >
> > From the looks of things, the patch to remove client_quota and
> > client_quota_df would be trivial.
> > Is there some reason we need to leave that optional?
> 
> PR: 14978

This seems reasonable to me.  Client can of course run modified code so 
it's not really "secure" in that sense but it's certainly inconvenient to 
circumvent.

sage
