From: Loic Dachary <loic@dachary.org>
Subject: Re: Testing the next giant release
Date: Thu, 08 Jan 2015 00:03:43 +0100
Message-ID: <54ADBB4F.40705@dachary.org>
References: <54AD3C8B.4030705@dachary.org> <CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com> <54ADB2FA.9030204@dachary.org> <CAJBxG-s5C6wzuJhVZhUAfNy9G1XuaDv+6D+R5c95WVWug7o4nA@mail.gmail.com> <CAFd2DpSu5uvQKjfz=vtCMOuLYEDddfrgCNLja+LU5sC+XHWLoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tACS71K5DFhpslx0TBi8TrkoLBFOXxo1O"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35087 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752149AbbAGXDq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 18:03:46 -0500
In-Reply-To: <CAFd2DpSu5uvQKjfz=vtCMOuLYEDddfrgCNLja+LU5sC+XHWLoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>, Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tACS71K5DFhpslx0TBi8TrkoLBFOXxo1O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Thanks Yuri & Tamil !

One last question : http://pulpito.ceph.com/?branch=3Dgiant does not show=
 a run of rbd or rgw. They would be useful to figure out what kind of err=
ors I should expect. Are past results archived elsewhere by any chance ?


On 07/01/2015 23:53, Tamil Muthamizhan wrote:
> yes, just those suites will do Loic.
>=20
> On Wed, Jan 7, 2015 at 2:34 PM, Yuri Weinstein
> <yuri.weinstein@inktank.com> wrote:
>> Loic,
>>
>> I think if you run those on bare metals (not vps) they will run on
>> whatever machines are available in the octo or sepia labs.
>>
>> Thx
>> YuriW
>>
>> On Wed, Jan 7, 2015 at 2:28 PM, Loic Dachary <loic@dachary.org> wrote:=

>>>
>>>
>>> On 07/01/2015 23:20, Tamil Muthamizhan wrote:
>>>> hi Loic,
>>>>
>>>> we have a suite to perform smoke tests for rados/rbd/rgw.
>>>> maybe you can try that to make sure things work.
>>>
>>> Are these the suites I should try:
>>>
>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados
>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rbd
>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rgw
>>>
>>> any specific settings or just all of three without restrictions (i.e.=
 all os versions etc.)
>>>
>>> Cheers
>>>
>>>>
>>>> once it looks good, we can have them scheduled to run using teutholo=
gy for a more elaborate run.
>>>>
>>>> Thanks,
>>>> Tamil
>>>>
>>>>
>>>> On Wed, Jan 7, 2015 at 6:02 AM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>>>
>>>>     Hi Tamil,
>>>>
>>>>     I've merged / integrated the giant backports found at
>>>>
>>>>     https://github.com/ceph/ceph/pull/3186
>>>>     https://github.com/ceph/ceph/pull/3178
>>>>     https://github.com/ceph/ceph/pull/2954
>>>>     https://github.com/ceph/ceph/pull/3191
>>>>     https://github.com/ceph/ceph/pull/3168
>>>>     https://github.com/ceph/ceph/pull/3289
>>>>
>>>>     into
>>>>
>>>>     http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710=
f469454ab3f964bfa7c9d2
>>>>
>>>>     and successfully ran make check on it
>>>>
>>>>     http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backpo=
rts
>>>>
>>>>     If I'm not mistaken the next step would be to run teuthology. If=
 I'm to do it, would you be so kind as to let me know which suites are mo=
st relevant ? If someone else will take care of it, should I push the int=
egration branch somewhere ?
>>>>
>>>>     Cheers
>>>>
>>>>     --
>>>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Regards,
>>>> Tamil
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tACS71K5DFhpslx0TBi8TrkoLBFOXxo1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlStu08ACgkQ8dLMyEl6F21mugCeMWIUf0SRz+IGQorRHOGa32q1
fuQAoMAazy2mUZiaE3lgIsq6V8633AJW
=BIvO
-----END PGP SIGNATURE-----

--tACS71K5DFhpslx0TBi8TrkoLBFOXxo1O--
