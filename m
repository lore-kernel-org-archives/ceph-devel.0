From: Loic Dachary <loic@dachary.org>
Subject: Re: quick way to rebuild deb packages
Date: Wed, 22 Jul 2015 08:31:44 +0200
Message-ID: <55AF38D0.8090303@dachary.org>
References: <20150721181507.138bc9380985439e49ac05ab@corp.ovh.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="V3VxIH9spEFCfjUgwHkQPS6XgGTe19wKI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54088 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754694AbbGVGbr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jul 2015 02:31:47 -0400
In-Reply-To: <20150721181507.138bc9380985439e49ac05ab@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V3VxIH9spEFCfjUgwHkQPS6XgGTe19wKI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Did you try https://github.com/ceph/ceph/blob/master/make-debs.sh ? I wou=
ld recommend running https://github.com/ceph/ceph/blob/master/run-make-ch=
eck.sh first to make sure you can build and test: this will install the d=
ependencies you're missing at the same time.

Cheers

On 21/07/2015 18:15, Bart=C5=82omiej =C5=9Awi=C4=99cki wrote:
> Hi all,
>=20
> I'm currently working on a test environment for ceph where we're using =
deb files to deploy new version on test cluster.
> To make this work efficiently I'd have to quckly build deb packages.
>=20
> I tried dpkg-buildpackages -nc which should keep the results of previou=
s build but it ends up in a linking error:
>=20
>> ...
>>   CXXLD    ceph_rgw_jsonparser
>> ./.libs/libglobal.a(json_spirit_reader.o): In function `~thread_specif=
ic_ptr':
>> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::d=
etail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cle=
anup_function>, void*, bool)'
>> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::d=
etail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cle=
anup_function>, void*, bool)'
>> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::d=
etail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cle=
anup_function>, void*, bool)'
>> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::d=
etail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cle=
anup_function>, void*, bool)'
>> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::d=
etail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cle=
anup_function>, void*, bool)'
>> ./.libs/libglobal.a(json_spirit_reader.o):/usr/include/boost/thread/ts=
s.hpp:79: more undefined references to `boost::detail::set_tss_data(void =
const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bo=
ol)' follow
>> ./.libs/libglobal.a(json_spirit_reader.o): In function `call_once<void=
 (*)()>':
>> ...
>=20
> Any ideas on what could go wrong here ?
>=20
> Version I'm compiling is v0.94.1 but I've observed same results with 9.=
0.1.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--V3VxIH9spEFCfjUgwHkQPS6XgGTe19wKI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWvONAACgkQ8dLMyEl6F204YwCfR1rXSQMzVzzCyv3Gnorc9LGa
KtkAn3c9ZqSbrf6CF3NfTbJ5bNm5QFCz
=cetd
-----END PGP SIGNATURE-----

--V3VxIH9spEFCfjUgwHkQPS6XgGTe19wKI--
