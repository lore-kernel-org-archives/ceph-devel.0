From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] v0.94.7 Hammer released
Date: Tue, 17 May 2016 21:14:35 +0900
Message-ID: <20160517211435.052df0cb@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1605131020340.20416@cpach.fuggernut.com>
	<CABZ+qq=PUoA8rObv+TwT_NO9nRJnQA4xXOrKKdCp=5Q42Y9pNg@mail.gmail.com>
	<alpine.DEB.2.11.1605170754590.30956@cpach.fuggernut.com>
	<CABZ+qqn3QdDuvjEmodLnXTkDMK7wJiOq3A_wF7-N2zeGV+hv5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:37864 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571AbcEQMOm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 08:14:42 -0400
In-Reply-To: <CABZ+qqn3QdDuvjEmodLnXTkDMK7wJiOq3A_wF7-N2zeGV+hv5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>


Hello,

for the record, I did the exact same sequence (no MDS) on my test clust=
er=20
with exactly the same results.

Didn't report it as I assumed it to be a more noisy (but harmless)
upgrade artifact.

Christian

On Tue, 17 May 2016 14:07:21 +0200 Dan van der Ster wrote:

> On Tue, May 17, 2016 at 1:56 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 17 May 2016, Dan van der Ster wrote:
> >> Hi Sage et al,
> >>
> >> I'm updating our pre-prod cluster from 0.94.6 to 0.94.7 and after
> >> upgrading the ceph-mon's I'm getting loads of warnings like:
> >>
> >> 2016-05-17 10:01:29.314785 osd.76 [WRN] failed to encode map e1031=
16
> >> with expected crc
> >>
> >> I've seen that error is whitelisted in the qa-suite:
> >> https://github.com/ceph/ceph-qa-suite/pull/602/files
> >>
> >> Is it really harmless? (This is the first time I've seen such a
> >> warning).
> >
> > Are you sure you were upgrading from v0.94.6?
>=20
> Absolutely. I first updated the mons, which I restarted into quorum
> with 0.96.7. Then any changes to the osdmap triggered the failed to
> encode warning.
> The upgrade sequence went like this:
>=20
> Update mons 0.94.6 to 0.94.7, restart, quorum. No warnings.
> Update mds's 0.94.6 to 0.94.7, restart. Warnings from ~all osds.
> Update osds 0.94.6 to 0.94.7, restart host by host. The 0.94.6 osds
> printed warnings, the new OSDs did not.
>=20
> > I don't see anything that
> > would trigger these warnings going from .6 to .7, which is strange.
>=20
> Could the osdmap GMT hitset changes have caused it? Commits Mar 24 he=
re:
>=20
>    https://github.com/ceph/ceph/compare/v0.94.6...v0.94.7?expand=3D1
>=20
> > That said, the errors are generally harmless--it just means the
> > monitors are running a different version of the code and the OSDs a=
re
> > pulling maps directly from a mon to ensure they are all in sync.  I=
t's
> > normal during many upgrades, but not expected for this particular
> > jump...
>=20
> Then I'm curious if others are getting this from 0.94.6 to 0.94.7.
> For now I'm waiting to update our prod cluster.
>=20
> Thanks!
>=20
> Dan
>=20
>=20
> >
> > sage
> >
> >
> >
> >
> >> Thanks in advance!
> >>
> >> Dan
> >>
> >>
> >>
> >>
> >> On Fri, May 13, 2016 at 4:21 PM, Sage Weil <sage@redhat.com> wrote=
:
> >> > This Hammer point release fixes several minor bugs. It also
> >> > includes a backport of an improved =E2=80=98ceph osd
> >> > reweight-by-utilization=E2=80=99 command for handling OSDs with
> >> > higher-than-average utilizations.
> >> >
> >> > We recommend that all hammer v0.94.x users upgrade.
> >> >
> >> > For more detailed information, see the release announcement at
> >> >
> >> >         http://ceph.com/releases/v0-94-7-hammer-released/
> >> >
> >> > or the complete changelog at
> >> >
> >> >         http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt
> >> >
> >> > Getting Ceph
> >> > ------------
> >> >
> >> > * Git at git://github.com/ceph/ceph.git
> >> > * Tarball at http://download.ceph.com/tarballs/ceph-0.94.7.tar.g=
z
> >> > * For packages, see http://ceph.com/docs/master/install/get-pack=
ages
> >> > * For ceph-deploy, see
> >> > http://ceph.com/docs/master/install/install-ceph-deploy
> >> > _______________________________________________ ceph-users maili=
ng
> >> > list ceph-users@lists.ceph.com
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> >
> >>
> >>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--=20
Christian Balzer        Network/Systems Engineer               =20
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
