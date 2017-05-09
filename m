From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: fs: mandatory client quota
Date: Tue, 9 May 2017 09:51:27 -0700
Message-ID: <CAJ4mKGZVODhE0y180bp6HDADWyGfOz255-DsXOpRznTjhaitiQ@mail.gmail.com>
References: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com>
 <CABZ+qqnFwaV9Va-B4WHp=ntPgKZdsDA1P=m67pLPWU7Y9Tyu+Q@mail.gmail.com> <alpine.DEB.2.11.1705051456250.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36642 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbdEIQv3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 12:51:29 -0400
Received: by mail-it0-f51.google.com with SMTP id o5so9316676ith.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 09:51:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705051456250.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

[ Resend due to accidental HTML subpart ]

On Fri, May 5, 2017 at 7:57 AM, Sage Weil <sage@newdream.net> wrote:
>
> On Fri, 5 May 2017, Dan van der Ster wrote:
> > On Fri, May 5, 2017 at 4:36 PM, Dan van der Ster <dan@vanderster.com> wrote:
> > > Hi all,
> > >
> > > It would be really nice if for Luminous client quotas were always
> > > enabled -- it should be impossible to disable quota enforcement on the
> > > client side.
> > >
> > > From the looks of things, the patch to remove client_quota and
> > > client_quota_df would be trivial.
> > > Is there some reason we need to leave that optional?
> >
> > PR: 14978
>
> This seems reasonable to me.  Client can of course run modified code so
> it's not really "secure" in that sense but it's certainly inconvenient to
> circumvent.

I'm sure John will comment on this once he gets back from vacation,
but there were some reasons not to enable it by default when this was
discussed by the team last fall. I think it was combined concern about
the lack of server-side enforcement and (more importantly) not wanting
to provide default experiences which differ across the userspace and
kernel clients.
-Greg
