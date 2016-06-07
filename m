From: Sage Weil <sage@newdream.net>
Subject: Re: new scrub and repair discussion
Date: Tue, 7 Jun 2016 09:03:23 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606070900330.6221@cpach.fuggernut.com>
References: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com> <CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com> <CAJE9aOMDLyfOVn-n18m3Ftqc3G=N-71we9qiUuhBSX+qnJBF9Q@mail.gmail.com> <CABZ+qqm5cxnHWJ_ZWm1qXgV_SBiwX7Zfr2fvbNrNfWc289xNGQ@mail.gmail.com>
 <CAJE9aOOa4yQ2wAHhVotog-Nvr9gQNBpwpiAwC1HXT3QLL_QJgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43264 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbcFGNC7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 09:02:59 -0400
In-Reply-To: <CAJE9aOOa4yQ2wAHhVotog-Nvr9gQNBpwpiAwC1HXT3QLL_QJgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 7 Jun 2016, kefu chai wrote:
> Dan, your comments are more like feature requests related to current
> scrub, instead to the
> new scrub/repair feature design. reply inlined.
> 
> On Fri, May 27, 2016 at 8:03 PM, Dan van der Ster <dan@vanderster.com> wrote:
> > Hi all,
> >
> > I have some high-level feedback for scrub/repair. Apologies if some of
> > these are already taken into account.
> >
> > 1. ceph pg cancel-scrub <pgid>: For a variety of reasons it would be
> > useful to be able to cancel an ongoing (deep-)scrub on a PG. The
> > no(deep-)scrub flags work more like a pause, but today if I want to
> > stop a scrub it requires an OSD to be restarted.
> 
> it's a feature request. we did have this feature in rados API before, but it was
> not exposed by the rados cli, and hence removed. if you'd like to get it back,
> maybe you could file an issue over tracker?
> 
> > 2. ceph pg scrub/deep-scrub/repair often do not start because the
> > master OSD cannot get a reservation on all the replica/EC-part OSDs
> > (due to osd max scrubs). It is possible using some strange gymnastics
> > to force PG to start repairing/scrubbing immediately, but those are
> > not intuitive. IMHO, ceph pg scrub/deep-scrub/repair <pgid> should
> > start immediately regardless of the 'osd max scrubs' value.
> 
> i think it's more a design decision.

My concern with this one is that lots of people have written their own 
scrub scheduling scripts (e.g., because of scheduling problems in the 
past).  I'd favor adding a --force-now option or separate command for an 
immediate scrub.

> > 5. Do we even need the shallow scrub functionality? I'm very curious
> > how many problems that shallow scrubbing finds IRL compared with
> > deep-scrubbing. Does ceph track these stats independently?
> 
> i don't have any numbers to support your theory or against it. but i think
> having a light-weight scrub is necessary.

The lightweight scrub mostly catches replication/recovery bugs.  It's 
useful enough just as a testing/development tool.  I'm not sure that it is 
as useful for users, though...

sage
