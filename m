From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer integration
Date: Thu, 27 Aug 2015 15:41:34 +0200
Message-ID: <55DF138E.6080000@dachary.org>
References: <55DB0553.90406@dachary.org>	<CAP3mxSyrzTdozmsTKCfcnSc=mV5MfBazYASNDrsqmVHZkFLHfw@mail.gmail.com>	<55DC2931.5000707@dachary.org>	<CAP3mxSzgSCvxzSS+h2-KnPMO_3M=YhwjSGFVTNHh6AmiYEVosA@mail.gmail.com>	<55DD8167.8050702@dachary.org> <CAP3mxSxUMiR94PD3XKVGwVV3dOkGcuJ_x7UZsEsGLx81kXkYHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="b8v9HKV9FBi1Gxmj4HXGBKEA8ag2PJHS7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44709 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752895AbbH0Nli (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 09:41:38 -0400
In-Reply-To: <CAP3mxSxUMiR94PD3XKVGwVV3dOkGcuJ_x7UZsEsGLx81kXkYHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b8v9HKV9FBi1Gxmj4HXGBKEA8ag2PJHS7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

You should follow the instructions at https://github.com/dachary/teutholo=
gy/tree/openstack#openstack-backend and not the one related to VPSHOST.

Sorry for the confusion

On 27/08/2015 15:18, Abhishek Varshney wrote:
> Hi Loic,
>=20
> After the hammer-backports branch was successfully built at http://ceph=
=2Ecom/gitbuilder.cgi, I am now trying to schedule teuthology suits using=
 the openstack credentials.
>=20
> It would be nice if you can confirm what should be the VPSHOST configur=
ation (https://github.com/dachary/teuthology/tree/openstack#virtual-machi=
ne-support) in this case and after setting VPSHOST configuration, can I d=
irectly run the teuthology-suite commands or is there anything else that =
needs to be done.
>=20
> Thanks
> Abhishek =20
>=20
> On Wed, Aug 26, 2015 at 2:35 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Abhishek,
>=20
>     On 26/08/2015 08:58, Abhishek Varshney wrote:> Hi Loic,
>     >
>     > I have populated and locally run-make-check'ed the hammer-backpor=
ts integration branch for my fork (https://github.com/Abhishekvrshny/ceph=
/tree/hammer-backports). I can run integration tests on this once https:/=
/github.com/ceph/ceph/tree/hammer-backports is reset with hammer-backport=
s on my fork.
>=20
>     https://github.com/ceph/ceph/tree/hammer-backports was reset with h=
ttps://github.com/ceph/ceph/pull/5571 and now builds at http://ceph.com/g=
itbuilder.cgi
>=20
>     > Also, is there any fix/update on the rgw failures seen in the ear=
lier runs of the integration branch (http://tracker.ceph.com/issues/12701=
)? http://tracker.ceph.com/issues/12661 might be a related issue as point=
ed by theanalyst earlier.
>=20
>     I don't think any progress was made on that front but maybe theanal=
yst has more information ?
>=20
>     Cheers
>=20
>     > Thanks
>     > Abhishek
>     >
>     > On Tue, Aug 25, 2015 at 2:07 PM, Loic Dachary <loic@dachary.org <=
mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.or=
g>>> wrote:
>     >
>     >     Hi Abhishek,
>     >
>     >     On 25/08/2015 07:57, Abhishek Varshney wrote:> Hi Loic,
>     >     >
>     >     > Thanks for the kind gesture and providing access to run teu=
thology runs. I was able to run the dummy test suite, monitor its progres=
s and upload the logs as described here https://github.com/dachary/teutho=
logy/tree/openstack#openstack-backend.
>     >     >
>     >     > Before I re-populate the hammer-backports integration branc=
h (issue #12701 <http://tracker.ceph.com/issues/12701>) and run the integ=
ration tests on it, it would be nice if you can mark the earlier hammer b=
ackports PR with DNM (https://github.com/ceph/ceph/pull/5571)
>     >
>     >     Done
>     >
>     >     > and review if there are any other PRs that have to be marke=
d DNM for hammer.
>     >
>     >     I think that's all there is.
>     >
>     >     Cheers
>     >
>     >     > Thanks
>     >     > Abhishek
>     >     >
>     >     > On Mon, Aug 24, 2015 at 5:21 PM, Loic Dachary <loic@dachary=
=2Eorg <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@da=
chary.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <mailto:lo=
ic@dachary.org <mailto:loic@dachary.org>>>> wrote:
>     >     >
>     >     >     Hi Sam,
>     >     >
>     >     >     Maybe we can start an experiment to enable contributors=
 to run their own teuthology suites. It would go like this:
>     >     >
>     >     >     * Send an OpenStack credential file to the author of a =
pull request
>     >     >     * Ask her/him to follow the instructions at https://git=
hub.com/dachary/teuthology/tree/openstack#openstack-backend to verify it =
works
>     >     >     * Ask her/him to run and debug a specific suite by prov=
iding the command line such as
>     >     >
>     >     >        teuthology-openstack --key-name myself --key-filenam=
e ~/Downloads/myself --suite ceph-disk --suite-branch wip-11881-multipath=
 --filter=3Dubuntu_14.04 --ceph wip-11881-multipath
>     >     >
>     >     >     We don't yet have a long term solution to fund this kin=
d of testing, but that's not a blocker. It's cheap enough to setup and I'=
m willing to spend 500 euros per month of my own money for the time being=
=2E It's really selfish of me : enabling contributors will save me time t=
hat's worth more than 500 euros ;-)
>     >     >
>     >     >     The details of how the first account has been setup are=
 at http://tracker.ceph.com/projects/ceph/wiki/RunTeuthology
>     >     >
>     >     >     What do you think ?
>     >     >
>     >     >     Cheers
>     >     >
>     >     >     --
>     >     >     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >     >
>     >     >
>     >     >
>     >     > -----------------------------------------------------------=
-------------------------------------------------------------------------=
------
>     >     >
>     >     > This email and any files transmitted with it are confidenti=
al and intended solely for the use of the individual or entity to whom th=
ey are addressed. If you have received this email in error please notify =
the system manager. This message contains confidential information and is=
 intended only for the individual named. If you are not the named address=
ee you should not disseminate, distribute or copy this e-mail. Please not=
ify the sender immediately by e-mail if you have received this e-mail by =
mistake and delete this e-mail from your system. If you are not the inten=
ded recipient you are notified that disclosing, copying, distributing or =
taking any action in reliance on the contents of this information is stri=
ctly prohibited. Although Flipkart has taken reasonable precautions to en=
sure no viruses are present in this email, the company cannot accept resp=
onsibility for any loss or damage arising from the use of this email or a=
ttachments
>     >     >
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


--b8v9HKV9FBi1Gxmj4HXGBKEA8ag2PJHS7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXfE44ACgkQ8dLMyEl6F21qHgCdFyUr3aMASpOuPGwQLQd1cPml
dSQAn0U1s6GodRHcs0FF8CYTpx+XGbJJ
=M836
-----END PGP SIGNATURE-----

--b8v9HKV9FBi1Gxmj4HXGBKEA8ag2PJHS7--
