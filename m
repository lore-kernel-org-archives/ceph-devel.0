From: Loic Dachary <loic@dachary.org>
Subject: Re: Preparing hammer v0.94.5
Date: Sat, 03 Oct 2015 20:15:20 +0200
Message-ID: <56101B38.5030100@dachary.org>
References: <560F9426.80208@dachary.org> <CAP3mxSxnwS=3uNEFJTHGYYqo6FkQaFkENMmWzg9jyOniBDpN6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7hdfcEk3kfOE1OFxgEFNv7HsSpjdL1GCO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37009 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750733AbbJCSPW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Oct 2015 14:15:22 -0400
In-Reply-To: <CAP3mxSxnwS=3uNEFJTHGYYqo6FkQaFkENMmWzg9jyOniBDpN6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7hdfcEk3kfOE1OFxgEFNv7HsSpjdL1GCO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/10/2015 19:47, Abhishek Varshney wrote:
> Hi Loic,
>=20
>=20
> On Sat, Oct 3, 2015 at 2:09 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Abhishek,
>>
>> The v0.94.5 version was added to the list of versions and you should n=
ow be able to create the issue to track its progress. Since v0.94.4 is in=
 the process of being tested, most of the ~50 backports in flight[1] will=
 actually be for v0.94.5 and we can start testing them. The worst that ca=
n happen is that a few of them shift to v0.94.4 because they are needed a=
fter all. From the point of view of v0.94.5 that's all the same.
>>
>> The next step is to create the issue[2] and you should have all the cr=
edentials you need to do so.
>=20
> I have created a new issue to keep track of hammer v0.94.5 (
> http://tracker.ceph.com/issues/13356 ). I would next prepare an
> integration branch with all the in-flight backports and update the
> tracker for v0.94.5.

The hammer-backport has them already and it compiles ( http://ceph.com/gi=
tbuilder.cgi ). I'll schedule suites for you since you do not have access=
 to the sepia lab yet. You'll have a lot of fun sorting out the results.

>=20
>>
>> This will be your first time driving a point release but there should =
be no surprises: you already know all about the process :-)
>=20
> I guess I know the process well now, but, I am sure I will need your
> support and motivation in getting it through :)

I'll be around :-)=20

>=20
>>
>> Cheers
>>
>> [1] https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+milestone=
%3Ahammer
>> [2] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_wo=
rking_on_a_new_point_release#Create-new-task
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7hdfcEk3kfOE1OFxgEFNv7HsSpjdL1GCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYQGzgACgkQ8dLMyEl6F21KggCghB7VED0mj+lbuegZOXdG1UW5
JVwAn3Orfq52zmkmtytPAKsFQz8e2zHn
=QiHk
-----END PGP SIGNATURE-----

--7hdfcEk3kfOE1OFxgEFNv7HsSpjdL1GCO--
