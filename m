From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: building test cluster : missing /etc/ceph/client.admin.keyring, need help
Date: Wed, 30 May 2012 09:47:44 +0200 (CEST)
Message-ID: <aa18b846-fd7c-4bfd-bb90-2c2ca4bb4ba1@mailpro>
References: <f5655b84-dbd1-4cfa-9d67-315dcc21d8c9@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57850 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab2E3HsG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 03:48:06 -0400
In-Reply-To: <f5655b84-dbd1-4cfa-9d67-315dcc21d8c9@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

root@cephtest1:/srv# cp /srv/ceph.keyring /etc/ceph/client.admin.keyrin=
g
root@cephtest1:/srv# ceph -w
2012-05-30 09:26:40.336175    pg v572: 2880 pgs: 2880 active+clean; 0 b=
ytes data, 544 MB used, 2039 GB / 2039 GB avail
2012-05-30 09:26:40.342175   mds e1: 0/0/1 up
2012-05-30 09:26:40.342207   osd e17: 15 osds: 15 up, 15 in
2012-05-30 09:26:40.342331   log 2012-05-30 09:06:35.419340 osd.9 10.3.=
94.28:6812/13794 260 : [INF] 2.3bb scrub ok
2012-05-30 09:26:40.342424   mon e1: 3 mons at {a=3D10.3.94.27:6789/0,b=
=3D10.3.94.28:6789/0,c=3D10.3.94.29:6789/0}

Ok, the fun will begin now :)


----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 30 Mai 2012 09:33:40=20
Objet: Re: building test cluster : missing /etc/ceph/client.admin.keyri=
ng, need help=20

ok ,thanks=20

I had created the cluster, following the official doc=20
http://ceph.com/docs/master/config-cluster/deploying-ceph-with-mkcephfs=
/=20
with=20

mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring=20

and file was created in /srv=20

# cat /srv/ceph.keyring=20
[client.admin]=20
key =3D AQCQwcVPGIAwHhAAuS5Veg7GoOyzh59zq2TKag=3D=3D=20


is it an error in documentation ?=20


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

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



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
