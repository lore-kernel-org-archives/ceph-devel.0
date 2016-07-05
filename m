From: Wido den Hollander <wido@42on.com>
Subject: Re: Failing OSDs (suicide timeout) due to flaky clients
Date: Tue, 5 Jul 2016 20:32:08 +0200 (CEST)
Message-ID: <815030793.538.1467743528746@ox.pcextreme.nl>
References: <256042034.446.1467643268046@ox.pcextreme.nl>
 <CABZ+qqk5G9S47-3chQ-81okkCEkUKhg=Dz_V4FHEnbwus7vBiA@mail.gmail.com>
 <410573451.453.1467650925047@ox.pcextreme.nl>
 <CAEYCsV+4fJGq38CHpmCQhmENmX3yRQWD4Bma6dgxkcCFuUHS6Q@mail.gmail.com>
 <377473173.481.1467703560299@ox.pcextreme.nl>
 <CABAwU-bBofDt4yaWqgVADZP1Vx=CQKqFrbJY7DSPYCcq8AM9Qw@mail.gmail.com>
 <2029231343.493.1467709835165@ox.pcextreme.nl>
 <CAJ4mKGa8jrcSFPXOwyPndkTigzyhfS-dP37U1wHE=d-+MODo4A@mail.gmail.com>
 <480504153.536.1467740755666@ox.pcextreme.nl>
 <CAJ4mKGbOehcotz6uJtp-+uhDgVm7jWFNk-ShBCsQ3ORQhnuR1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:34866 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcGEScN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2016 14:32:13 -0400
In-Reply-To: <CAJ4mKGbOehcotz6uJtp-+uhDgVm7jWFNk-ShBCsQ3ORQhnuR1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: huang jun <hjwsm1989@gmail.com>, Dan van der Ster <dan@vanderster.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Op 5 juli 2016 om 19:48 schreef Gregory Farnum <gfarnum@redhat.com>:
> 
> 
> On Tue, Jul 5, 2016 at 10:45 AM, Wido den Hollander <wido@42on.com> wrote:
> >
> >> Op 5 juli 2016 om 19:27 schreef Gregory Farnum <gfarnum@redhat.com>:
> >>
> >>
> >> On Tue, Jul 5, 2016 at 2:10 AM, Wido den Hollander <wido@42on.com> wrote:
> >> >
> >> >> Op 5 juli 2016 om 10:56 schreef huang jun <hjwsm1989@gmail.com>:
> >> >>
> >> >>
> >> >> i see osd timed out many times.
> >> >> In SimpleMessenger mode, when sending msg, the Pipeconnection will
> >> >> hold a lock, which maybe hold by other threads,
> >> >> it's reported before: http://tracker.ceph.com/issues/9921
> >> >>
> >> >
> >> > Thank you! It surely looks like the same symptoms we are seeing in this cluster.
> >> >
> >> > The bug has been marked as resolved, but are you sure it is?
> >>
> >> Pretty sure about that bug being done.
> >>
> >> The conntrack filling thing sounds vaguely familiar though. Is this
> >> the latest hammer? I think there were some leaks of messages while
> >> sending replies that might have blocked up incoming queues that got
> >> resolved later.
> >
> > Keep in mind, it's the conntrack filling up on the client which results in >50% packetloss on that client.
> >
> > The cluster is not firewalled and doesn't do any connection tracking.
> >
> > This is hammer 0.94.5, if this is fixed in .6 or .7, do you have an idea for which commit I should look? (Simple)Messenger related?
> 
> If it is one of the op leaks, it'll be in the OSD OpTracker stuff to
> avoid keeping around message references for tracking purposes and
> unblocking the client Throttles.

Thanks! I've been looking in the hammer and master branch, but was unable to find the right commit I think. Been looking for 45 minutes now, but nothing which caught my attention.

If you have the time, would you be so kind to take a look?

Wido

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
