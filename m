From: Sage Weil <sweil@redhat.com>
Subject: Re: CodingStyle on existing code
Date: Tue, 1 Dec 2015 07:18:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512010717380.19170@cobra.newdream.net>
References: <565D9C37.3060903@42on.com> <565DA503.9000401@dachary.org> <CAJ4mKGbFz2OjLvN54sRD7Gw8VBiyvFti1ZpJZN3ZPCjU-p-uwA@mail.gmail.com> <565DB9B9.7030806@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbbLAPSQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 10:18:16 -0500
In-Reply-To: <565DB9B9.7030806@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 1 Dec 2015, Wido den Hollander wrote:
> 
> On 01-12-15 16:00, Gregory Farnum wrote:
> > On Tue, Dec 1, 2015 at 5:47 AM, Loic Dachary <loic@dachary.org> wrote:
> >>
> >>
> >> On 01/12/2015 14:10, Wido den Hollander wrote:
> >>> Hi,
> >>>
> >>> While working on mon/PGMonitor.cc I see that there is a lot of
> >>> inconsistency on the code.
> >>>
> >>> A lot of whitespaces, indentation which is not correct, well, a lot of
> >>> things.
> >>>
> >>> Is this something we want to fix? With some scripts we can probably do
> >>> this easily, but it might cause merge hell with people working on features.
> >>
> >> A sane (but long) way to do that is to cleanup when fixing a bug or adding a feature. With (a lot) of patience, it will eventually be better :-)
> > 
> > Yeah, we generally want you to follow the standards in any new code. A
> > mass update of the code style on existing code makes navigating the
> > history a little harder so a lot of people don't like it much, though.
> 
> Understood. But in this case I'm working in PGMonitor.cc. For just 20
> lines of code I probably shouldn't refactor the whole file, should I?

Easiest thing is to fix the code around your change.

I'm also open to a wholesale cleanup since it's a low-traffic file and 
likely won't conflict with other stuff in flight.  But, up to you!

sage
