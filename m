From: Wido den Hollander <wido@42on.com>
Subject: Re: jewel v10.2.1 status update
Date: Wed, 11 May 2016 08:44:24 +0200 (CEST)
Message-ID: <518522665.1448.1462949064145@ox.pcextreme.nl>
References: <5731B60E.3090603@dachary.org>
 <robbat2-20160511T001522-032231734Z@orbis-terrarum.net>
 <CADRKj5Q0tFwBaH1Cx93b6WKaUwdB_Pj-RVyk2SeGo7Tb3Zm6eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48677 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbcEKGo0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 02:44:26 -0400
In-Reply-To: <CADRKj5Q0tFwBaH1Cx93b6WKaUwdB_Pj-RVyk2SeGo7Tb3Zm6eg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Op 11 mei 2016 om 2:31 schreef Yehuda Sadeh-Weinraub <yehuda@redhat.com>:
> 
> 
> On Tue, May 10, 2016 at 5:21 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > On Tue, May 10, 2016 at 12:21:02PM +0200,  Loic Dachary wrote:
> >> Hi,
> >>
> >> All jewel pull requests (
> >> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ajewel
> >> ) except two ( https://github.com/ceph/ceph/pull/8868 and
> >> https://github.com/ceph/ceph/pull/9010 ) have been merged into the
> >> jewel-backports integration branch (
> >> http://tracker.ceph.com/issues/15317#note-4 ). They include all
> >> backports done by Yehuda and Jason (except 9010) in the past 24h
> >> hours. The suites are going to be scheduled later today (when
> >> gitbuilder is done creating the packages) and their progress can be
> >> tracked at http://tracker.ceph.com/issues/15317#note-5 etc.
> >
> > I've been waiting 3 weeks now for my staticsites PRs to be merged :-(.
> > https://github.com/ceph/ceph/pull/8633
> > https://github.com/ceph/ceph/pull/8669
> >
> > The matching issues:
> > http://tracker.ceph.com/issues/15531
> > http://tracker.ceph.com/issues/15532
> 
> 
> Right. I didn't get to review these as I was working on getting a few
> critical fixes sorted out. I will get to your fixes now and we'll
> probably get them into 10.2.2.
> 

So while we are at it, can I point you towards:

* https://github.com/ceph/ceph/pull/8528
* https://github.com/ceph/ceph/pull/8441

Thanks!

Wido

> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
