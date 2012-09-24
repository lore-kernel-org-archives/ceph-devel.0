From: Tilman Beitter <beitter@b1-systems.de>
Subject: Initial Setup - Chef hangs at "in New OSD"
Date: Mon, 24 Sep 2012 12:15:11 +0200
Message-ID: <506032AF.9040909@b1-systems.de>
References: <S1755227Ab2IXIkt/20120924084049Z+524@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCF610CAF7B959CF1BBBCA80E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.b1-systems.de ([217.11.58.35]:47514 "EHLO mx1.b1-systems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab2IXKVx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Sep 2012 06:21:53 -0400
Received: from [10.1.10.10] (p57B02653.dip.t-dialin.net [87.176.38.83])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id BED7A4088
	for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 12:15:12 +0200 (CEST)
In-Reply-To: <S1755227Ab2IXIkt/20120924084049Z+524@vger.kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF610CAF7B959CF1BBBCA80E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

I am trying to do a test-setup with SUSE Cloud and Ceph. Ceph get's
installed via chef-client on the nodes. As I do not have enough disks in
my test environment I created two partitions for ceph. So, ceph uses
/dev/sda3 and /dev/sda4.

While installing it stops here:

[Mon, 24 Sep 2012 08:01:52 +0000] INFO: execute[Adding the secret
AQCp3FxQ+OWiBhAApsrBRhRBZcn2qhSHjQcM8A=3D=3D for client.admin into
/etc/ceph/client.admin.keyring] ran successfully
[Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing execute[make xfs
filesystem on /dev/sda3] action run (ceph::osd line 36)
[Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing
directory[/var/lib/ceph/osd/ceph-2] action create (ceph::osd line 46)
[Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing
mount[/var/lib/ceph/osd/ceph-2] action enable (ceph::osd line 54)
[Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing
mount[/var/lib/ceph/osd/ceph-2] action mount (ceph::osd line 54)
[Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing ceph_osd[Initializing
new osd on /dev/sda3 ] action initialize (ceph::osd line 62)
[Mon, 24 Sep 2012 08:01:52 +0000] INFO: in New OSD

Mounts:

/dev/sda3 on /var/lib/ceph/osd/ceph-2 type xfs (rw,noatime)

Processes:

 3319 ?        Ssl    0:02 /usr/bin/ceph-mon -i d00-14-5e-6d-08-a4-ceph
--pid-file /var/run/ceph/mon.d00-14-5e-6d-08-a4-ceph.pid -c
/etc/ceph/ceph.conf
18521 ?        S      0:00 sh -c ceph osd tree | grep -q osd.2
18522 ?        Sl     0:01 ceph osd tree


Are there problems with the use of partitions or do I have another
problem / misconfig?

Thanks in advance

Til



--------------enigCF610CAF7B959CF1BBBCA80E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBgMq8ACgkQ1twG6+QYyOVCwgCgswX854h+7UkYc8uNmfi3n2S6
bhQAn0T/Lv80yldAd2NMphsJNWA8oeSt
=iu7v
-----END PGP SIGNATURE-----

--------------enigCF610CAF7B959CF1BBBCA80E--
