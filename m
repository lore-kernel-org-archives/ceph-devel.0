From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Comments on Ceph distributed parity implementation
Date: Tue, 18 Jun 2013 18:35:45 -0700
Message-ID: <622F4407872BA447A16110F65453358C01A4D3D29DAB@FMSAMAIL.fmsa.local>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
 <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local>
 <51C00FDB.6030803@polytech.univ-nantes.fr>
 <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu25.fnanic.fujitsu.com ([192.240.6.15]:60957 "EHLO
	fujitsu25.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932644Ab3FSBd0 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Jun 2013 21:33:26 -0400
In-Reply-To: <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Plank <plank@cs.utk.edu>, =?iso-8859-1?Q?Beno=EEt_Parrein?= <benoit.parrein@polytech.univ-nantes.fr>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Benoit,

I agree with you. Redundancy and availability, as well as performance f=
or both encoding and reconstruction, are related. There are inherent tr=
ade-offs between them. The beautiful thing about Ceph is the support fo=
r multiple pools which can have different attributes. Today we have poo=
ls with differing performance and redundancy characteristics. This may =
add complexity when adding erasure coding. Ideally, a user could create=
 a pool that favored capacity and another one that favored availability=
 and another... etc.

Jim, I like the image of your "space-overhead/fault-tolerance curve" be=
cause I see our issue as multiple points on the curve rather than a sin=
gle one. From a performance perspective, I agree that the CPU burden is=
 not really an issue, but inter-node communication is.

All the best
Paul

On June 18, 2013 at 7:23 AM, James Plank wrote:
>=20
> Hi all -- thank you for including me on this thread, although I have
> little substantive to add.  At the moment, my sole focus is finishing=
 a
> journal paper about GF implementations, with a concomitant GF-complet=
e
> release to accompany it.  I agree that the CPU burden of the GF arith=
metic
> will not be a bottleneck in your system, regardless of which
> implementation you use, as long as you stay at or below GF(2^16).  If=
 you
> want to go higher, GF-complete will help.  When we put out a new rele=
ase
> (the code will be ready within two weeks, however, the documentation =
is
> lagging), I'll let you know.  I think LRC is a nice coding paradigm,
> although I imagine that it has IP issues with Microsoft.  I don't hav=
e
> first-hand experience with network/regenerating codes, and I'll be ho=
nest
> -- there have been so many papers in that realm that I am not up to d=
ate
> on them.
>=20
> Is there a question on which you'd like some help?  It sounds as thou=
gh
> you are at two decision points: What code should you use, and at whic=
h
> point on the space-overhead/fault-tolerance curve would you like to b=
e?
>=20
> Best wishes,
>=20
> Jim
> ----------
>=20
> On Jun 18, 2013, at 3:44 AM, Beno=EEt Parrein wrote:
>=20
> > Hi Paul,
> >
> > thank you for your message
> >
> > from my point, LRC focuses on the repairing problem. how to reconst=
ruct
> destroyed node to maintain the same availability by the distributed
> system?
> > in this context they can even go below 1x rate by introducing local
> parity on classical Reed Solomon blocks (but they pay a supplementary
> overhead). see excellent Alex Dimakis's papers for that. but, still f=
rom
> my point, the same relationship between redundancy and availability o=
ccurs
> (if you consider binomial model for your loses).
> >
> > best
> > bp
> >
> >
> > Le 17/06/2013 18:55, Paul Von-Stamwitz a =E9crit :
> >> Loic,
> >>
> >> As Benoit points out, Mojette uses discrete geometry rather than
> algebra, so simple XOR is all that is needed.
> >>
> >> Benoit,
> >>
> >> Microsoft's paper states that their [12,2,2] LRC provides better
> availability than 3x replication with 1.33x efficiency. 1.5x is certa=
inly
> a good number. I'm just pointing out that better efficiency can be ha=
d
> without losing availibity.
> >>
> >> All the best,
> >> Paul
> >
> > <benoit_parrein.vcf>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
