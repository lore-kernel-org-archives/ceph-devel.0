From: Loic Dachary <loic@dachary.org>
Subject: Re: OpenStack and ceph integration with puppet
Date: Thu, 10 Oct 2013 17:43:15 +0200
Message-ID: <5256CB13.5020203@dachary.org>
References: <525413DE.9090405@dachary.org> <57ED724085B72141BB091CF1314E471F01769708@xmb-rcd-x15.cisco.com> <5255CEB2.8080809@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pX64d6kqxcigcdF37SlpGr1aa56djI24J"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59645 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3JJRiy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Oct 2013 13:38:54 -0400
In-Reply-To: <5255CEB2.8080809@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Don Talton (dotalton)" <dotalton@cisco.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Bode <bodepd@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pX64d6kqxcigcdF37SlpGr1aa56djI24J
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 09/10/2013 22:46, Loic Dachary wrote:
>=20
>=20
> On 08/10/2013 16:20, Don Talton (dotalton) wrote:> Hi Loic,=20
>>
>=20
>> We utilize stackforge's puppet modules to do our heavy lifting, includ=
ing p-openstack, p-cinder, p-glance. There are dependency chains so that =
services will be restarted after configuration changes are made. Since ma=
ny of our customers don't allow their baremetal  nodes Internet access, w=
e've added the packages to our APT repo to avoid the version issues with =
using either stock or public packages.
>>
>> You can probably find some other useful code the https://github.com/Ci=
scoSystems/ repo, including what is needed to cohabitate MON/OSD nodes wi=
th OpenStack service nodes (https://github.com/CiscoSystems/puppet-coe/tr=
ee/grizzly/manifests/ceph) and more. The primary orchestration is in griz=
zly-manifests. You can see HOWTOs for different deployment scenarios here=
: http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation.=20
>>
>> Hope this helps some!
>=20
> It does and it's great that all this is documented :-) Although there a=
re a few modules around, re-using ceph-deploy seems to be the preferred m=
ethod. I wonder what Alfredo would suggest. From a previous discussion we=
 had I think he will suggest to use ceph-disk directly + cli / rest call =
instead. Looking at=20
>=20
> https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/new.py
> https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/mon.py
> etc.
>=20
> the layer provided by ceph-deploy is indeed thin. But is it something t=
hat needs to be duplicated in a puppet module ?
>=20

I took a look at ceph-deploy and it won't rely on sudo if run from root

ceph_deploy/sudo_pushy.py
def needs_sudo():
    if getpass.getuser() =3D=3D 'root':
        return False
    return True

and that it won't rely on ssh if the target host is localhost:

ceph_deploy/lib/remoto/connection.py
def needs_ssh(hostname, _socket=3DNone):
    """
    Obtains remote hostname of the socket and cuts off the domain part
    of its FQDN.
    """
    _socket =3D _socket or socket
    local_hostname =3D _socket.gethostname()
    local_short_hostname =3D local_hostname.split('.')[0]
    if local_hostname =3D=3D hostname or local_short_hostname =3D=3D host=
name:
        return False
    return True

Since puppet-cephdeploy runs on the target host as root, it means that

puppet-cephdeploy/manifests/init.pp
  file {"/home/$user/.ssh/authorized_keys":
=2E..
etc.

could probably be avoided since puppet-cephdeploy/manifests/mon.pp runs

command =3D> "/usr/local/bin/ceph-deploy mon create $::hostname",

runs as root, on the target host.

I'm not sure if the distribution of the keys would work though as it reli=
es on files collected by "gatherkeys" which is still a little mysterious =
for me :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.






--pX64d6kqxcigcdF37SlpGr1aa56djI24J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJWyxMACgkQ8dLMyEl6F23EYgCgqurtnWzA/tpIBGSr1vnNOpOf
ToYAmwWSbRGL9ozf1FYxbmGU025PmYz1
=Uq0l
-----END PGP SIGNATURE-----

--pX64d6kqxcigcdF37SlpGr1aa56djI24J--
