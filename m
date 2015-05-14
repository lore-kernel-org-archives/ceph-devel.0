From: Loic Dachary <loic@dachary.org>
Subject: Re: Problem running make check
Date: Fri, 15 May 2015 01:15:19 +0200
Message-ID: <55552C87.1080100@dachary.org>
References: <CAEFDAA5BroNoMvR8Yyvf+nj_0RJa20gkCUhJo3zrbvYNYa5w1g@mail.gmail.com> <CAC6JEv9s1fSk7X5XSp8CtYN6Qr3SR5+XRD-Lu51YDJw0RGdRNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6sstOmEfscGRN5orRovQeeULojK0m6sbx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35477 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932923AbbENXPc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 19:15:32 -0400
In-Reply-To: <CAC6JEv9s1fSk7X5XSp8CtYN6Qr3SR5+XRD-Lu51YDJw0RGdRNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Jarzabek <stiopa@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6sstOmEfscGRN5orRovQeeULojK0m6sbx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14/05/2015 22:55, Gregory Farnum wrote:
> On Thu, May 14, 2015 at 1:24 PM, Michal Jarzabek <stiopa@gmail.com> wro=
te:
>> Hi,
>>
>> After cloning ceph repo and then running:
>> ./autogen.sh
>> ./configure
>> make -j 8
>> make check
>>
>> make check always hangs after following lines:
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>> PASS: unittest_texttable
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>> PASS: unittest_on_exit
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>> PASS: unittest_readahead
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>> PASS: unittest_tableformatter
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>> PASS: unittest_bit_vector
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>> PASS: ceph-detect-init/run-tox.sh
>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>
>> Any idea what might be a problem?

In addition to what Greg said:

=2E/configure --without-lttng ...

lttng is indeed the most probably cause for failure. How much RAM/CPU doe=
s your machine have ? Is this running on SSD or spinner ? Not that a spin=
ner would be a problem but mor than -j4 on a spinner is probably not a go=
od idea because the disk will be the bottleneck.

>=20
> You can try building without lttng, which has helped some users, and
> you can check if you have high enough ulimit settings. The defaults on
> my box were not high enough; I bumped both files and processes up to
> 16k and rebooted before I could get it working properly.

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6sstOmEfscGRN5orRovQeeULojK0m6sbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVVLIgACgkQ8dLMyEl6F22LWgCghZ95SaxBj53QkTVAnofyeeTG
mckAnicV4CnCirKeHZ4uRPUzjTdWqYdC
=z40P
-----END PGP SIGNATURE-----

--6sstOmEfscGRN5orRovQeeULojK0m6sbx--
