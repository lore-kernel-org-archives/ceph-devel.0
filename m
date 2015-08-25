From: Loic Dachary <loic@dachary.org>
Subject: hammer integration (was: Enabling contributors to run teuthology
 suites)
Date: Tue, 25 Aug 2015 10:37:05 +0200
Message-ID: <55DC2931.5000707@dachary.org>
References: <55DB0553.90406@dachary.org> <CAP3mxSyrzTdozmsTKCfcnSc=mV5MfBazYASNDrsqmVHZkFLHfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WBm7DgEhxf6gT3oEckvVEUPLCwjCbxHDR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43394 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932103AbbHYIhI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2015 04:37:08 -0400
In-Reply-To: <CAP3mxSyrzTdozmsTKCfcnSc=mV5MfBazYASNDrsqmVHZkFLHfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WBm7DgEhxf6gT3oEckvVEUPLCwjCbxHDR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On 25/08/2015 07:57, Abhishek Varshney wrote:> Hi Loic,
>=20
> Thanks for the kind gesture and providing access to run teuthology runs=
=2E I was able to run the dummy test suite, monitor its progress and uplo=
ad the logs as described here https://github.com/dachary/teuthology/tree/=
openstack#openstack-backend.
>=20
> Before I re-populate the hammer-backports integration branch (issue #12=
701 <http://tracker.ceph.com/issues/12701>) and run the integration tests=
 on it, it would be nice if you can mark the earlier hammer backports PR =
with DNM (https://github.com/ceph/ceph/pull/5571)=20

Done

> and review if there are any other PRs that have to be marked DNM for ha=
mmer.

I think that's all there is.

Cheers

> Thanks
> Abhishek
>=20
> On Mon, Aug 24, 2015 at 5:21 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Sam,
>=20
>     Maybe we can start an experiment to enable contributors to run thei=
r own teuthology suites. It would go like this:
>=20
>     * Send an OpenStack credential file to the author of a pull request=

>     * Ask her/him to follow the instructions at https://github.com/dach=
ary/teuthology/tree/openstack#openstack-backend to verify it works
>     * Ask her/him to run and debug a specific suite by providing the co=
mmand line such as
>=20
>        teuthology-openstack --key-name myself --key-filename ~/Download=
s/myself --suite ceph-disk --suite-branch wip-11881-multipath --filter=3D=
ubuntu_14.04 --ceph wip-11881-multipath
>=20
>     We don't yet have a long term solution to fund this kind of testing=
, but that's not a blocker. It's cheap enough to setup and I'm willing to=
 spend 500 euros per month of my own money for the time being. It's reall=
y selfish of me : enabling contributors will save me time that's worth mo=
re than 500 euros ;-)
>=20
>     The details of how the first account has been setup are at http://t=
racker.ceph.com/projects/ceph/wiki/RunTeuthology
>=20
>     What do you think ?
>=20
>     Cheers
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------
>=20
> This email and any files transmitted with it are confidential and inten=
ded solely for the use of the individual or entity to whom they are addre=
ssed. If you have received this email in error please notify the system m=
anager. This message contains confidential information and is intended on=
ly for the individual named. If you are not the named addressee you shoul=
d not disseminate, distribute or copy this e-mail. Please notify the send=
er immediately by e-mail if you have received this e-mail by mistake and =
delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any a=
ction in reliance on the contents of this information is strictly prohibi=
ted. Although Flipkart has taken reasonable precautions to ensure no viru=
ses are present in this email, the company cannot accept responsibility f=
or any loss or damage arising from the use of this email or attachments
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WBm7DgEhxf6gT3oEckvVEUPLCwjCbxHDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXcKTEACgkQ8dLMyEl6F23UdgCfexG7qdo0D1BSP3zWvm2nYza8
t/MAnik+h1N9Z4Yg7lQRQIRyz2v1hlHW
=iGyh
-----END PGP SIGNATURE-----

--WBm7DgEhxf6gT3oEckvVEUPLCwjCbxHDR--
