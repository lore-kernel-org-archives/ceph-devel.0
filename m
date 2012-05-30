From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: building test cluster : missing /etc/ceph/client.admin.keyring, need help
Date: Wed, 30 May 2012 09:33:40 +0200 (CEST)
Message-ID: <f5655b84-dbd1-4cfa-9d67-315dcc21d8c9@mailpro>
References: <4FC5CB84.2010700@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:42088 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037Ab2E3HeC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 03:34:02 -0400
In-Reply-To: <4FC5CB84.2010700@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

ok ,thanks

I had created the cluster, following the official doc
http://ceph.com/docs/master/config-cluster/deploying-ceph-with-mkcephfs=
/
with

mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring

and file was created in /srv

# cat /srv/ceph.keyring=20
[client.admin]
        key =3D AQCQwcVPGIAwHhAAuS5Veg7GoOyzh59zq2TKag=3D=3D


is it an error in documentation ?


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 30 Mai 2012 09:25:56=20
Objet: Re: building test cluster : missing /etc/ceph/client.admin.keyri=
ng, need help=20

Am 30.05.2012 09:20, schrieb Alexandre DERUMIER:=20
>=20
> Hi,=20
> I'm building my rados test cluster,=20
>=20
>=20
> 3 servers,with on each server : 1 mon - 5 osd=20
>=20
> mon daemon and osd are started, but when i use ceph command, it's mis=
sing client.admin.keyring=20
>=20
> root@cephtest1:/etc/ceph# ceph -w=20
> 2012-05-30 09:05:35.255619 7fd1e9cfa760 -1 auth: failed to open keyri=
ng from /etc/ceph/client.admin.keyring=20
> 2012-05-30 09:05:35.255631 7fd1e9cfa760 -1 monclient(hunting): failed=
 to open keyring: (2) No such file or directory=20
> 2012-05-30 09:05:35.255693 7fd1e9cfa760 -1 ceph_tool_common_init fail=
ed.=20
Just run:=20
mkcephfs -a -c /etc/ceph/ceph.conf -k /etc/ceph/client.admin.keyring=20

and it will create the admin key for you.=20

Stefan=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
