From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer integration
Date: Wed, 26 Aug 2015 11:05:43 +0200
Message-ID: <55DD8167.8050702@dachary.org>
References: <55DB0553.90406@dachary.org>	<CAP3mxSyrzTdozmsTKCfcnSc=mV5MfBazYASNDrsqmVHZkFLHfw@mail.gmail.com>	<55DC2931.5000707@dachary.org> <CAP3mxSzgSCvxzSS+h2-KnPMO_3M=YhwjSGFVTNHh6AmiYEVosA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="b8VCmiqIXpeHXThjU1toiVKeMV7R3gvB6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44027 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756288AbbHZJFp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Aug 2015 05:05:45 -0400
In-Reply-To: <CAP3mxSzgSCvxzSS+h2-KnPMO_3M=YhwjSGFVTNHh6AmiYEVosA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b8VCmiqIXpeHXThjU1toiVKeMV7R3gvB6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On 26/08/2015 08:58, Abhishek Varshney wrote:> Hi Loic,
>=20
> I have populated and locally run-make-check'ed the hammer-backports int=
egration branch for my fork (https://github.com/Abhishekvrshny/ceph/tree/=
hammer-backports). I can run integration tests on this once https://githu=
b.com/ceph/ceph/tree/hammer-backports is reset with hammer-backports on m=
y fork.

https://github.com/ceph/ceph/tree/hammer-backports was reset with https:/=
/github.com/ceph/ceph/pull/5571 and now builds at http://ceph.com/gitbuil=
der.cgi

> Also, is there any fix/update on the rgw failures seen in the earlier r=
uns of the integration branch (http://tracker.ceph.com/issues/12701)? htt=
p://tracker.ceph.com/issues/12661 might be a related issue as pointed by =
theanalyst earlier.

I don't think any progress was made on that front but maybe theanalyst ha=
s more information ?

Cheers

> Thanks
> Abhishek
>=20
> On Tue, Aug 25, 2015 at 2:07 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Abhishek,
>=20
>     On 25/08/2015 07:57, Abhishek Varshney wrote:> Hi Loic,
>     >
>     > Thanks for the kind gesture and providing access to run teutholog=
y runs. I was able to run the dummy test suite, monitor its progress and =
upload the logs as described here https://github.com/dachary/teuthology/t=
ree/openstack#openstack-backend.
>     >
>     > Before I re-populate the hammer-backports integration branch (iss=
ue #12701 <http://tracker.ceph.com/issues/12701>) and run the integration=
 tests on it, it would be nice if you can mark the earlier hammer backpor=
ts PR with DNM (https://github.com/ceph/ceph/pull/5571)
>=20
>     Done
>=20
>     > and review if there are any other PRs that have to be marked DNM =
for hammer.
>=20
>     I think that's all there is.
>=20
>     Cheers
>=20
>     > Thanks
>     > Abhishek
>     >
>     > On Mon, Aug 24, 2015 at 5:21 PM, Loic Dachary <loic@dachary.org <=
mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.or=
g>>> wrote:
>     >
>     >     Hi Sam,
>     >
>     >     Maybe we can start an experiment to enable contributors to ru=
n their own teuthology suites. It would go like this:
>     >
>     >     * Send an OpenStack credential file to the author of a pull r=
equest
>     >     * Ask her/him to follow the instructions at https://github.co=
m/dachary/teuthology/tree/openstack#openstack-backend to verify it works
>     >     * Ask her/him to run and debug a specific suite by providing =
the command line such as
>     >
>     >        teuthology-openstack --key-name myself --key-filename ~/Do=
wnloads/myself --suite ceph-disk --suite-branch wip-11881-multipath --fil=
ter=3Dubuntu_14.04 --ceph wip-11881-multipath
>     >
>     >     We don't yet have a long term solution to fund this kind of t=
esting, but that's not a blocker. It's cheap enough to setup and I'm will=
ing to spend 500 euros per month of my own money for the time being. It's=
 really selfish of me : enabling contributors will save me time that's wo=
rth more than 500 euros ;-)
>     >
>     >     The details of how the first account has been setup are at ht=
tp://tracker.ceph.com/projects/ceph/wiki/RunTeuthology
>     >
>     >     What do you think ?
>     >
>     >     Cheers
>     >
>     >     --
>     >     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >
>     >
>     >
>     > -----------------------------------------------------------------=
-------------------------------------------------------------------------=

>     >
>     > This email and any files transmitted with it are confidential and=
 intended solely for the use of the individual or entity to whom they are=
 addressed. If you have received this email in error please notify the sy=
stem manager. This message contains confidential information and is inten=
ded only for the individual named. If you are not the named addressee you=
 should not disseminate, distribute or copy this e-mail. Please notify th=
e sender immediately by e-mail if you have received this e-mail by mistak=
e and delete this e-mail from your system. If you are not the intended re=
cipient you are notified that disclosing, copying, distributing or taking=
 any action in reliance on the contents of this information is strictly p=
rohibited. Although Flipkart has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibi=
lity for any loss or damage arising from the use of this email or attachm=
ents
>     >
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


--b8VCmiqIXpeHXThjU1toiVKeMV7R3gvB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXdgWcACgkQ8dLMyEl6F21EJgCgpEym0H6wd9+SLK33jgV6wIht
W7gAmwURHbi+ZhZPwH/wSIitJxyODhFs
=h04d
-----END PGP SIGNATURE-----

--b8VCmiqIXpeHXThjU1toiVKeMV7R3gvB6--
