From: Gregory Farnum <greg@inktank.com>
Subject: Re: domino-style OSD crash
Date: Wed, 4 Jul 2012 09:21:32 -0700
Message-ID: <A1B0B821610446B587EA459CA7D88ECF@inktank.com>
References: <4FCC7573.3000704@univ-nantes.fr>
 <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
 <4FF2AFEB.1010403@univ-nantes.fr>
 <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
 <4FF35C01.4070400@univ-nantes.fr>
 <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
 <4FF3F98C.30602@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55599 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab2GDQV3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:21:29 -0400
Received: by pbbrp8 with SMTP id rp8so11247631pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 09:21:29 -0700 (PDT)
In-Reply-To: <4FF3F98C.30602@univ-nantes.fr>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Tommi Virtanen <tv@inktank.com>, Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wednesday, July 4, 2012 at 1:06 AM, Yann Dupont wrote:
> Le 03/07/2012 23:38, Tommi Virtanen a =C3=A9crit :
> > On Tue, Jul 3, 2012 at 1:54 PM, Yann Dupont <Yann.Dupont@univ-nante=
s.fr (mailto:Yann.Dupont@univ-nantes.fr)> wrote:
> > > In the case I could repair, do you think a crashed FS as it is ri=
ght now is
> > > valuable for you, for future reference , as I saw you can't repro=
duce the
> > > problem ? I can make an archive (or a btrfs dump ?), but it will =
be quite
> > > big.
> > =20
> > =20
> > At this point, it's more about the upstream developers (of btrfs et=
c)
> > than us; we're on good terms with them but not experts on the on-di=
sk
> > format(s). You might want to send an email to the relevant mailing
> > lists before wiping the disks.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordom=
o@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> =20
> =20
> Well, I probably wasn't clear enough. I talked about crashed FS, but =
i =20
> was talking about ceph. The underlying FS (btrfs in that case) of 1 n=
ode =20
> (and only one) has PROBABLY crashed in the past, causing corruption i=
n =20
> ceph data on this node, and then the subsequent crash of other nodes.
> =20
> RIGHT now btrfs on this node is OK. I can access the filesystem witho=
ut =20
> errors.
> =20
> For the moment, on 8 nodes, 4 refuse to restart .
> 1 of the 4 nodes was the crashed node , the 3 others didn't had brobl=
em =20
> with the underlying fs as far as I can tell.
> =20
> So I think the scenario is :
> =20
> One node had problem with btrfs, leading first to kernel problem , =20
> probably corruption (in disk/ in memory maybe ?) ,and ultimately to a=
 =20
> kernel oops. Before that ultimate kernel oops, bad data has been =20
> transmitted to other (sane) nodes, leading to ceph-osd crash on those=
s =20
> nodes.

I don't think that's actually possible =E2=80=94 the OSDs all do quite =
a lot of interpretation between what they get off the wire and what goe=
s on disk. What you've got here are 4 corrupted LevelDB databases, and =
we pretty much can't do that through the interfaces we have. :/
 =20
> =20
> If you think this scenario is highly improbable in real life (that is=
, =20
> btrfs will probably be fixed for good, and then, corruption can't =20
> happen), it's ok.
> =20
> But I wonder if this scenario can be triggered with other problem, an=
d =20
> bad data can be transmitted to other sane nodes (power outage, out of=
 =20
> memory condition, disk full... for example)
> =20
> That's why I proposed you a crashed ceph volume image (I shouldn't ha=
ve =20
> talked about a crashed fs, sorry for the confusion)

I appreciate the offer, but I don't think this will help much =E2=80=94=
 it's a disk state managed by somebody else, not our logical state, whi=
ch has broken. If we could figure out how that state got broken that'd =
be good, but a "ceph image" won't really help in doing so.

I wonder if maybe there's a confounding factor here =E2=80=94 are all y=
our nodes similar to each other, or are they running on different kinds=
 of hardware? How did you do your Ceph upgrades? What's ceph -s display=
 when the cluster is running as best it can?
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
