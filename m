From: Loic Dachary <loic@dachary.org>
Subject: Re: cloud-init resolv.conf updates
Date: Fri, 12 Jun 2015 09:17:47 +0200
Message-ID: <557A879B.20301@dachary.org>
References: <5579FFA3.2060903@dachary.org> <1985953708.961395.1434085304287.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bpLTTmjPlOGt7kHbQWhbmwG5K0IpJ24TR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60849 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932143AbbFLHRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 03:17:50 -0400
In-Reply-To: <1985953708.961395.1434085304287.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bpLTTmjPlOGt7kHbQWhbmwG5K0IpJ24TR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

That's an interesting trick :-) Would it also work with

auto eth0
iface eth0 inet dhcp
    dns-nameservers X.X.X.X

Where can I read more about this ?

Cheers

On 12/06/2015 07:01, Alexandre DERUMIER wrote:
> Hi Loic,
>=20
> I'm always playing with cloudinit currently,
> and I never can get working resolv_conf module too (with configdrive da=
tasource)
>=20
>=20
> Finaly, I manage it with this configdrive:
>=20
> /latest/meta_data.json
> {
>      "uuid": "c5240fed-76a8-48d9-b417-45b46599d999",
>      "network_config" :{ "content_path": "/content/0000"}
> }
>=20
> /content/0000
>=20
> auto eth0
> iface eth0 inet static
>         address x.X.X.X
>         netmask 255.255.255.0
>         gateway X.X.X.X
>         dns-nameservers X.X.X.X
>         dns-search mydomain
>=20
>=20
> The config is at debian format, but each cloud-init agent on different =
os parse it,=20
> and transform it to correct distro format. (/sysconfig/.. for redhat).
>=20
>=20
> =20
> ----- Mail original -----
> De: "Loic Dachary" <loic@dachary.org>
> =C3=80: "Mehdi Abaakouk" <sileht@sileht.net>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Jeudi 11 Juin 2015 23:37:39
> Objet: cloud-init resolv.conf updates
>=20
> Hi Mehdi,=20
>=20
> I tried to=20
>=20
> manage_resolv_conf: true=20
>=20
> resolv_conf:=20
> nameservers: ['8.8.4.4', '8.8.8.8']=20
>=20
> but did not get any result and according to /var/log/cloud-init.log it =
does not seem to be taken into account.=20
>=20
> It looks like this is still an open issue according to=20
>=20
> https://answers.launchpad.net/ubuntu/+source/cloud-init/+question/23404=
1=20
> https://bugs.launchpad.net/cloud-init/+bug/1394061=20
>=20
> even when you get past the misleading example that spells manage-resolv=
-conf instead of manag_resolv_conf at=20
>=20
> http://cloudinit.readthedocs.org/en/stable/topics/examples.html#configu=
re-an-instances-resolv-conf=20
>=20
> It looks like there would be a need to add=20
>=20
> cloud_config_modules:=20
> - resolv_conf=20
>=20
> according to http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/tru=
nk/view/head:/doc/examples/cloud-config.txt#L300 but I don't know which m=
odules I need and which are optional and if the list is going to be merge=
d with the default or override.=20
>=20
> so I ended up doing:=20
>=20
> #cloud-config=20
> bootcmd:=20
> - echo "nameserver 10.0.3.31" | sudo tee -a /etc/resolvconf/resolv.conf=
=2Ed/head=20
> - sudo resolvconf -u=20
>=20
> Which works for Ubuntu 14.04 but isn't going to work for every operatin=
g system ;-)=20
>=20
> I'm sure you faced something similar in the past and I'd very much appr=
eciate a pointer in the right direction.=20
>=20
> Cheers=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--bpLTTmjPlOGt7kHbQWhbmwG5K0IpJ24TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlV6h5sACgkQ8dLMyEl6F23YXACglg8q+0sJzSByOi3V7xjIeW2w
kD8AnAuU6OYIOqIresw2cgoWhvGoNUXG
=QMEU
-----END PGP SIGNATURE-----

--bpLTTmjPlOGt7kHbQWhbmwG5K0IpJ24TR--
