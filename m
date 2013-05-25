From: Loic Dachary <loic@dachary.org>
Subject: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 13:55:30 +0200
Message-ID: <51A0A6B2.9060105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF74CA2D0A131C840FD4C6DA5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:50567 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab3EYLzd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 May 2013 07:55:33 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 9DFC126399
	for <ceph-devel@vger.kernel.org>; Sat, 25 May 2013 13:55:31 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF74CA2D0A131C840FD4C6DA5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a draft of my current understanding of backfilling. Disclaimer : =
it is possible that I completely misunderstood ;-)

Cheers

Ceph stores objects in pools which are divided in placement groups.

   +---------------------------- pool a ----+
   |+----- placement group 1 -------------+ |
   ||+-------+  +-------+                 | |
   |||object |  |object |                 | |
   ||+-------+  +-------+                 | |
   |+-------------------------------------+ |
   |+----- placement group 2 -------------+ |
   ||+-------+  +-------+                 | |
   |||object |  |object |   ...           | |
   ||+-------+  +-------+                 | |
   |+-------------------------------------+ |
   |               ....                     |
   |                                        |
   +----------------------------------------+

   +---------------------------- pool b ----+
   |+----- placement group 1 -------------+ |
   ||+-------+  +-------+                 | |
   |||object |  |object |                 | |
   ||+-------+  +-------+                 | |
   |+-------------------------------------+ |
   |+----- placement group 2 -------------+ |
   ||+-------+  +-------+                 | |
   |||object |  |object |   ...           | |
   ||+-------+  +-------+                 | |
   |+-------------------------------------+ |
   |               ....                     |
   |                                        |
   +----------------------------------------+

   ...

The placement group is supported by OSDs to store the objects. They are d=
aemons running on machines where storage  For instance, a placement group=
 supporting three replicates will have three OSDs at his disposal : one O=
SDs is the primary and the two other store copies of each object.

       +-------- placement group -------------+
       |+----------------+ +----------------+ |
       || object A       | | object B       | |
       |+----------------+ +----------------+ |
       +---+-------------+-----------+--------+
           |             |           |
           |             |           |
         OSD 0         OSD 1       OSD 2
        +------+      +------+    +------+
        |+---+ |      |+---+ |    |+---+ |
        || A | |      || A | |    || A | |
        |+---+ |      |+---+ |    |+---+ |
        |+---+ |      |+---+ |    |+---+ |
        || B | |      || B | |    || B | |
        |+---+ |      |+---+ |    |+---+ |
        +------+      +------+    +------+

The OSDs are not for the exclusive use of the placement group : multiple =
placement groups can use the same OSDs to store their objects. However, t=
he collocation of objects from various placement groups in the same OSD i=
s transparent and is not discussed here.

The placement group does not run as a single daemon as suggested above. I=
nstead it os distributed and resides within each OSD. Whenever an OSD die=
s, the placement group for this OSD is gone and needs to be reconstructed=
 using another OSD.

               OSD 0                                           OSD 1 ...
        +----------------+---- placement group --------+  +------
        |+--- object --+ |+--------------------------+ |  |
        || name : B    | ||  pg_log_entry_t MODIFY   | |  |
        || key : 2     | ||  pg_log_entry_t DELETE   | |  |
        |+-------------+ |+--------------------------+ |  |
        |+--- object --+ >------ last_backfill         |  | ....
        || name : A    | |                             |  |
        || key : 5     | |                             |  |
        |+-------------+ |                             |  |
        |                |                             |  |
        |    ....        |                             |  |
        +----------------+-----------------------------+  +-----


When an object is deleted or modified in the placement group, it is recor=
ded in a log to be replayed if needed. In the simplest case, if an OSD ge=
ts disconnected, reconnects and needs to catch up with the other OSDs, co=
pies of the log entries will be sent to it. However, the logs have a limi=
ted size and it may be more efficient, in some cases, to just copy the ob=
jects over instead of replaying the logs.

Each object name is hashed into an integer that can be used to order them=
=2E For instance, the object B above has been hashed to key 2 and the obj=
ect A above has been hashed to key 5. The last_backfill pointer of the pl=
acement group draws the limit separating the objects that have already be=
en copied from other OSDs and those in the process of being copied. The o=
bjects that are lower than last_backfill have been copied ( that would be=
 object B above ) and the objects that are greater than last_backfill are=
 going to be copied.

It may take time for an OSD to catch up and it is useful to allow replayi=
ng the logs while backfilling. log entries related to objects lower than =
last_backfill are applied. However, log entries related to objects greate=
r than last_backfill are discarded because it is scheduled to be copied a=
t a later time anyway.


--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigF74CA2D0A131C840FD4C6DA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGgprMACgkQ8dLMyEl6F21wqQCfVkjY5Ydk/1pujYOKRE7WiRsd
CYsAn16ogVOy1hxaLZOqBxorvKYnHowk
=9daB
-----END PGP SIGNATURE-----

--------------enigF74CA2D0A131C840FD4C6DA5--
