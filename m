From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: Problem with cephx in 0.55
Date: Wed, 12 Dec 2012 15:19:22 +0100
Message-ID: <CAGqxmDNyHLCKSc8z-F+XPJJG2xyYjBdgPaeM5TmZ1SM6BntfGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:57072 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab2LLOTX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 09:19:23 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so294188wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 06:19:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello

I can't map rbd volume after upgrading to 0.55 from 0.53.

ceph.conf:
[global]
  auth cluster required =3D cephx
  auth service required =3D cephx
  auth client required =3D cephx
  keyring =3D /srv/ceph/keyring.admin

[mon]
  mon data =3D /srv/ceph/mon
  mon clock drift allowed =3D 0.5

[mon.cc]
  host =3D cc
  mon addr =3D 10.255.128.1:6789

[mds]
  debug mds =3D 1
  keyring =3D /srv/ceph/ceph-stage2/keyring.$name

[mds.cc]
  host =3D cc

[osd]
  osd data =3D /srv/ceph/ceph-data/$name
  osd journal =3D /srv/ceph/ceph-journal/$name.journal
  osd journal size =3D 10000
  osd scrub load threshold =3D 4
  keyring =3D /srv/ceph/ceph-stage2/keyring.$name
  debug osd =3D 1

[osd.1]
  host =3D n3cc
[osd.0]
  host =3D cc

# ceph auth list
=2E..
client.test
        key: AQAaAshQ6NakBRAAHbOaK7DvO9NIKDwTV5REMw=3D=3D
        caps: [mon] allow r
        caps: [osd] allow rwx pool=3Dwinnie-test

# cat secret
AQAaAshQ6NakBRAAHbOaK7DvO9NIKDwTV5REMw=3D=3D
root@i-10-255-0-23[staging]:/tmp# rbd map test -p winnie-test --id
test --secret secret
rbd: add failed: (1) Operation not permitted

from mon's log:
2012-12-12 15:15:19.429889 7fe0a3097700  0 -- 10.255.128.1:6789/0 >>
10.255.0.23:0/3731757836 pipe(0x1ce4240 sd=3D23 :6789 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 10.255.0.23:0/3731757836 (socket is
10.255.0.23:56533/0)

If I use admin key or use "caps: [osd] allow rwx" instead of "caps:
[osd] allow rwx pool=3Dwinnie-test" it works fine.

--
regards
Maciej Ga=C5=82kiewicz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
