From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Comments on Ceph distributed parity implementation
Date: Mon, 17 Jun 2013 09:55:30 -0700
Message-ID: <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
 <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu24.fnanic.fujitsu.com ([192.240.6.14]:59345 "EHLO
	fujitsu24.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173Ab3FQQx1 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 12:53:27 -0400
In-Reply-To: <51BE2EB1.2020807@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, =?iso-8859-1?Q?Beno=EEt_Parrein?= <benoit.parrein@polytech.univ-nantes.fr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "James S. Plank" <plank@cs.utk.edu>

Loic,

As Benoit points out, Mojette uses discrete geometry rather than algebr=
a, so simple XOR is all that is needed.

Benoit,

Microsoft's paper states that their [12,2,2] LRC provides better availa=
bility than 3x replication with 1.33x efficiency. 1.5x is certainly a g=
ood number. I'm just pointing out that better efficiency can be had wit=
hout losing availibity.

All the best,
Paul

On 6/16/2013 02:31 PM Loic Dachary wrote:
> Hi Beno=EEt,
>=20
> From the ( na=EFve ) point of view of engineering, performances are
> important. The recent works of James Plank ( cc'ed ) greatly improved=
 them
>  and I'm looking forward to the next version of jerasure
> ( http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627.html ). Rozof=
s
> Mojette Transform implementation
> ( https://github.com/rozofs/rozofs/blob/master/rozofs/common/transfor=
m.h &
> https://github.com/rozofs/rozofs/blob/master/rozofs/common/transform.=
cc )
> does not seem to make use of SIMD. Is it because the performances are=
 good
> enough to not require them ?
>=20
> Cheers
>=20
> On 06/16/2013 09:51 PM, Beno=EEt Parrein wrote:
> > Paul Von-Stamwitz <PVonStamwitz <at> us.fujitsu.com> writes:
> >
> > Hi Paul,
> >
> >>
> >> Loic, I know nothing about Mojette Transforms. From what little I
> gleaned,
> > it might be good for repair
> >> (needing only a subset of chunks within a range to recalculate a
> missing
> > chunk) but I'm worried about the
> >> storage efficiency. RozoFS claims 1.5x. I'd like to do better than=
 that.
> >>
> >> All the best,
> >> Paul
> >>
> >
> > If you want to do better than that you will probably lose in
> availability.
> > 1.5x give the same availability than 3 replicats and that for any k=
ind
> of
> > erasure coding.
> > FYI, Mojette transform has no constraint in terms of Galois fields.=
 It
> is the
> > big advantage to use discrete geometry rather than algebra.
> >
> > best regards,
> > bp
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do
> nothing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
