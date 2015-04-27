From: Loic Dachary <loic@dachary.org>
Subject: Re: Script to extract backports log
Date: Mon, 27 Apr 2015 09:44:05 +0200
Message-ID: <553DE8C5.7080700@dachary.org>
References: <CAHJ4zokWQ0T5RTMvToTgS_YZxPgQV11XTxKGaUX+gnzj5u1B0g@mail.gmail.com> <55184827.1090603@dachary.org> <87k2wy7tcf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ev2mGiCQAr0BpBQFKrQ9aBtbG4Ol62B1L"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53029 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932113AbbD0HoI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 03:44:08 -0400
In-Reply-To: <87k2wy7tcf.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Alistair Israel <aisrael@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ev2mGiCQAr0BpBQFKrQ9aBtbG4Ol62B1L
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

Useful improvement :-) I've updated http://tracker.ceph.com/projects/ceph=
-releases/wiki/HOWTO_write_the_release_notes with your version.

Cheers

On 26/04/2015 18:22, Abhishek L wrote:
> Hi
> Loic Dachary writes:
>=20
>> Hi Alistair,
>>
>> On 29/03/2015 19:27, Alistair Israel wrote:
>>> Hi, Lo=C3=AFc.
>>>
>>> Well, got some 'quality' coding time in over the weekend and managed
>>> to hack this out:
>>> https://gist.github.com/aisrael/b2b78d9dfdd176a232b9
>=20
> I managed to hack this a little to cross reference the issue id from
> the merge commits and pulling the tracker urls using the github
> apis. This was based on the assumption that for backports we follow a
> certain discipline wrt to pull requests where the corresponding issue i=
s
> either mentioned as a part of commit message or as a comment on the pul=
l
> request
>=20
> https://gist.github.com/theanalyst/a0932d863a8f4b0d1b98
>=20
> It is still not perfect, but kind of helped me cut down on the manual
> work of tracking down issue urls when not mentioned in the commit
> message.
>>>
>>> You'll need GitPython (pip install gitpython). I managed to get
>>> hyperlinks to issues, to the commits themselves, and even snuck in th=
e
>>> names of the people who've signed off on the commit.
>>
>> It's going to be helpful to start with the release notes but it will n=
eed manual editing.
>>
>>>
>>> What I can't figure out is how to get the simple component or module
>>> name. For example, from how to get from "common/buffer.cc" (#6003) to=

>>> "buffer".
>>>
>>
>> I don't think it can be done automatically.
>>
>>> Also, using a related issue and commit, how to combine two related
>>> ones. For example, #6614 is related to #6003, and in the release note=
s
>>> both are listed as a single item.
>>
>> One idea would be to group commits that are in the same branch togethe=
r ? When a merge is found, git log xxx^1..xxx^2 will list the commits tha=
t belong to the branch that has been merged. All commits in this branch p=
resumably relate to the same topic.
>>
>>> Finally, do you think I should exclude commits starting with "qa:" or=

>>> "test/...:"?
>>
>> Yes, they are not relevant ;-)
>>
>> I included your snippet in the HOWTO write the release notes at http:/=
/tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_release_not=
es which is linked from http://tracker.ceph.com/projects/ceph-releases/wi=
ki/HOWTO.
>>
>=20
> Cheers
> Abhishek
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Ev2mGiCQAr0BpBQFKrQ9aBtbG4Ol62B1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU96MUACgkQ8dLMyEl6F20oPgCdETZ49KCXKutAlQqEapvWRNvg
ntkAn1mAiqUXHiFtjSWepTHigQV9TtGg
=m3uW
-----END PGP SIGNATURE-----

--Ev2mGiCQAr0BpBQFKrQ9aBtbG4Ol62B1L--
