From: Sage Weil <sage@newdream.net>
Subject: Re: ceph/rbd benchmarks
Date: Wed, 24 Aug 2011 10:51:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108241048420.20147@cobra.newdream.net>
References: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
 <CAF3hT9BdUqoCzSEYYWfa0dckVOzDgKVP2s3zyGK5EeAqNR8AFA@mail.gmail.com>
 <Pine.LNX.4.64.1108240943460.20147@cobra.newdream.net>
 <CALFpzo4+oaiuBT5E5EPZk4dcF2D_NDt67UGC5Kj+146LyAvMCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-82642109-1314208306=:20147"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37292 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1HXRqq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 13:46:46 -0400
In-Reply-To: <CALFpzo4+oaiuBT5E5EPZk4dcF2D_NDt67UGC5Kj+146LyAvMCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-82642109-1314208306=:20147
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 Aug 2011, Marcus Sorensen wrote:
> I knew I read the acronym in a pdf somewhere (something from '08 I
> think), but I couldn't find it when I needed it, thanks.
>=20
> Everything was running 3.1-rc1, I checked the kernel source before
> building and it already included the following patches, so I assumed I
> was good on the readahead thing.
>=20
> https://patchwork.kernel.org/patch/1001462/
> https://patchwork.kernel.org/patch/1001432/

Yeah, those two help marginally, but the big fix is=20

http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommit;h=3D78e669966f=
994964581167c6e25c83d22ebb26c6

and you'd probably also want

http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommitdiff;h=3D6468bf=
e33c8e674509e39e43fad6bc833398fee2

Those are in linux-next and will be sent upstream for 3.2-rc1.

Not sure if it's worth rerunning your tests just yet (I want to look at=20
the MDS stuff still), but it should fix the sequential read performance.

sage


>=20
> On Wed, Aug 24, 2011 at 10:46 AM, Sage Weil <sage@newdream.net> wrote:
> > On Wed, 24 Aug 2011, Gregory Farnum wrote:
> >> On Wed, Aug 24, 2011 at 8:29 AM, Marcus Sorensen <shadowsor@gmail.com>=
 wrote:
> >> > Just thought I'd share this basic testing I did, comparing cephfs 0.=
32
> >> > on 3.1-rc1 to nfs as well as rbd to iscsi. I'm sure you guys see a l=
ot
> >> > of this. Any feedback would be appreciated.
> >> >
> >> > The data is here:
> >> >
> >> > http://learnitwithme.com/wp-content/uploads/2011/08/ceph-nfs-iscsi-b=
enchmarks.ods
> >> >
> >> > and the writeup is here:
> >> >
> >> > http://learnitwithme.com/?p=3D303
> >>
> >> We see less of it than you'd think, actually. Thanks!
> >>
> >> To address a few things specifically
> >> Ceph is both the name of the project and of the POSIX-compliant
> >> filesystem. RADOS stands for Reliable Autonomous Distributed Object
> >> Store. Apparently we should publish this a bit more. :)
> >>
> >> Looks like most of the differences in your tests have to do with our
> >> relatively lousy read performance -- this is probably due to lousy
> >> readahead, which nobody's spent a lot of time optimizing as we focus
> >> on stability. Sage made some improvements a few weeks ago but I don't
> >> remember what version of stuff they ended up in. :) (Optimizing
> >> cross-server reads is hard!)
> >
> > The readahead improvements are in the 'master' branch of ceph-client.gi=
t,
> > and will go upstream for Linux 3.2-rc1 (I just missed the 3.1-rc1 cutof=
f).
> > In my tests I was limited by the wire speed with these patches. =A0I'm
> > guessing you were using 3.0 or earlier kernel?
> >
> > The file copy test was also surprising. =A0I think there is a regressio=
n
> > there somewhere, taking a look.
> >
> > sage
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-82642109-1314208306=:20147--
