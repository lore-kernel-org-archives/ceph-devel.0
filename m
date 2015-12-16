From: Andrew Bartlett <abartlet@catalyst.net.nz>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Wed, 16 Dec 2015 15:13:42 +1300
Message-ID: <1450232022.9871.30.camel@catalyst.net.nz>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	 <CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
	 <1450130526.1035.24.camel@millnert.se>
	 <CAJ4mKGZmS3ThQcR3dZXoV3c3Kz1qRoHDRH=iSB6AUyKR1bwrPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:57936 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965654AbbLPCXL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 21:23:11 -0500
In-Reply-To: <CAJ4mKGZmS3ThQcR3dZXoV3c3Kz1qRoHDRH=iSB6AUyKR1bwrPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Martin Millnert <martin@millnert.se>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adam Kupczyk <akupczyk@mirantis.com>

On Mon, 2015-12-14 at 14:32 -0800, Gregory Farnum wrote:
> On Mon, Dec 14, 2015 at 2:02 PM, Martin Millnert <martin@millnert.se>
> wrote:
> > On Mon, 2015-12-14 at 12:28 -0800, Gregory Farnum wrote:
> > > On Mon, Dec 14, 2015 at 5:17 AM, Radoslaw Zarzynski
> > <snip>
> > > > In typical case ciphertext data transferred from OSD to OSD can
> > > > be
> > > > used without change. This is when both OSDs have the same
> > > > crypto key
> > > > version for given placement group. In rare cases when crypto
> > > > keys are
> > > > different (key change or transition period) receiving OSD will
> > > > recrypt
> > > > with local key versions.
> > >=20
> > > I don't understand this part at all. Do you plan to read and
> > > rewrite
> > > the entire PG whenever you change the "key version"? How often do
> > > you
> > > plan to change these keys? What is even the point of changing
> > > them,
> > > since anybody who can control an OSD can grab the entire current
> > > key
> > > set?
> >=20
> > You may have leaked keys without having leaked ciphertext.
> > The typical use case for FDE/SED is IMO being able to RMA drives.
> > Nothing more than that.
>=20
> Yeah, but you necessarily need to let people keep using the old key
> *and* give them the new one on-demand if they've got access to the
> system, in order to allow switching to the new key. You need to wait
> for all the data to actually be rewritten with the new key before you
> can consider it secure again, and that'll take a loooong time. I'm
> not
> saying there isn't threat mitigation here, just that I'm not sure
> it's
> useful against somebody who's already obtained access to your
> encryption keys =E2=80=94 if they've gotten those it's unlikely they =
won't
> have gotten OSD keys as well, and if they've got network access they
> can impersonate an OSD and get access to whatever data they like.
>=20
> I guess that still protects against an external database hack from
> somebody who gets access to your old hard drives, but...*shrug*

An important part of why we moved to LUKS for key dm-crypt is that LUKS
does some useful things to allow a form of key rotation.=C2=A0

The master key is never changed (except at reformat), but it also is
never disclosed beyond the host's kernel. =C2=A0What is stored on the d=
isks
and/or on the key servers is a key-encryption-key. =C2=A0

The process for rotating the key encryption key is pretty sensible,
given the constraints, because they go to good lengths to rewrite the
blocks where the old KEK encrypted the master key.=C2=A0

> Yeah, I'd rather see dm-crypt get done well rather than in-Ceph
> encryption like this. If we want to protect data I think that's a lot
> more secure (and will *stay* that way since encryption is all that
> project does), and adding TLS or similar to the messenger code would
> give us on-the-wire protection from the clients to the disk.
> -Greg

The the good reason to use dm-crypt is that novel cryptography is NOT a
good thing. =C2=A0The dm-crypt stuff is well used and well understood, =
and
any potential attacks against it are likely to be widely reported and
property analysed.=C2=A0

Andrew Bartlett

--=C2=A0
Andrew Bartlett
https://samba.org/~abartlet/
Authentication Developer, Samba Team         https://samba.org
Samba Development and Support, Catalyst IT  =20
https://catalyst.net.nz/services/samba






--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
