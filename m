From: Sage Weil <sage@newdream.net>
Subject: Re: async+direct IO in osd journal write
Date: Wed, 21 Sep 2011 10:49:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109211048130.22692@cobra.newdream.net>
References: <CABAwU-bcnVUn3d3HytywkEYdzZySxtBFT6=-nXOGA+ppNhCg0Q@mail.gmail.com>
 <Pine.LNX.4.64.1108192101160.17629@cobra.newdream.net>
 <CABAwU-ZUxH3q=kQck8Evcn-ifvaRxA3Bd+-Fy5_6psCyVVyEdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-326915126-1316627359=:22692"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33757 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab1IURtU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 13:49:20 -0400
In-Reply-To: <CABAwU-ZUxH3q=kQck8Evcn-ifvaRxA3Bd+-Fy5_6psCyVVyEdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-326915126-1316627359=:22692
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Sat, 20 Aug 2011, huang jun wrote:

> 2011/8/20 Sage Weil <sage@newdream.net>:
> > On Sat, 20 Aug 2011, huang jun wrote:
> >> hi,all
> >> Recently,we have a test to compare =A0async i/o and sync i/o in OSD.
> >> The osd jounral was written in sync + direct io mode now, that heavily
> >> infuluenced the write performance.
> >> we use linux aio API. test file size is 40MB,and disk isn't busy.
> >> here is the test result:
> >> =A0 =A0 =A0 =A0 =A0 type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext3
> >> sync write+direct io =A0 =A0 =A04.441s
> >>
> >> async write +direct io =A0 0.462s
> >>
> >> we are glad to see that, so we want to affirm that :
> >> 1) can we use async+direct io to achieve better write performance if
> >> we used osd journal?
> >
> > Do you mean changing the writes in os/FileJournal.cc to be async? =A0As=
 long
> > as the journal does not acknowledge a write until it is stable on disk,
> > that is fine. =A0Async IO would be a nice improvement here; I think
> > currently it's a single sync O_DIRECT io in flight at a time.
> yes, we'd like to change FileJournal.cc to async.
> > The test is to write a 40MB file via which interface? =A0Via a kernel c=
lient
> > mount?
> At persent, we just separately tested the async io,and found that
> would be useful.
> now, we are doing the work to add async code in filejournal.cc, and it
> should be finished next week. and then we'll have a test.

Have you had any luck with this?  This is definitely a change we'd like to=
=20
make.  We suspect the sync journal writes are hurting latency under a lot=
=20
of workloads.

sage
--557981400-326915126-1316627359=:22692--
