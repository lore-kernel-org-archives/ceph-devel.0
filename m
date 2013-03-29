From: Loic Dachary <loic@dachary.org>
Subject: Re: Using google mock
Date: Fri, 29 Mar 2013 18:31:11 +0100
Message-ID: <5155CFDF.1040903@dachary.org>
References: <51553FB4.8000208@dachary.org> <alpine.DEB.2.00.1303290823350.6485@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC2BD33076BD0F31AF6CD6D6C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:43386 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab3C2RbQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 13:31:16 -0400
In-Reply-To: <alpine.DEB.2.00.1303290823350.6485@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2BD33076BD0F31AF6CD6D6C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

It's not in EPEL

for i in  3 4 a b c d e f g h i j k l m n o p q r s t u v w x y z ; do cu=
rl --silent http://dl.fedoraproject.org/pub/epel/6/SRPMS/repoview/letter_=
$i.group.html | grep mock ; done
            <span>A mocking library for Erlang</span>
            <a href=3D"mock.html" class=3D"inpage">mock</a> -
            <span>Easy mocking of LWP packages</span>
            <span>Mockery is a simple but flexible PHP mock object framew=
ork</span>
            <span>Phake is a PHP mocking framework that is based on Mocki=
to</span>
            <a href=3D"python-flexmock.html" class=3D"inpage">python-flex=
mock</a> -
            <span>Testing library that makes it easy to create mocks, stu=
bs and fakes</span>
            <a href=3D"python-minimock.html" class=3D"inpage">python-mini=
mock</a> -
            <span>The simplest possible mock library</span>
            <a href=3D"python-mock.html" class=3D"inpage">python-mock</a>=
 -
            <span>Tiny mocking library</span>
            <a href=3D"rubygem-rspec-mocks.html" class=3D"inpage">rubygem=
-rspec-mocks</a> -
            <span>Rspec-2 doubles (mocks and stubs)</span>

Regarding http://ceph.com/gitbuilder.cgi I found

OK : squeeze wheezy : http://packages.debian.org/search?keywords=3Dgoogle=
-mock
OK : oneiric natty precise quantal : https://launchpad.net/ubuntu/+source=
/google-mock
OK : centos6 http://pkgs.org/centos-6-rhel-6/nux-dextop-x86_64/gmock-1.5.=
0-1.el6.nux.x86_64.rpm.html
OK : fedora17 fedora18 https://admin.fedoraproject.org/pkgdb/acls/name/gm=
ock
OK : opensuse12 https://build.opensuse.org/package/view_file?expand=3D1&f=
ile=3Dgmock.spec&package=3Dgmock&project=3DGNOME%3AAyatana

not sure about : sles-11sp2 https://www.suse.com/company/press/2012/2/sus=
e-linux-enterprise-11-service-pack-2-released.html

I'll keep looking.

Cheers

On 03/29/2013 04:24 PM, Sage Weil wrote:
> On Fri, 29 Mar 2013, Loic Dachary wrote:
>> Hi,
>>
>> Google mock ( ) provides convenient string matchers ( http://code.goog=
le.com/p/googlemock/wiki/CheatSheet#String_Matchers ) that would be usefu=
l when writing unit tests. It is available in most distributions:
>>
>> http://packages.debian.org/search?keywords=3Dgoogle-mock
>> https://launchpad.net/ubuntu/+source/google-mock
>> http://rpmfind.net/linux/rpm2html/search.php?query=3Dgmock
>>
>> I've never used it before. Any objection on adding it as a dependency =
in addition to google test ?
>=20
> I think as long as it is in EPEL or we can get an el6 package for those=
=20
> builds, it should be fine.
>=20
> http://ceph.com/gitbuilder.cgi
>=20
> is what we need to cover.
>=20
> Thanks!
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigC2BD33076BD0F31AF6CD6D6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlFVz98ACgkQ8dLMyEl6F22IVQCgvYFCE3jshA9e01jADnIfxTW5
xHAAoIjzEq8uwmLoaH3fdKwtDiynrTAn
=GAqt
-----END PGP SIGNATURE-----

--------------enigC2BD33076BD0F31AF6CD6D6C--
