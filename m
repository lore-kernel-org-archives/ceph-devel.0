From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: issues with adjusting the crushmap in 0.51
Date: Thu, 6 Sep 2012 18:58:21 +0100
Message-ID: <20120906175821.GA32205@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:59795 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab2IFSGV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 14:06:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id D140383BFA
	for <ceph-devel@vger.kernel.org>; Thu,  6 Sep 2012 18:58:22 +0100 (IST)
Received: from tabaet.tchpc.tcd.ie ([127.0.0.1])
	by localhost (tabaet.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bjGRDWoQISLM for <ceph-devel@vger.kernel.org>;
	Thu,  6 Sep 2012 18:58:21 +0100 (IST)
Received: from marduk.tchpc.tcd.ie (marduk.tchpc.tcd.ie [134.226.112.36])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id 5A35483BF7
	for <ceph-devel@vger.kernel.org>; Thu,  6 Sep 2012 18:58:21 +0100 (IST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi All,

I've been playing around with 0.51 of ceph on two test machines in
work, I was experimenting with adjusting the crushmap to change from
replicating across osd's to replicating across hosts. When I change
the rule for my data pool from type osd to type host, compile up the
crushmap and then a "ceph osd setcrushmap -i crush.new" it crashes my
monitor if I have one running, if I have two, then one of them crashes
and the process just hangs and leaves my test filesystem in an unclean
state.

I changed the rule data {} to this

rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type host
        step emit
}

Are there any constraints for changing the rules on where things get
replicated? i.e. to go from osd to host to rack with the data and
metadata?

Here's my ceph.conf file and crushmap before the changes

[global]
        #auth supported =3D cephx
        #keyring =3D /etc/ceph/ceph.keyring
        filestore xattr use omap =3D true
 =20
[osd]
        osd journal size =3D 1000
        filestore xattr use omap =3D true

[mon.a]
        host =3D 134.226.112.194
        mon addr =3D 134.226.112.194:6789
        mon data =3D /data/mon.$id
[mon.b]
        host =3D 134.226.112.138
        mon addr =3D 134.226.112.138:6789
        mon data =3D /home/mon.$id

[mds.a]
        host =3D 134.226.112.194
        mon data =3D /data/mds.$id

[mds.b]
        host =3D 134.226.112.138
        mon data =3D /home/mds.$id

[osd.0]
        host =3D 134.226.112.194
        osd data =3D /data/osd.$id
        osd journal =3D /data/osd.$id.journal

[osd.1]
        host =3D 134.226.112.194
        osd data =3D /data$id/osd.$id
        osd journal =3D /data$id/osd.$id.journal

[osd.2]
        host =3D 134.226.112.138
        osd data =3D /home/osd.$id
        osd journal =3D /home/osd.$id.journal


My crushmap

# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 pool

# buckets
host 134.226.112.194 {
        id -2           # do not change unnecessarily
        # weight 2.000
        alg straw
        hash 0  # rjenkins1
        item osd.1 weight 1.000
        item osd.0 weight 1.000
}
host 134.226.112.138 {
        id -4           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1
        item osd.2 weight 1.000
}
rack rack-1 {
        id -3           # do not change unnecessarily
        # weight 3.000
        alg straw
        hash 0  # rjenkins1
        item 134.226.112.194 weight 2.000
        item 134.226.112.138 weight 1.000
}
pool default {
        id -1           # do not change unnecessarily
        # weight 2.000
        alg straw
        hash 0  # rjenkins1
        item rack-1 weight 2.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type osd
        step emit
}

rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type osd
        step emit
}
rule rbd {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type osd
        step emit
}


Jimmy

--=20
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAlBI5DoACgkQmRvHlXBDSylHfACgutGn0Hn2kUINhXn7hPAKX2S5
hFgAoPhaIaHpaqM9bWD7jaZ7EfnMXhA4
=8QRt
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
