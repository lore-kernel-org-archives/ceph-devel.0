From: Sage Weil <sage@newdream.net>
Subject: Re: ceph encoding optimization
Date: Sun, 8 Nov 2015 06:28:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511080627300.27153@cobra.newdream.net>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com> <CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com> <CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com> <34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
 <CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com> <CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44316 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbKHO2g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Nov 2015 09:28:36 -0500
In-Reply-To: <CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>, =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 7 Nov 2015, Haomai Wang wrote:
> Hi sage,
> 
> Could we know about your progress to refactor MSubOP and hobject_t,
> pg_stat_t decode problem?
> 
> We could work on this based on your work if any.

See Piotr's last email on this thead... it has Josh's patch attached.

sage


> 
> 
> On Thu, Nov 5, 2015 at 1:29 AM, Haomai Wang <haomai@xsky.com> wrote:
> > On Thu, Nov 5, 2015 at 1:19 AM, Piotr.Dalek@ts.fujitsu.com
> > <Piotr.Dalek@ts.fujitsu.com> wrote:
> >>> -----Original Message-----
> >>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >>> owner@vger.kernel.org] On Behalf Of ???
> >>> Sent: Wednesday, November 04, 2015 4:34 PM
> >>> To: Gregory Farnum
> >>> Cc: ceph-devel@vger.kernel.org
> >>> Subject: Re: ceph encoding optimization
> >>>
> >>> I agree with pg_stat_t (and friends) is a good first start.
> >>> The eversion_t and utime_t are also good choice to start because they are
> >>> used at many places.
> >>
> >> On Ceph Hackathon, Josh Durgin made initial steps in right direction in terms of pg_stat_t encoding and decoding optimization, with the endianness-awareness thing left out. Even in that state, performance improvements offered by this change were huge enough to make it worthwhile. I'm attaching the patch, but please note that this is prototype and based on mid-August state of code, so you might need to take that into account when applying the patch.
> >
> > Cool, it's exactly we want to see.
> >
> >>
> >>
> >> With best regards / Pozdrawiam
> >> Piotr Da?ek
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
