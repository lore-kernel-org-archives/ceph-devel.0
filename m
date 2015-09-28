From: Loic Dachary <loic@dachary.org>
Subject: Re: Teuthology Integration to native openstack
Date: Mon, 28 Sep 2015 11:50:52 +0200
Message-ID: <56090D7C.4020000@dachary.org>
References: <D22E3F64.15AF%bkrishna@walmartlabs.com> <56084EDE.9050005@dachary.org> <D22ECA7E.15C3%bkrishna@walmartlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2gmW7dmhv8W6RA4VKOksUlwfvirGhgopr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33842 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757053AbbI1JvF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 05:51:05 -0400
In-Reply-To: <D22ECA7E.15C3%bkrishna@walmartlabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bharath Krishna <BKrishna@walmartlabs.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2gmW7dmhv8W6RA4VKOksUlwfvirGhgopr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/09/2015 07:24, Bharath Krishna wrote:
> Hi Dachary,
>=20
> Thanks for the reply. I am following your blog http://dachary.org/?p=3D=
3767
> And the README in=20
> https://github.com/dachary/teuthology/tree/wip-6502-openstack-v2/#opens=
tack
> -backend

The up to date instructions are at https://github.com/dachary/teuthology/=
tree/openstack/#openstack-backend (the link you used comes from http://da=
chary.org/?p=3D3828 and I just updated it so noone else will be confused)=
=2E
>=20
> I have sourced the openrc file of my Openstack deployment and verified
> that clients are working fine. My Openstack deployment has Cinder
> integrated with CEPH backend.
>=20
> I have cloned and installed teuthology using the below steps:
>=20
> $ git clone -b wip-6502-openstack-v2 http://github.com/dachary/teutholo=
gy
> $ cd teuthology ; ./bootstrap install
> $ source virtualenv/bin/activate
>=20
>=20
> Then I tried to run a dummy suite as test and I ran into following erro=
r:
>=20
> Traceback (most recent call last):
>   File "/root/teuthology/virtualenv/bin/teuthology-openstack", line 9, =
in
> <module>
>     load_entry_point('teuthology=3D=3D0.1.0', 'console_scripts',
> 'teuthology-openstack')()
>   File "/root/teuthology/scripts/openstack.py", line 8, in main
>     teuthology.openstack.main(parse_args(argv), argv)
>   File "/root/teuthology/teuthology/openstack.py", line 375, in main
>     return TeuthologyOpenStack(ctx, teuth_config, argv).main()
>   File "/root/teuthology/teuthology/openstack.py", line 181, in main
>     self.verify_openstack()
>   File "/root/teuthology/teuthology/openstack.py", line 270, in
> verify_openstack
>     str(providers))
> Exception: ('OS_AUTH_URL=3Dhttp://<ip-address>:5000/v2.0', " does is no=
t a
> known OpenStack provider (('cloud.ovh.net', 'ovh'), ('control.os1.phx2'=
,
> 'redhat'), ('entercloudsuite.com', 'entercloudsuite'))")

This limitation was in an earlier implementations and should not be a pro=
blem now.

Cheers

>=20
>=20
> Thank you.
>=20
> Regards,
> M Bharath Krishna
>=20
> On 9/28/15, 1:47 AM, "Loic Dachary" <loic@dachary.org> wrote:
>=20
>> [moving to ceph-devel]
>>
>> Hi,
>>
>> On 27/09/2015 21:20, Bharath Krishna wrote:
>>> Hi,
>>>
>>> We have an openstack deployment in place with CEPH as CINDER backend.=

>>>
>>> We would like to perform functional testing for CEPH and found
>>> teuthology as recommended option.
>>>
>>> Have successfully installed teuthology. Now to integrate it with
>>> Openstack, I could see that the possible providers could be either OV=
H,
>>> REDHAT or ENTERCLOUDSITE.
>>>
>>> Is there any option where in we can source openstack deployment of ou=
r
>>> own and test CEPH using teuthology?
>>
>> The documentation mentions these providers because they have been test=
ed.
>> But there should be no blocker to run teuthology against a regular
>> OpenStack provider. Should you run into troubles, please let me know a=
nd
>> I'll help.
>>
>> Cheers
>>
>>>
>>> If NO, please suggest on how to test CEPH in such scenarios?
>>>
>>> Please help.
>>>
>>> Thank you.
>>> Bharath Krishna
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--2gmW7dmhv8W6RA4VKOksUlwfvirGhgopr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYJDXwACgkQ8dLMyEl6F23BvwCeNwJp6NA1V/si8FqmFdhWM4CS
GX4AnRH4ciFtoJT7tD80uhdBuJMIc5fM
=SLze
-----END PGP SIGNATURE-----

--2gmW7dmhv8W6RA4VKOksUlwfvirGhgopr--
