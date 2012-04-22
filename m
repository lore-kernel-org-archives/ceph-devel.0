From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about bucket algorithm and bucket choose
Date: Sat, 21 Apr 2012 21:21:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204212120460.29786@cobra.newdream.net>
References: <CALwGbPKqXyubH1O-cBoYm-LaJ86LR3QOzzd=mYyL8HESx1+13g@mail.gmail.com>
 <Pine.LNX.4.64.1204161425180.31853@cobra.newdream.net>
 <CALwGbPJ1C4uL=VZ455WBV=JkqhGarBQcajRzWmuXtTLZUa3byQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1576963055-1335068485=:29786"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37325 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab2DVEV1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Apr 2012 00:21:27 -0400
In-Reply-To: <CALwGbPJ1C4uL=VZ455WBV=JkqhGarBQcajRzWmuXtTLZUa3byQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1576963055-1335068485=:29786
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 21 Apr 2012,  wrote:
> Oh, perhaps I find the reason for the bad behavior.
>=20
> According to Jenkins hash algorithm, any number of lower bits of the
> hash result is uniformly distributed, but the modular arithmetic can
> destroy the uniform distribution, unless the size of the bucket is the
> power of 2!
>=20
> Am I right?

Maybe, but I'm not ready to blame the hash yet.  Is there a specific map=20
you're looking at?  Can you attach that so we can be sure we're talking=20
about the same thing?

sage


>=20
> On Tue, Apr 17, 2012 at 5:29 AM, Sage Weil <sage@newdream.net> wrote:
> > On Sun, 15 Apr 2012, =A0wrote:
> >> Hi everyone.
> >>
> >> One question is about performance of bucket algorithms, it seems that
> >> on every aspect, straw bucket is at least not worse than list bucket.
> >> So does it mean we shall always use straw bucket instead of list
> >> bucket?
> >
> > Well, list on average will calculate a hash for 1/2 of the items, while
> > straw always does every item. =A0That said, we use straw by default for=
 all
> > buckets. =A0As long as there is _some_ hierarchy, the individual bucket=
s
> > don't get too big, and CRUSH is so cheap anyway that it doesn't really
> > matter... especially when compared to the cost of moving data due to a
> > less-than-optimal remapping.
> >
> >> I was browsing branch tree of ceph to trace back earlier versions of
> >> the implementation. I noticed that crush_uniform_bucket_choose has
> >> been significantly changed. I read the comment which said the original
> >> method (seems to be described in the thesis) is not random enough and
> >> has some bad behavior, but I don't know what kind of bad behavior is
> >> that. For what reason a random permutation is a better choice?
> >
> > If I remember correctly, the problem was that it would favor certain no=
des
> > when there were too many or certain patterns of failures within the
> > bucket (I don't remember the details). =A0The original algorithmw as
> > supposed to give you a random permutation too, but it didn't always do
> > that.
> >
> > I think that code is also used as a fallback if the sampling fails to
> > return a good value after too many tries.
> >
> > This will be one of the things we look at in a month or two when we
> > take a careful look at CRUSH.
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1576963055-1335068485=:29786--
