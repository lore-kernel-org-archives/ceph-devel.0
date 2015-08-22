From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Sat, 22 Aug 2015 18:57:18 +0200 (CEST)
Message-ID: <2058625694.43353019.1440262638523.JavaMail.zimbra@oxygem.tv>
References: <55D409F0.3050802@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com> <55D4E9BE.8000309@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com> <EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com> <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com> <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1DC70@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36002 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbbHVQ5V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Aug 2015 12:57:21 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1DC70@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Milosz Tanski <milosz@adfin.com>, Shishir Gowda <Shishir.Gowda@sandisk.com>, Stefan Priebe <s.priebe@profihost.ag>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>Wanted to know is there any reason we didn't link client libraries wi=
th tcmalloc at the first place (but did link only OSDs/mon/RGW) ?

Do we need to link client librairies ?

I'm building qemu with jemalloc , and it's seem to be enough.



----- Mail original -----
De: "Somnath Roy" <Somnath.Roy@sandisk.com>
=C3=80: "Sage Weil" <sage@newdream.net>, "Milosz Tanski" <milosz@adfin.=
com>
Cc: "Shishir Gowda" <Shishir.Gowda@sandisk.com>, "Stefan Priebe" <s.pri=
ebe@profihost.ag>, "aderumier" <aderumier@odiso.com>, "Mark Nelson" <mn=
elson@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Samedi 22 Ao=C3=BBt 2015 18:15:36
Objet: RE: Ceph Hackathon: More Memory Allocator Testing

Yes, even today rocksdb also linked with tcmalloc. It doesn't mean all =
the application using rocksdb needs to be built with tcmalloc.=20
Sage,=20
Wanted to know is there any reason we didn't link client libraries with=
 tcmalloc at the first place (but did link only OSDs/mon/RGW) ?=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Sage Weil [mailto:sage@newdream.net]=20
Sent: Saturday, August 22, 2015 6:56 AM=20
To: Milosz Tanski=20
Cc: Shishir Gowda; Somnath Roy; Stefan Priebe; Alexandre DERUMIER; Mark=
 Nelson; ceph-devel=20
Subject: Re: Ceph Hackathon: More Memory Allocator Testing=20

On Fri, 21 Aug 2015, Milosz Tanski wrote:=20
> On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda=20
> <Shishir.Gowda@sandisk.com> wrote:=20
> > Hi All,=20
> >=20
> > Have sent out a pull request which enables building librados/librbd=
 with either tcmalloc(as default) or jemalloc.=20
> >=20
> > Please find the pull request @=20
> > https://github.com/ceph/ceph/pull/5628=20
> >=20
> > With regards,=20
> > Shishir=20
>=20
> Unless I'm missing something here, this seams like the wrong thing to=
=2E=20
> Libraries that will be linked in by other external applications shoul=
d=20
> not have a 3rd party malloc linked in there. That seams like an=20
> application choice. At the very least the default should not be to=20
> link in a 3rd party malloc.=20

Yeah, I think you're right.=20

Note that this isn't/wasn't always the case, though.. on precise, for i=
nstance, libleveldb links libtcmalloc. They stopped doing this sometime=
 before trusty.=20

sage=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
