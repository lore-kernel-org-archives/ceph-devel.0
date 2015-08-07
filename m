From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure packaging and Ceph
Date: Fri, 07 Aug 2015 22:33:37 +0200
Message-ID: <55C51621.2070203@dachary.org>
References: <55C4EA1C.3080601@redhat.com> <55C506AF.4080309@dachary.org> <55C5106D.9070008@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SefjoObDbq9FR9Ex9JgOef6qXvoD1ArTu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35071 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946238AbbHGUdk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 16:33:40 -0400
In-Reply-To: <55C5106D.9070008@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SefjoObDbq9FR9Ex9JgOef6qXvoD1ArTu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/08/2015 22:09, Ken Dreyer wrote:
> On 08/07/2015 01:27 PM, Loic Dachary wrote:
>> Hi Ken,
>>
>> On 07/08/2015 19:25, Ken Dreyer wrote:
>>> Hi Loic,
>>>
>>> I was looking through Ceph's bundled libraries recently and I was
>>> wondering why Ceph bundles its own copy of jerasure.
>>>
>>> Could you give some background on that? Why don't we link to an separ=
ate
>>> system package?
>>
>> Mainly because there is no proper non regression testing of the packag=
es found in the distributions. It is absolutely critical for Ceph to ensu=
re there is no regression because it would mean data loss. The packagers =
do not have that concern in mind right now, nor do they have the infrastr=
ucture to run non regression tests, to the best of my knowledge.
>>
>> Even if they had non regression tests, whenever a new package is publi=
shed, we would need to run Ceph integration tests before it lands in the =
distribution repositories to ensure that everything is fine from the Ceph=
 perspective. The recent work with teuthology and OpenStack simplified th=
is quite a lot and anyone can run teuthology now. However the level of co=
ordination it would require between the jerasure packager and the ceph pa=
ckager is far from what is going on currently.
>>
>> I offered to package jerasure for Debian to solve that problem in the =
Debian / Ubuntu realm. I thought a first step to decouple ceph from jeras=
ure could be that I care for jerasure because I have access to the test i=
nfrastructure and I understand what Ceph needs. And I could gradually mak=
e it possible for any packager to do the same, somehow (I have no idea ho=
w to do that, honestly). Unfortunately the person responsible for packagi=
ng jerasure did not respond favorably to my offer. Nor does he plan to im=
plement integration or non regression tests.
>>
>> Hopefully that will change in the future, but for now I think bundling=
 jerasure with Ceph is the best way to preserve the data of our users.
>>
>=20
> Hi Loic,
>=20
> Thank you, that helps me understand the context a lot more.
>=20
> It sounds like you're concerned that Debian might change their package
> behind Ceph's back, and it could have implications for the way Ceph
> stores its' data.

Yes. Although "behind Ceph's back" suggest malicious behavior but I don't=
 think it's going to be malicious. It's just the way packaging is done cu=
rrently: integration testing with dependencies of a library that are offi=
cial debian packages is not mandatory, it is left at the discretion of th=
e packager.

> I guess at some level it's true that all of Ceph's dependencies could
> impact its behavior.

Yes. I guess I would be less concerned if it was not as critical as data =
corruption and if there were many users and packages depending on jerasur=
e. In my opinion the benefit of using a jerasure package instead of a ver=
sion bundled in Ceph is not worth the risk. A lot of work must be done to=
 introduce integration testing in distributions and lower that risk. I'm =
hopeful this will happen eventually.

> I would like it if Teuthology ran with the "epel-testing" repository
> enabled, for example, so we could catch these sort of problems before
> they went into the main "epel" repo that most users consume. That
> certainly would have caught some issues in the past with the conflicts
> between EPEL and Firefly.
>=20
> Is there some equivalent in Debian?

There is Debian experimental and it could be used for that purpose. The m=
ain problem being to find the resources to analyze and fix the problems f=
ound in epel-testing and debian experimental. Does that work involve fall=
 on the Ceph developers at large ? If so does that mean we collectively a=
gree to add these declared "unstable" repositories in the list of officia=
lly supported repositories ?

It's a discussion I would love to have and, fortunately, we now have the =
technical means to claim "you can run teuthology easily and cheaply". The=
re is no technical blockers and we can dream about building a community t=
o expand the supported distributions. And make it so packaging is always =
associated with integration tests.

Cheers


>=20
> - Ken
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SefjoObDbq9FR9Ex9JgOef6qXvoD1ArTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXFFiEACgkQ8dLMyEl6F22wBgCaA79OXytu8169txdI0B/r/MWw
RmkAn2malUcV0Di3XCcrZXRTiB32NXvK
=OR1D
-----END PGP SIGNATURE-----

--SefjoObDbq9FR9Ex9JgOef6qXvoD1ArTu--
