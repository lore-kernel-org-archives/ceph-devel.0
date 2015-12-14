From: Loic Dachary <loic@dachary.org>
Subject: Re: Stable release HOWTO: hunt for lost page
Date: Mon, 14 Dec 2015 15:58:47 +0100
Message-ID: <566ED927.7040400@dachary.org>
References: <566ED01C.2020306@dachary.org>
 <CAP3mxSwdrEN72xxCyCsvjkT5DSrk+jw3W2DnQ5sUL1grHZhFBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CeA504fJNCFsPVKFG7DfJKxMKqJoOpmq6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49865 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751334AbbLNO6t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 09:58:49 -0500
In-Reply-To: <CAP3mxSwdrEN72xxCyCsvjkT5DSrk+jw3W2DnQ5sUL1grHZhFBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CeA504fJNCFsPVKFG7DfJKxMKqJoOpmq6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On 14/12/2015 15:40, Abhishek Varshney wrote:
> Hi Loic,
>=20
> I have revived the page at
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_triage_incomi=
ng_backport_pull_requests
> from https://web.archive.org with a version cached on 4th October.

Perfect ! It has not changed much in the past few month, I can't think of=
 something we added that would be missing.

> Please review it, in case there are any changes to it.
>=20
> Disabling the page deletion sounds like a good idea.

Done.

Cheers

>=20
> Thanks
> Abhishek
>=20
> On Mon, Dec 14, 2015 at 7:50 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> It looks like we've lost http://tracker.ceph.com/projects/ceph-release=
s/wiki/HOWTO_triage_incoming_backport_pull_requests . We can re-write it,=
 of course, it's not that complex. But looking at the index I can't find =
it ( http://tracker.ceph.com/projects/ceph-releases/wiki/index ) and the =
activity backlog ( http://tracker.ceph.com/projects/ceph-releases/activit=
y?utf8=3D%E2%9C%93&show_issues=3D1&show_wiki_edits=3D1 ) does not show an=
 event when a page is deleted.
>>
>> I suppose it's an accident and I propose we disable the page deletion =
feature to avoid such mistakes in the future (pages can be renamed to thi=
ngs like REMOVE-ME instead ;-).
>>
>> What do you think ?
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--CeA504fJNCFsPVKFG7DfJKxMKqJoOpmq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZu2ScACgkQ8dLMyEl6F23JzQCgiZ1YkbbgG16i1sv+rvPbeQD/
PrwAn1++R6dEhNiWNfhHavGlT086keId
=x1fT
-----END PGP SIGNATURE-----

--CeA504fJNCFsPVKFG7DfJKxMKqJoOpmq6--
